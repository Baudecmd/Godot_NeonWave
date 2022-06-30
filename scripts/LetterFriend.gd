extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var letterChar: String ="E"
var target
var tween: Tween
var particles2d:Particles2D

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Label").text=letterChar
	particles2d=$Particles2D
	tween = get_node("Tween")
	tween.interpolate_property(self, "position",
	get_position(),target.get_position(),6,
	Tween.TRANS_LINEAR)
	tween.start()
	connect("area_entered", $Area2D, "_touch")
	pass # Replace with function body.

func _on_Area2D_area_entered(area):
	area.touch(letterChar)
	particles2d.restart()
	$Area2D.queue_free()
	$Label.queue_free()
	$ColorRect.queue_free()
	tween.stop_all()
	pass # Replace with function body.


func _on_Tween_tween_completed(object, key):
	die()
	pass # Replace with function body.

func die():
	queue_free()
