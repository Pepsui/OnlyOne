extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
var state = 0 # will always be either 1 or 0

signal open_object
signal close_object

# Called when the node enters the scene tree for the first time.
func _ready():
	state = 0
	print("State is: ")
	print(state)
	animated_sprite.play("default-off")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print("character is passing, checking state")
	print(body.name)
	if (body.name == "Character"):
		if (state == 0):
			animated_sprite.play("on")
			animated_sprite.play("default-on")
			state = 1
			open_object.emit()
		else:
			if (state == 1):
				animated_sprite.play("off")
				animated_sprite.play("default-off")
				state = 0
				close_object.emit()
