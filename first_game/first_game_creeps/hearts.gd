extends Node2D

# signal dead

var hearts = 3
var max_hearts = 3
var pos_y = 390

func set_heart(full:bool):
	if full:
		$AnimatedSprite2D.animation = "full"
	else:
		$AnimatedSprite2D.animation = "empty"

#func reset_hearts():
	#hearts = 3
	#$AnimatedSprite2D.animation = "3"
	#position = Vector2(390,35)
	#show()

#func heart_hit():
	#if hearts == 1:
		#print("oops")
		#hearts -= 1
		#hide()
		#dead.emit()
	#else:
		#hearts -= 1
		#pos_y += 30
		#if pos_y > 450 - ((hearts - 1) * 30):
		#pos_y = 450 - ((hearts - 1) * 30)
		#position = Vector2(pos_y,35)
		#$AnimatedSprite2D.animation = str(hearts)
		#print("damaged:" , hearts, " | pos_y: ", pos_y)
		
#func heal():
	#if hearts >= max_hearts:
		#print("too many hearts")
		#return
	#elif hearts <= 0:
		#return
	#else:
		#hearts += 1
		#$AnimatedSprite2D.animation = str(hearts)
		#pos_y -= 30
		#position = Vector2(pos_y, 35)
		#print("new hearts = ", hearts, " | pos_y: ", pos_y)
