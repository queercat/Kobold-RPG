extends Area2D

@export var animation_name: String

var animation_player: AnimationPlayer

func _ready():
	animation_player = get_parent().get_node("AnimationPlayer")

func _on_body_entered(body):
	if body.name == "Player":
		Global.cutscene_start.emit()
		await get_tree().create_timer(Global.cutscene_startup_length).timeout
		animation_player.play(animation_name)
		await animation_player.animation_finished
		Global.cutscene_end.emit()		
