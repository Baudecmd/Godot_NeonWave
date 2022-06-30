extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var letterChar: String ="E"
var player
var tween: Tween
var particles2d:Particles2D
var spawn
var audio: AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Trailing.set_process_material($Trailing.get_process_material().duplicate())
	get_node("Label").text=letterChar
	particles2d=$Particle
	tween = get_node("Tween")
	tween.interpolate_property(self, "position",
	get_position(),player.get_position(),4,
	Tween.TRANS_LINEAR)
	tween.start()
	set_trailing()
	pass # Replace with function body.

func set_trailing():
	if(spawn==0):
		$Trailing.get_process_material().direction=Vector3(0,-10,0)
	elif(spawn==1):
		$Trailing.get_process_material().direction=Vector3(10,0,0)
	elif(spawn==2):
		$Trailing.get_process_material().direction=Vector3(0,10,0)
	else:
		$Trailing.get_process_material().direction=Vector3(-10,0,0)

func test():
	print("touché lettre")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func die():
	particles2d.restart()
	$Trailing.queue_free()
	$AudioStreamPlayer2D.play()
	$areaLetter.queue_free()
	$Label.queue_free()
	$"NicePng_asteroids-png_2168169".queue_free()
	tween.stop_all()

func _on_Area2D_touchDetected(carac):
	if carac==letterChar:
		die()
	else:
		$AudioStreamPlayer2D.play()
	pass # Replace with function body.


func _on_areaLetter_area_entered(area):
	print("hello")
	die()
	pass # Replace with function body.
