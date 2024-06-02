extends Node2D

var previous_moves: Array[String] 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("replay"):
		for moves in previous_moves.size():
			$Character2.run_input(previous_moves[moves])


func _on_door_body_entered(body, open):
	print("A body has entered the door, will now check what it is")
	print(body.name)
	if (body.name == "Character" && open == true):
		print("You won!")

func _on_character_movement_direction(direction):
	previous_moves.append(direction)
