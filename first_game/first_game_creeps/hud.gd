extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game
signal game_over

var heart_array = []
var max_hearts = 3
var current_hearts = 3
var heart_y = 35
var hearts_already_set = false
var new_heart_row = 0
var new_heart_column = 0

var heart_obj = preload("res://hearts.tscn")

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
	
func reset_hearts():
	$Hearts.hide()
	
	# Getting rid of the additional hearts
	if max_hearts > 3:
		for i in range(3, max_hearts):
			heart_array[i].queue_free()
	
	# Resetting max and current hearts
	max_hearts = 3
	current_hearts = 3
	new_heart_row = 0
	new_heart_column = 0
	
	for i in max_hearts:
		
		if hearts_already_set == false: #creating new objects when game starts
			print(i)
			var temp_heart = heart_obj.instantiate()
			add_child(temp_heart)
			heart_array.append(temp_heart)
			# heart_array.append($Hearts.duplicate(4))
			var temp_x = 450 - ((i) * 50)
			heart_array[i].position = Vector2(temp_x, heart_y)
		
		#refilling hearts
		heart_array[i].set_heart(true)
		heart_array[i].show()
	
	hearts_already_set = true
		
	#$Hearts.reset_hearts()
	
	print(heart_array[0].position)

# func _on_hearts_dead():
	#game_over.emit()

func _on_player_hit():
	#$Hearts.heart_hit()
	current_hearts -= 1
	heart_array[current_hearts].set_heart(false)
	
	if current_hearts <= 0:
		game_over.emit()

func _on_heal():
	#$Hearts.heal()
	if current_hearts < max_hearts:
		current_hearts += 1
		heart_array[current_hearts - 1].set_heart(true)
	else:
		print("too many hearts")
		return

# When player reaches the next level of hearts
func _on_main_inc_max_hearts():
	#Checking heart row
	if max_hearts % 3 == 0:
		new_heart_row += 1
		print(new_heart_row)
	
	max_hearts += 1
	
	var temp_heart = heart_obj.instantiate()
	add_child(temp_heart)
	heart_array.append(temp_heart)
	heart_array[max_hearts - 1].set_heart(false)
	
	#Refilling health all the way
	#current_hearts = max_hearts
	#for item in heart_array:
		##print("worked")
		#item.set_heart(true)
	
	heart_array[max_hearts - 1].show()
	
	#Setting position of heart based on row and column
	var temp_y = 35 + (50 * new_heart_row)
	var temp_x = 450 - (50 * new_heart_column)
	heart_array[max_hearts - 1].position = Vector2(temp_x, temp_y)
	#print(heart_array[max_hearts - 1].position)
	
	#Checking which column the next heart will be in
	if new_heart_column + 1 > 2:
		new_heart_column = 0
	else:
		new_heart_column += 1
	
