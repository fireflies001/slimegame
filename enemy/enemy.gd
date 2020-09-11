extends KinematicBody2D

const UP = Vector2(0, -1)
const ACCELERATION = 200
const MAX_SPEED = 200
const FRICTION = 400
var gravity = 1200
var velocity = Vector2()
var is_grounded
enum {
	ROAM,
	ALERT,
	ATTACK
}
var state = ATTACK

onready var detect_Player = $detect_player
func _physics_process(delta):
	match state:
		ROAM:
			pass
		ALERT:
			pass
		ATTACK:
			var player = detect_Player.player
			if player != null:
				var direction = (player.global_position - global_position)
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	velocity = move_and_slide(velocity)
	velocity.y += gravity * delta
