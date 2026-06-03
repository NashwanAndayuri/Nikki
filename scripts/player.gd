extends CharacterBody2D

@export var gravity:float = 98.5
@export var speed:float
@export var jump_speed:float = -700
@export var dash_multiplier: float = 5
@onready var sprite: AnimatedSprite2D = $Animation

var is_grappling: bool = false
var is_grounded = true
var is_moving: bool
var grapable: bool

func is_grapable():
	grapable = true

func is_nnot_grapable():
	grapable = false

func animation():
	var right = Input.is_action_pressed("d")
	var left = Input.is_action_pressed("a")
	var dash = Input.is_action_pressed("lsft")
	
	
	if right:
		sprite.play("run")
	elif left:
		sprite.play("run")
	elif velocity.x == 0 and velocity.y > 0 and $RayCast2D.is_colliding and !is_on_floor():
		sprite.play("land")
	elif is_on_floor():
		sprite.play("idle")
	
func side_move():
	
		if is_on_floor():
			velocity.x = 0
		var right = Input.is_action_pressed("d")
		var left = Input.is_action_pressed("a")
		var dash = Input.is_action_pressed("lsft")
	
		if not velocity.x == 0 or not velocity.y == 0:
			is_moving = true
	
		if right:
			velocity.x = speed * 1.5
			sprite.scale.x = 1.0
		if left:
			velocity.x = -1 * speed * 1.5
			sprite.scale.x = -1.0
		if right and dash:
			velocity.x = speed * dash_multiplier
		if left and dash:
			velocity.x = -1 * speed * dash_multiplier


func jump():
	var jump = Input.is_action_just_pressed("spc")
	

	if jump and is_on_floor():
		velocity.y = jump_speed
		sprite.play("jump")

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity = velocity + get_gravity() * delta * 2
	
	if Input.is_action_pressed("C"):
		is_grappling = true
		for grappling_hook_system in get_tree().get_nodes_in_group("grappling-hook-system"):
			var success = grappling_hook_system.attach_player(self)
			if success == 0:
				break	
	elif Input.is_action_just_released("C"):
		is_grappling = false
		for grappling_hook_system in get_tree().get_nodes_in_group("grappling-hook-system"):
			var success = grappling_hook_system.detach_player(self)
			if success == 0:

				break
	if not is_grappling:
		side_move()
	animation()
	jump()
	move_and_slide()
	
	
	global_rotation = 0
