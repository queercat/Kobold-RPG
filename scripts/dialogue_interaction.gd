extends Node

@export var dialogue: DialogueResource
@export var dialogue_title: String

func _on_body_entered(body):
	if body.name == "Player":
		DialogueManager.show_dialogue_balloon(dialogue, dialogue_title)
