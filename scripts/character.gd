extends CharacterBody2D

signal movementDirection
signal run_clone_moves

@export var run_speed = 150
@export var jump_velocity = -400.0
var velocity_changer = 40000

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
		DEAD:
			hide()


func _ready():
	change_state(IDLE)


func move_right():
	velocity.x += run_speed
	$Sprite2D.flip_h = false 
	movementDirection.emit("right")


func move_left():
	velocity.x -= run_speed
	$Sprite2D.flip_h = true 
	movementDirection.emit("left")

func get_input():
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_pressed("jump")
	
	if state == HURT:
		return
	velocity.x = 0
	if right:
		move_right()
	if left:
		move_left()
	if Input.is_anything_pressed() == false:
		velocity.x = 0
		movementDirection.emit("stop")
	if jump and is_on_floor():
		velocity.y = jump_velocity
		movementDirection.emit("jump")
	if state == IDLE and velocity.x != 0:
		change_state(RUN)
	if state == RUN and velocity.x == 0:
		change_state(IDLE)


func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	move_and_slide()
