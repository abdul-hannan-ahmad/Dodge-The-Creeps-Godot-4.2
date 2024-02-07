extends Path2D

var mob_spawn_location: PathFollow2D
var mob_spawn_timer: Timer


func _ready():
	mob_spawn_location = $MobSpawnLocation
	mob_spawn_timer = $"Mob Spawn Timer"


func spawn_mob():
	var mob_scene = preload("res://Scenes/Mob.tscn").instantiate()
	mob_spawn_location.progress_ratio = randf()
	mob_scene.global_position = mob_spawn_location.global_position
	add_child(mob_scene)


func _on_mob_spawn_timer_timeout():
	spawn_mob()


func _on_game_scene_start_game():
	mob_spawn_timer.start()


func _on_game_scene_stop_mob():
	mob_spawn_timer.stop()
