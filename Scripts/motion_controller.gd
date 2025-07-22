extends Node2D
class_name MotionController

@export var acceleration: float = 42.0
@export var air_resistance: float = 4.5

enum entity_types{PLAYER, ENEMY, ALLY, NEUTRAL, STATIC}

@onready var parent_entity: Entity = $".."
@onready var velocity = Vector2(parent_entity.velocity)
@onready var my_type = parent_entity.entity_type


func _ready() -> void:
	print(my_type)
	pass


func _physics_process(delta: float) -> void:
	_get_input()
	_decelerate(delta)
	var collision_info: KinematicCollision2D = parent_entity.move_and_collide(velocity * delta, true)
	if collision_info:
		_collision_handler(collision_info)
	parent_entity.move_and_collide(velocity * delta)


func _get_input() -> void:
	match my_type:
		entity_types.PLAYER:
			var input_vector = Vector2(Input.get_vector("Left", "Right", "Forward", "Back"))
			velocity += (input_vector * acceleration * (1 + sqrt(velocity.length())/(1 + velocity.length())))
			return
		entity_types.ENEMY:
			return
		entity_types.ALLY:
			return
		entity_types.NEUTRAL:
			return
		entity_types.STATIC:
			return
	print("null type")
	return
	

func _decelerate(delta) -> void:
	velocity *= exp(-air_resistance * delta)


func _collision_handler(collision_info) -> void:
	var collision_normal = Vector2(collision_info.get_normal())
	var velocity_along_normal: float = velocity.dot(collision_normal)
	if velocity_along_normal < 0:
		velocity -= (collision_normal * velocity_along_normal)
	return
