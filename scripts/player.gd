extends CharacterBody2D

var animation_controller: AnimatedSprite2D
var previous_direction: Vector2

@export var speed = 300
@export var friction = 1
@export var acceleration = 0.1

var can_move: bool
var in_cutscene: bool

func _ready():
	animation_controller = $"AnimatedSprite2D"
	previous_direction = Vector2(0, 0)

	DialogueManager.got_dialogue.connect(handle_dialogue_start)
	DialogueManager.dialogue_ended.connect(handle_dialogue_end)	

	Global.cutscene_start.connect(handle_cutscene_start)
	Global.cutscene_end.connect(handle_cutscene_end)

	can_move = true
	in_cutscene = false

func __running_back():
	animation_controller.play("running_back")

func __running_front():
	animation_controller.play("running_front")

func __running_left():
	animation_controller.play("running_left")
	
func __running_right():
	animation_controller.play("running_right")

func __idle_front():
	animation_controller.play("idle_front")
	
func __idle_down():
	animation_controller.play("idle_down")

func handle_cutscene_start():
	can_move = false
	in_cutscene = true
	
func handle_cutscene_end():
	can_move = true
	in_cutscene = false
	
func handle_dialogue_end(resource):
	can_move = true

func handle_dialogue_start(resource):
	can_move = false

func get_input():
	var input = Vector2()
	
	if !can_move:
		return input
	
	if Input.is_action_pressed("ui_right"):
		input.x += 1
	if Input.is_action_pressed("ui_left"):
		input.x -= 1
	if Input.is_action_pressed("ui_down"):
		input.y += 1
	if Input.is_action_pressed("ui_up"):
		input.y -= 1
	
	return input

func _process(delta):
	if in_cutscene:
		return
	
	var direction = get_input()
	
	# Order matters. Left and right take precedences over top / down.
	if (direction.x < 0 and direction.y >= 0):
		__running_left()
	elif (direction.x < 0 and direction.y <= 0):
		__running_left()
	elif (direction.x > 0 and direction.y >= 0):
		__running_right()
	elif (direction.x > 0 and direction .y <= 0):
		__running_right()
	elif direction.y > 0:
		__running_front()
	elif direction.y < 0:
		__running_back()
	else:
		var current_animation = animation_controller.animation
		animation_controller.play("_".join(["idle", current_animation.split("_")[1]]))
	
	previous_direction = direction
	
func _physics_process(delta):
	var direction = get_input()
	
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	
	move_and_slide()
