extends CharacterBody2D

# TODO: move global constants to project globals
const ENEMY_SPEED = Global.ENEMY_SPEED
const ENEMY_JUMP_VELOCITY = Global.ENEMY_JUMP_VELOCITY
const GRAVITY_MULTIPLIER = Global.GRAVITY_MULTIPLIER
const ENEMY_JUMP_COOLDOWN = Global.ENEMY_JUMP_COOLDOWN

@export var can_jump = true

# TODO: Fix pathing for enemy
# TODO: spawn new one when one is killed with raycast
# TODO: Make enemy walk back and forth when it doesn't see player; when player
# is in view, it targets player
func _physics_process(delta: float) -> void:
	var player = get_tree().get_first_node_in_group("player")
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * GRAVITY_MULTIPLIER
		
	# Make enemy jump if player is more than the enemy's height away from them
	# TODO: Can probably make them stop jumping past their max jump height
	var enemy_height = $EnemySprite.texture.get_height()
	if player.global_position.y < global_position.y - enemy_height and player.global_position.y > global_position.y - (enemy_height * 2) and is_on_floor() and can_jump:
		velocity.y = ENEMY_JUMP_VELOCITY
		can_jump = false
		await get_tree().create_timer(ENEMY_JUMP_COOLDOWN).timeout
		can_jump = true
	
	# Set EnemyNavigationAgent to follow player
	$EnemyNavigationAgent.target_position = player.global_position
	
	# Calculate enemy direction
	var next_path_position: Vector2 = $EnemyNavigationAgent.get_next_path_position()
	var enemy_direction = global_position.direction_to(next_path_position)
	
	# We only care about x since jumping logic covers y
	velocity.x = enemy_direction.x * ENEMY_SPEED
	
	move_and_slide()
