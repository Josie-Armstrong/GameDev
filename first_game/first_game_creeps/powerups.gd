extends Area2D

@export var body_type = "heart"
@export var heart_show = true

func _ready():
	$PointLight2D.hide()

func show_heart():
	var pos_x = randi_range(10,470)
	var pos_y = randi_range(10,710)
	position = Vector2(pos_x, pos_y)
	heart_show = true
	show()
	
func hide_heart():
	heart_show = false
	hide()


func _on_main_heal():
	heart_show = false
	hide()


func _on_hud_game_over() -> void:
	hide()

func start_lvl_2():
	$PointLight2D.show()

func end_lvl_2():
	$PointLight2D.hide()
