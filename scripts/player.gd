extends CharacterBody2D

var animation_controller: AnimatedSprite2D
var previous_direction: Vector2

@export var speed = 300
@export var friction = 1
@export var acceleration = 0.1

func _ready():
	animation_controller = $"AnimatedSprite2D"
	previous_direction = Vector2(0, 0)

func get_input():
	var input = Vector2()
	
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
	var direction = get_input()
	
	# Order matters. Left and right take precedences over top / down.
	if (direction.x < 0 and direction.y >= 0):
		animation_controller.play("running_left")
	elif (direction.x < 0 and direction.y <= 0):
		animation_controller.play("running_left")
	elif (direction.x > 0 and direction.y >= 0):
		animation_controller.play("running_right")
	elif (direction.x > 0 and direction .y <= 0):
		animation_controller.play("running_right")
	elif direction.y > 0:
		animation_controller.play("running_front")
	elif direction.y < 0:
		animation_controller.play("running_back")
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
