extends Node

@export var dialogue: DialogueResource
@export var dialogue_entry_point: String

signal entered_dialogue

func _on_body_entered(body):
	DialogueManager.show_dialogue_balloon(dialogue, dialogue_entry_point)
