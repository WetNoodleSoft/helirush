extends Node

@export var acceleration: float = 42.0
@export var air_resistance: float = 4.5
@onready var character: CharacterBody2D = $".."

@onready var velocity = Vector2(character.velocity)

func _physics_process(delta: float) -> void:
	_get_input()
	_decelerate(delta)
	var collision_info: KinematicCollision2D = character.move_and_collide(velocity * delta, true)
	if collision_info:
		_collision_handler(collision_info)
	character.move_and_collide(velocity * delta)


func _get_input() -> void:
	var input_vector = Vector2(Input.get_vector("Left", "Right", "Forward", "Back"))
	velocity += (input_vector * acceleration * (1 + sqrt(velocity.length())/(1 + velocity.length())))
	return
	

func _decelerate(delta) -> void:
	velocity *= exp(-air_resistance * delta)


func _collision_handler(collision_info) -> void:
	var collision_normal = Vector2(collision_info.get_normal())
	var velocity_along_normal: float = velocity.dot(collision_normal)
	if velocity_along_normal < 0:
		velocity -= (collision_normal * velocity_along_normal)
	return
