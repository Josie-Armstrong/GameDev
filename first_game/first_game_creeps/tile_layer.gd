extends Node2D

func _ready():
	$BaseTiles.show()
	$FunHills.show()
	$LavaRock.hide()
	$RockObstacles.hide()
	
func start_lvl_2():
	$BaseTiles.hide()
	$FunHills.hide()
	$LavaRock.show()
	$RockObstacles.show()

func end_lvl_2():
	$BaseTiles.show()
	$FunHills.show()
	$LavaRock.hide()
	$RockObstacles.hide()
