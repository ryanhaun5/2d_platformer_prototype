extends Sprite2D

const SHOOT_COOLDOWN = Global.SHOOT_COOLDOWN

@export var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	
	# TODO: This part can almost def be refactored to be combined with the
	# rest of the shooting logic but just throwing this together for prototype
	if Input.is_action_just_pressed("shoot"):
		if can_shoot:
			# Play animation here
			$ReticleAnimation.play("shoot")
			can_shoot = false
			await get_tree().create_timer(SHOOT_COOLDOWN).timeout
			can_shoot = true
