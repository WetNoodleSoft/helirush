extends CharacterBody2D

@export var acceleration: float = 35.0
@export var top_speed: float = 400.0
@export var friction: float = 5.0


func _physics_process(delta: float) -> void:
	_get_input()
	_decelerate()
	var collision_info = move_and_collide(velocity * delta, true)
	if collision_info:
		_collision_handler(collision_info)
	move_and_collide(velocity * delta)


func _get_input() -> void:
	if Input.is_action_pressed("Left") && (velocity.x > -top_speed):
		velocity.x -= acceleration
	if Input.is_action_pressed("Right"):
		if velocity.x < top_speed:
			velocity.x += acceleration
	if Input.is_action_pressed("Forward"):
		if velocity.y > -top_speed:
			velocity.y -= acceleration
	if Input.is_action_pressed("Back"):
		if velocity.y < top_speed:
			velocity.y += acceleration
	return
	

func _decelerate() -> void:
	velocity = lerp(velocity, Vector2(0.0, 0.0), 0.07)


func _collision_handler(collision_info) -> void:
	var collision_normal = Vector2(collision_info.get_normal())
	var velocity_along_normal: float = velocity.dot(collision_normal)
	if velocity_along_normal < 0:
		velocity -= (collision_normal * velocity_along_normal)
	return
