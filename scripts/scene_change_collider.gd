extends Area2D

@export var target_scene: PackedScene 
@export var override: bool = false

func _on_body_entered(body):
	if not override and body.name == "Player":
		get_tree().change_scene_to_packed(target_scene)
