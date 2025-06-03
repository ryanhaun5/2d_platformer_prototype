extends Node2D

# Global variables
@onready var bullet_ray_cast = get_node("BulletRayCast")
@onready var bullet_trail = get_node("BulletTrail")

# TODO: Move global constants to project globals
const BULLET_DISTANCE = Global.BULLET_DISTANCE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Make bullet's RayCast2D look at mouse's direction and scale it by distance
	bullet_ray_cast.target_position = get_global_mouse_position().normalized() * BULLET_DISTANCE
	
	# Create bullet trail from player to where player is aiming
	bullet_trail.add_point(bullet_ray_cast.position)
	bullet_trail.add_point(bullet_ray_cast.target_position)
	bullet_ray_cast.force_raycast_update()
	var collided_object = bullet_ray_cast.get_collider()
	# TODO: Add different collision layers for enemies and surfaces
	if collided_object != null:
		collided_object.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Delete raycast and trail
func _on_bullet_ray_cast_timer_timeout() -> void:
	bullet_ray_cast.queue_free()
	bullet_trail.queue_free()
