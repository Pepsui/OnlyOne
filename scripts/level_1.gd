extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_door_body_entered(body, open):
	print("A body has entered the door, will now check what it is")
	print(body.name)
	if (body.name == "Character" && open == true):
		print("You won!")
