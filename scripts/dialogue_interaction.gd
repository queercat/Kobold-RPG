extends Node

@export var dialogue: DialogueResource
@export var dialogue_title: String
@export var is_one_shot : bool = true

@export_group("Multiple Dialogues")
@export var after_n_interactions : int = 0
@export var alt_dialogue: DialogueResource
@export var alt_dialogue_title : String
@export_group("")

var entered_count : int = 0

func _on_body_entered(body):
	if body.name == "Player":
		if is_one_shot and entered_count > 0:
			return
		elif entered_count >= after_n_interactions and alt_dialogue != null:
			DialogueManager.show_dialogue_balloon(alt_dialogue, alt_dialogue_title)
			entered_count += 1
		else:
			DialogueManager.show_dialogue_balloon(dialogue, dialogue_title)
			entered_count += 1
