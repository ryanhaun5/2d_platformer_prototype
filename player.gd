extends CharacterBody2D

# Global variables
const PLAYER_BULLET_SCENE = preload("res://player_bullet.tscn")
const BULLET_CASING_SCENE = preload("res://bullet_casing.tscn")

@export var can_shoot = true

const RUN_SPEED = Global.RUN_SPEED
const WALK_SPEED = Global.WALK_SPEED
const JUMP_VELOCITY = Global.JUMP_VELOCITY
const SHOOT_COOLDOWN = Global.SHOOT_COOLDOWN
const RUN_ACCELERATION = Global.RUN_ACCELERATION
const WALK_ACCELERATION = Global.WALK_ACCELERATION
const GRAVITY_MULTIPLIER = Global.GRAVITY_MULTIPLIER

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * GRAVITY_MULTIPLIER

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		# Change player speed depending on whether they're walking or running
		if Input.is_action_pressed("walk") and abs(velocity.x) <= WALK_SPEED:
			velocity.x += direction * WALK_ACCELERATION
			# Make sure player does not go above max walk speed
			if abs(velocity.x) > WALK_SPEED:
				velocity.x = direction * WALK_SPEED
		else:
			velocity.x += direction * RUN_ACCELERATION
			# Make sure player does not go above max run speed
			if abs(velocity.x) > RUN_SPEED:
				velocity.x = direction * RUN_SPEED
	# Player decelerates to 0 when no movement inputs are pressed
	else:
		velocity.x = move_toward(velocity.x, 0, RUN_ACCELERATION)

	move_and_slide()
	
	# Logic for shooting
	
	# TODO: Work on implementing enemies
	# TODO: Debug aiming and enemy pathfinding
	# TODO: Implement aiming for controller
	# TODO: Implement health and ammo along with medkits and ammo pickups
	# player_bullet includes the raycast and bullet logic
	# bullet_casing is just the physics object that is spawned
	if Input.is_action_just_pressed("shoot"):
		if can_shoot:
			var player_bullet = PLAYER_BULLET_SCENE.instantiate()
			var bullet_casing = BULLET_CASING_SCENE.instantiate()
			player_bullet.global_position = global_position
			player_bullet.global_rotation = global_rotation
			bullet_casing.global_position = global_position
			bullet_casing.global_rotation = global_rotation
			get_parent().add_child(player_bullet)
			get_parent().add_child(bullet_casing)
			# Wait to shoot again until after cooldown
			can_shoot = false
			await get_tree().create_timer(SHOOT_COOLDOWN).timeout
			can_shoot = true
