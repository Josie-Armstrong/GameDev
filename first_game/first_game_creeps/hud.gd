extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game
signal game_over

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Dodge the Creeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func update_high_score(score):
	$HighScore.text = "High Score: " + str(score)

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()
	
func show_hearts():
	$Hearts.reset_hearts()

func _on_hearts_dead():
	game_over.emit()

func _on_player_hit():
	$Hearts.heart_hit()

func _on_heal():
	$Hearts.heal()
