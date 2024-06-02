extends CharacterBody2D

signal movementDirection

@export var run_speed = 150
@export var jump_velocity = -400.0
var previous_moves: Array[String] 
enum {IDLE, RUN, JUMP, HURT, DEAD}

var state = IDLE

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func change_state(new_state):
	state = new_state
	match state:
		IDLE:
			$AnimationPlayer.play("idle")
		RUN:
			$AnimationPlayer.play("run")
			print("run anim")
		DEAD:
			hide()


func _ready():
	change_state(IDLE)


func move_right():
	velocity.x = run_speed
	$Sprite2D.flip_h = false 


func move_left():
	velocity.x = -run_speed
	$Sprite2D.flip_h = true 


func run_input(direction):
	if direction == "right":
		move_right()
	if direction == "left":
		move_left()
	if direction == "stop":
		velocity.x = 0
	if direction == "jump":
		velocity.y = jump_velocity
	if state == IDLE and velocity.x != 0:
		change_state(RUN)
	if state == RUN and velocity.x == 0:
		change_state(IDLE)


func _physics_process(delta):
	var current_move: int = 0
	velocity.y += gravity * delta
	move_and_slide()
	
	


func play_input(moves):
	var current_move: int = 0
	while current_move < moves.size() - 1:
		run_input(moves[current_move])
		current_move += 1

func _on_character_movement_direction(direction):
	previous_moves.append(direction)
	run_input(direction)

#
#func _on_character_run_clone_moves():
	#play_input(previous_moves) 
