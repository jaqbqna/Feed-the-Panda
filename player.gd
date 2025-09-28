extends Area2D
signal hit
signal hit_plant

@export var speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$PandaAnimation.play()
	else:
		$PandaAnimation.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$PandaAnimation.animation = "walk"
		$PandaAnimation.flip_v = false
	elif velocity.y !=0:
		$PandaAnimation.animation = "up"
		

	if velocity.x < 0:
		$PandaAnimation.flip_h = true
	else:
		$PandaAnimation.flip_h = false

func _on_body_entered(_body):
	hide()
	hit.emit()
	$CollisionShapePanda.set_deferred("disabled", true)
	

func start(pos):
	position = pos
	show()
	$CollisionShapePanda.disabled = false
