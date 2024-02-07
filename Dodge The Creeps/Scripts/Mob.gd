extends RigidBody2D

var anim: AnimatedSprite2D
var player
var direction: Vector2

const SPEED = 150.0


func _ready():
	player = get_node("/root/Game Scene/Player")
	anim = $AnimatedSprite2D
	var mob_types = anim.sprite_frames.get_animation_names()
	anim.play(mob_types[randi() % mob_types.size()])
	direction = global_position.direction_to(player.global_position)
	look_at(player.global_position)


func _process(delta):
	global_position += direction * delta * SPEED


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
