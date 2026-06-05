extends Node2D

# Assign these values in inspector, else they will be null
@export var grapple_anchor: StaticBody2D
@export var player_anchor: RigidBody2D	
@export var rope: Line2D
@export var interaction_area: Area2D
@export var max_radius: float = 512
@export var tetherForceFactor= 0.25


func _ready():
	add_to_group("grappling-hook-system")
	rope.visible = false
	player_anchor.visible = false

var player_original_parent: Node = null

func attach_player(player: Node2D) -> int:
	if self.global_position.distance_to(player.global_position) > max_radius or player_original_parent != null:
		return -1
	if player.position.x < self.global_position.x+256 and player.position.x >= self.global_position.x-256:
		var anchorPos= $Anchor.global_position
		var playerPos= player.position
		var tetherDir = anchorPos-playerPos
		var tetherDistance = anchorPos.distance_to(player.global_position)
		var tetherXVelocity = tetherDir.x*tetherForceFactor
		player.velocity.x+=tetherXVelocity
		var tetherYVelocity = tetherDir.y*tetherForceFactor
		player.velocity.y+=tetherYVelocity
		
	
	#player_original_parent = player.get_parent()
	#player_anchor.global_position = player.global_position # Set the player_anchor to the player's global position
	#player.reparent(player_anchor) # Make the player a child of player_anchor
	#player.position = Vector2.ZERO
	rope.visible = true
	if rope.visible:
		rope.points[0] = rope.to_local($Anchor.global_position)
		rope.points[1] = rope.to_local(player.global_position)

	
	player_anchor.visible = true
	return 0
	
func get_anchor_point(player: Node2D) -> Vector2:
	var point = Vector2(0,0)
	if player.position.x < self.global_position.x+256 and player.position.x >= self.global_position.x-256:
		point= $Anchor.global_position
	return point

func detach_player(player: Node2D) -> int:
	if player_original_parent == null:
		return -1
	player.reparent(player_original_parent)
	player.velocity = player_anchor.linear_velocity # So it continues its momentum
	player_original_parent = null
	rope.visible = false
	player_anchor.visible = false
	return 0


# Process to handle player input and swinging
func _physics_process(_delta):
	if rope.visible:
		pass
		# Use to_local() to correctly map global positions into Line2D local space
		#rope.points[0] = rope.to_local($Anchor.global_position)
		#rope.points[1] = rope.to_local(player_anchor.global_position)
	#if Input.is_action_pressed("c"):
		
	#if Input.is_action_pressed("d"):
		# if already moving fast, don't move faster
		#if player_anchor.linear_velocity.length() < 400:
		#	player_anchor.apply_central_impulse(
		#	player_anchor.global_transform.x * 64
		#	)  # Push right
	#elif Input.is_action_pressed("a"):
	#	if player_anchor.linear_velocity.length() < 400:
	#		player_anchor.apply_central_impulse(
	#			player_anchor.global_transform.x * -64
		#	)  # Push left
	for child in player_anchor.get_children():
		if "position" in child:
			child.position = Vector2(0,0)
