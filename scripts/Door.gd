extends Area2D

var open: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_lever_open_object():
	print("I got the lever signal!")
	open = true
	print(open)
