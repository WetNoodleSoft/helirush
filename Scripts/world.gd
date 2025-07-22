extends Node2D

@onready var chopper = preload("res://Scenes/player.tscn")
@onready var label: Label = $CanvasLayer/Label
@onready var player
@onready var world: Node2D = $"."


func _ready() -> void:
	player = chopper.instantiate()
	add_child(player)
	player.position = Vector2(640, 650)
	

func _process(_delta: float) -> void:
	label.text = (str(round(player.velocity.x)) + " , " + str(round(player.velocity.y)))
	
