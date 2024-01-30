extends Camera2D

var player: Node2D
var animation_player: AnimationPlayer
var in_cutscene: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player = $"AnimationPlayer"
	player = get_parent().get_node("Player")
	in_cutscene = false
	
	Global.cutscene_start.connect(cutscene_start)
	Global.cutscene_end.connect(cutscene_end)

func _physics_process(delta):
	if not in_cutscene:
		position = position.lerp(player.position, .05)

func cutscene_start():
	animation_player.play("cutscene_start")
	in_cutscene = true
	
func cutscene_end():
	animation_player.play("cutscene_end")
	in_cutscene = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
