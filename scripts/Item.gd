extends Node2D

@export var _name: String
@export var _description: String
@export var _sprite: Texture2D

var sprite_node: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Sprite2D".texture = _sprite
