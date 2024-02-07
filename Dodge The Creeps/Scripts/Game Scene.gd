extends Node2D

signal start_game
signal stop_score
signal stop_mob
signal destroy_mobs

var start_timer: Timer
var background_music: AudioStreamPlayer2D
var game_over_music: AudioStreamPlayer2D
var mob_group


func _ready():
	new_game()


func _on_start_timer_timeout():
	start_game.emit()
	
	
func _process(_delta):
	mob_group = get_tree().get_nodes_in_group("Mob")


func _on_player_player_hit():
	background_music.stop()
	game_over_music.play()
	stop_mob.emit()
	stop_score.emit()
	destroy_mobs.emit()
	for i in mob_group:
		i.queue_free()
	
	
func new_game():
	start_timer = $"Start Timer"
	start_timer.start()
	background_music = $"Background Music"
	game_over_music = $"Game Over Music"
	background_music.play()
	$Player.start($PlayerStartPosition.position)


func _on_ui_manager_restart():
	new_game()
