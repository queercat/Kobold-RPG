extends Node

var settings = preload("res://addons/dialogue_manager/settings.gd")

@export var dialogue: DialogueResource

# Called when the node enters the scene tree for the first time.
func _ready():
	DialogueManager.show_dialogue_balloon(dialogue, "this_is_a_node_title")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

