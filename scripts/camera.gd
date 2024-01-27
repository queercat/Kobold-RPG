extends Camera2D

var player: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	pass # Replace with function body.

func _physics_process(delta):
	position = position.lerp(player.position, .05)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
