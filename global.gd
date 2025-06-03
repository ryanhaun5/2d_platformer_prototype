extends Node

# Player global variables
const RUN_SPEED = 600.0
const WALK_SPEED = 300.0
const JUMP_VELOCITY = -500.0
const SHOOT_COOLDOWN = 0.2
const RUN_ACCELERATION = 70
const WALK_ACCELERATION = 35
const GRAVITY_MULTIPLIER = 1.8

#PlayerBullet global variables
const BULLET_DISTANCE = 10000

# Enemy global variables
const ENEMY_SPEED = 300.0
const ENEMY_JUMP_VELOCITY = -400.0
const ENEMY_JUMP_COOLDOWN = 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
