extends CharacterBody2D

var animation_controller: AnimatedSprite2D
var previous_direction: Vector2

@export var speed = 200
@export var friction = 0.1
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
	if direction.x != 0 && previous_direction.x != direction.x:
		# animation_controler.play("walk_right")
		pass
	elif direction.y != 0 && previous_direction.y != direction.y:
		if direction.y > 0:
			animation_controller.play("running_front")
		else:
			animation_controller.play("running_back")
	elif direction.x == 0 and direction.y == 0:
		animation_controller.play("idle_front")
	
	previous_direction = direction

func _physics_process(delta):
	var direction = get_input()
	
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	
	move_and_slide()
