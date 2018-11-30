extends CanvasLayer

signal start_game

func update_score(score):
	$MarginContainer/ScoreLabel.text = str(score)

func update_timer(time):
	$MarginContainer/TimeLabel.text = str(time)
	
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_Button_pressed():
	$StartButton.hide()
	$MessageLabel.hide()
	emit_signal("start_game")

func show_game_over():
	show_message("Game over")
	yield($MessageTimer, "timeout")
	$StartButton.show()
	$MessageLabel.text = "Coin dash"
	$MessageLabel.show()
