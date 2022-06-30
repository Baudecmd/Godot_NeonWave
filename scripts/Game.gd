extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


export onready var waveDuration=10
var WaveNumber=1
onready var timer=get_node("Timer")
onready var letter=preload("res://scene/Letter.tscn")
onready var letterTemplate=preload("res://scene/LetterFriend.tscn")
enum SPAWN_POINTS {
	NORTH,
	EAST,
	SOUTH,
	WEST
}

var numberSpawned=0
onready var spawnPoints= {SPAWN_POINTS.NORTH:get_node("spawnNorth"),
SPAWN_POINTS.SOUTH:get_node("spawnSouth"),
SPAWN_POINTS.EAST:get_node("spawnEast"),
SPAWN_POINTS.WEST:get_node("spawnWest")}

func _ready():
	$SpawnUpgrade.start(waveDuration)
	timer.start(timer.wait_time-(0.005*WaveNumber))
	pass # Replace with function body.

func _on_Timer_timeout():
	print("oki")
	randomize()
	var letterEnemy=letter.instance()
	var randomLetter=randi() % Global.characters.length()
	letterEnemy.letterChar=Global.characters[randomLetter]
	letterEnemy.player=get_node("Player")
	var randomPos=randi() % spawnPoints.keys().size()
	var pos = spawnPoints[randomPos].get_position()
	letterEnemy.spawn=randomPos	
	letterEnemy.set_position(pos)
	add_child(letterEnemy)
	numberSpawned+=1
	timer.start(timer.wait_time-(0.005*WaveNumber))
	pass # Replace with function body.


func _on_Player_shot(letterWanted, direction):
	var letterFriend=letterTemplate.instance()
	letterFriend.letterChar=letterWanted
	letterFriend.target=spawnPoints[direction]
	add_child(letterFriend)


func _on_SpawnUpgrade_timeout():
	WaveNumber+=1
	print(WaveNumber)
	pass # Replace with function body.
