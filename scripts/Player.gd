extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var life : int = 3 setget setLife

enum DIRECTION {UP,RIGHT,DOWN,LEFT}
var directionRotation ={
	DIRECTION.UP:0,
	DIRECTION.RIGHT:90,
	DIRECTION.DOWN:180,
	DIRECTION.LEFT:270,
	}
export var waitShotTime=1

var spawnBasedOnRotation ={
	DIRECTION.UP:0,
	DIRECTION.RIGHT:90,
	DIRECTION.DOWN:180,
	DIRECTION.LEFT:270,
	}
	
var vectorPosition={
	DIRECTION.UP:Vector2(0,-1),
	DIRECTION.RIGHT:Vector2(1,0),
	DIRECTION.DOWN:Vector2(0,1),
	DIRECTION.LEFT:Vector2(-1,0)
}
	
signal dead
signal hit
onready var timer:Timer = get_node("RotationTiming")
onready var shotTimer:Timer = get_node("ShotTiming")
onready var animationPlayer=$AnimationPlayer
var rotationAllow:bool=true
var shotAllow:bool=true
var rotationPos=DIRECTION.UP
signal shot(letterWanted,direction)
signal health_change(vie)
onready var letter=preload("res://scene/LetterFriend.tscn")

func setLife(life):
	
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	shotTimer.wait_time=waitShotTime
	$AudioStreamPlayer2D.autoplay=false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rotate=true
	if rotationAllow:
		if Input.is_action_pressed("ui_right"):
			rotationPos=DIRECTION.RIGHT
		elif Input.is_action_pressed("ui_left"):
			rotationPos=DIRECTION.LEFT
		elif Input.is_action_pressed("ui_up"):
			rotationPos=DIRECTION.UP
		elif Input.is_action_pressed("ui_down"):
			rotationPos=DIRECTION.DOWN
		else:
			rotate=false
		
		if rotate:
			rotationAllow=false
			if(shotTimer.is_stopped()):
				shotAllow=false
			timer.start()
			$Rotation.interpolate_property(self,"rotation_degrees",self.rotation_degrees,directionRotation[rotationPos],0.5)
			$Rotation.start()
		

func _unhandled_input(event):
	if event is InputEventKey:
		if shotAllow:
			var character = char(event.unicode).to_upper()
			if Global.characters.count(character)==1:
				shotAllow=false
				shot(character)
				shotTimer.start()

func shot(letterWanted:String):
	print("shot")
	$AudioStreamPlayer2D.play()
	emit_signal("shot",letterWanted,rotationPos)
	pass

func damage_received():
	emit_signal("hit")
	animationPlayer.play("hit")
	life-=1
	
	if(life==0):
		emit_signal("dead")
	else:
		emit_signal("health_change",life)

func _on_Timer_timeout():
	rotationAllow=true
	pass # Replace with function body.


func _on_Area2D_area_entered(area):
	damage_received()
	pass # Replace with function body.


func _on_ShotTiming_timeout():
	shotAllow=true
	pass # Replace with function body.


func _on_Rotation_tween_all_completed():
	if(shotTimer.is_stopped()):
		shotAllow=true
	pass # Replace with function body.
