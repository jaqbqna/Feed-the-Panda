extends RigidBody2D

func _ready():
	var mob_types = Array($Enemy.sprite_frames.get_animation_names())
	$Enemy.animation = mob_types.pick_random()
	$Enemy.play()

func _on_visible_on_screen_notifier_2d_sceen_excited():
	queue_free()
