extends CanvasLayer

var score: int
var score_timer: Timer
var score_label: Label
var message: Label
var restart_button: Button
var count_down: int
var countdown_timer: Timer
var display_countdown: bool
var quit_button: Button

signal restart


func _ready():
	countdown_timer = $"Countdown Timer"
	quit_button = $"Quit Button"
	score_timer = $"Score Timer"
	score_label = $"Score Label"
	message = $Message
	restart_button = $"Restart Button"
	new_game()


func _process(_delta):
	score_label.text = str(score)
	if display_countdown:
		message.text = str(count_down)


func _on_start_timer_timeout():
	score_timer.start()
	message.hide()


func _on_score_timer_timeout():
	score += 1
	
	
func new_game():
	score = 0
	restart_button.hide()
	count_down = 3
	countdown_timer.start()
	display_countdown = true
	quit_button.hide()


func _on_game_scene_stop_score():
	score_timer.stop()
	display_countdown = false
	message.text = "GAME OVER"
	message.show()
	restart_button.show()
	quit_button.show()


func _on_restart_button_pressed():
	restart.emit()
	new_game()


func _on_countdown_timer_timeout():
	count_down -= 1
	
	if count_down < 0:
		countdown_timer.stop()


func _on_quit_button_pressed():
	get_tree().quit()
