extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var buttonPlay=get_node("CenterContainer/HBoxContainer/VBoxContainer/Button")
onready var buttonOptions=get_node("CenterContainer/HBoxContainer/VBoxContainer/Button2")
onready var buttonQuit=get_node("CenterContainer/HBoxContainer/VBoxContainer/Button3")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_button_down():
	get_tree().change_scene("res://scene/Game.tscn")
	pass # Replace with function body.


func _on_Button2_button_down():
	get_tree().change_scene("res://scene/Options.tscn")
	pass # Replace with function body.
