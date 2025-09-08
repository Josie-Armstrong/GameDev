extends Node2D

signal dead

var hearts = 3

func reset_hearts():
	hearts = 3
	$AnimatedSprite2D.animation = "3"
	position = Vector2(390,35)
	show()

func heart_hit():
	print(hearts)
	if hearts == 3:
		hearts -= 1
		$AnimatedSprite2D.animation = "2"
		position = Vector2(420,35)
	elif hearts == 2:
		hearts -= 1
		$AnimatedSprite2D.animation = "1"
		position = Vector2(450,35)
	elif hearts == 1:
		# print("oops")
		hearts -= 1
		hide()
		dead.emit()
