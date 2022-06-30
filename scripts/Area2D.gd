extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal touchDetected(carac)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func touch(carac):
	emit_signal("touchDetected",carac)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
