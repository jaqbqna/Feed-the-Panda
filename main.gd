extends Node

@export var mob_scene: PackedScene
@export var plant_scene: PackedScene
var score
var best_score = 0

func _ready():
	pass
	
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$PlantTimer.stop()
	$HUD.show_game_over()
	
	$Music.stop()
	$DeathSound.play()
	
	if score > best_score:
		best_score = score
		await get_tree().create_timer(2.0).timeout
		$HUD.update_score(score, best_score)
	
func new_game():
	score = 0
	$Panda.start($StartPosition.position)
	$StartTimer.start()
	
	$HUD.update_score(score, best_score)
	$HUD.show_message("Get Ready")
	
	get_tree().call_group("mobs", "queue_free")
	
	$Music.play()
	
func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score, best_score)
	
func _on_start_timer_timeout():
	$MobTimer.start()
	$PlantTimer.start()
	$ScoreTimer.start()
	

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	mob.position = mob_spawn_location.position
	
	var mob_direction = mob_spawn_location.rotation + PI/2
	
	mob_direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = mob_direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0)
	mob.linear_velocity = velocity.rotated(mob_direction)
	
	add_child(mob)
