extends KinematicBody2D

const UP = Vector2(0, -1)
const ACCELERATION = 500
const MAX_SPEED = 200
const FRICTION = 400
var gravity = 1200
var velocity = Vector2()
var is_grounded

enum {
	MOVE,
	IDLE
}
var state = MOVE

onready var animationPlayer = $AnimationPlayer
onready var raycasts = $RayCast2D
onready var raycasts2 = $RayCast2D2

	
	
func _physics_process(delta):
	var input_vector = Vector2()
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector = input_vector.normalized()
	is_grounded = _check_is_grounded()
	
	if input_vector != Vector2():
		if input_vector.x > 0:
			animationPlayer.play("run_left")
		elif input_vector.x < 0:
			animationPlayer.play("run_right")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationPlayer.play("idle")
		velocity = velocity.move_toward(Vector2(), FRICTION * delta)
		
	velocity = move_and_slide(velocity)
	velocity.y += gravity * delta
func _input(event):
	if event.is_action_pressed("ui_up") && is_grounded:
		velocity.y = -600


func _check_is_grounded():
	if raycasts.is_colliding() || raycasts2.is_colliding():
		return true
	
	return false
