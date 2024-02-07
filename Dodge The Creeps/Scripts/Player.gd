extends Area2D

var screen_size
var anim: AnimatedSprite2D

const SPEED = 400.0

signal player_hit


func _ready():
	screen_size = get_viewport_rect().size
	anim = $AnimatedSprite2D
	
	
func _physics_process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -1
	if Input.is_action_pressed("move_right"):
		velocity.x = 1
	if Input.is_action_pressed("move_up"):
		velocity.y = -1
	if Input.is_action_pressed("move_down"):
		velocity.y = 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized()
		anim.play()
	else:
		anim.stop()
		
	position += velocity * SPEED * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		anim.play("walk")
		anim.flip_h = velocity.x < 0
		anim.flip_v = false
	elif velocity.y != 0:
		anim.play("up")
		anim.flip_v = velocity.y > 0


func _on_player_hit():
	hide()
	$CollisionShape2D.set_deferred("disabled", true)


func _on_body_entered(_body):
	player_hit.emit()


func _on_ui_manager_restart():
	show()
	$CollisionShape2D.disabled = false
	
	
func start(pos):
	position = pos
