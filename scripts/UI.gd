extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var label=$Control/Label
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_dead():
	pass # Replace with function body.


func _on_Player_health_change(vie):
	label.text=String(vie)
	pass # Replace with function body.
