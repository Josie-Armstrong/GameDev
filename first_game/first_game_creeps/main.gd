extends Node

signal heal
signal inc_max_hearts
signal lvl_2_start
signal lvl_2_end

@export var mob_scene: PackedScene
var score
var score_delta
var lvl2_time = 5 #Num seconds before player changes to lvl 2
var lvl2_end = 20 #Num seconds before lvl 2 ends
var lvl2_delta = 0 #Tracking score change
var is_lvl_2 = false #keeps track of if we're on the 2nd lvl
# var hearts = 3
var high_score = 0
var color_array = [Color.html("#4a2854"),
Color.html("#342751"),
Color.html("#262c4f"),
Color.html("#26434f"),
Color.html("#254c49"),
Color.html("#244933"),
Color.html("#324723"),
Color.html("#472323")]
@export var col_arr : PackedColorArray
var show_heart_powerup = false
#[Color(0.1216, 0.3569, 0.2980),
#Color(0.1843, 0.1333, 0.2078),
#Color(0.2608, 0.3353, 0.3078),
#Color(0.2706, 0.2941, 0.4),
#Color(0.2863, 0.3020, 0.4078),
#Color(0.3490, 0.2470, 0.3843)]
# var mob_array = []

var mob_difficulty = 0.4

func _ready():
	randomize()
	$Darkness.hide()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HeartPowerupTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	$Player.hide()
	$Player.no_physics()
	
	#lvl_2_end.emit()
	#is_lvl_2 = false
	#lvl2_delta = 0
	#$Darkness.hide()
	#$Powerups.modulate.a = 0.5
	# $UI.lvl_1()
	
	show_heart_powerup = false
	
	if score > high_score:
		high_score = score
		$HUD.update_high_score(score)
		
	$UI.show_icon()

func new_game():
	score = 0
	score_delta = 0
	#$Heal.stop()
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$MobTimer.wait_time = mob_difficulty
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$HUD.reset_hearts()
	get_tree().call_group("mobs", "queue_free")
	$Music.play()
	set_rand_bg_color();
	$Powerups.modulate.a = 0.5
	$HeartPowerupTimer.stop()
	
	$UI.hide_icon()


func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
	#mob.flip_h = true;

	# Choose a random location on Path2D.
	var mob_spawn_x = randi_range(0,1)
	mob.start_x = mob_spawn_x
	# print(mob.start_x);
	if (mob_spawn_x == 1):
		mob_spawn_x = 480
	var mob_spawn_location = Vector2(mob_spawn_x, randi_range(20,700))
	#var mob_spawn_location = $MobPath/MobSpawnLocation
	#mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	mob.position = mob_spawn_location #.position

	# Set the mob's direction perpendicular to the path direction.
	#var direction = mob_spawn_location.rotation + PI / 2
	var direction;
	if mob_spawn_location[0] == 0:
		direction = 0
	else:
		direction = PI

	# Add some randomness to the direction.
	#direction += randf_range(-PI / 4, PI / 4)
	# mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(250.0, 350.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# mob.apply_scale(Vector2(-1,-1))

	# Spawn the mob by adding it to the Main scene.
	
	add_child(mob)
	mob.check_lvl_2(is_lvl_2)

func Lvl2():
	is_lvl_2 = true
	$Darkness.show()
	lvl_2_start.emit()
	$Powerups.modulate.a = 0.9

func Lvl1():
	is_lvl_2 = false
	$Darkness.hide()
	lvl_2_end.emit()
	$Powerups.modulate.a = 0.5


func _on_score_timer_timeout() -> void:
	score += 1
	score_delta += 1
	#lvl2_delta += 1
	$HUD.update_score(score)
	
	# Checks for a max hearts increase
	if score_delta >= 20:
		score_delta = 0
		inc_max_hearts.emit()
	
	#if lvl2_delta >= lvl2_time and !is_lvl_2:
		#Level2Change()
		#lvl2_delta = 0
	#elif lvl2_delta >= lvl2_end and is_lvl_2:
		#lvl2_delta = 0
		#Level2Change()
		


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	$HeartPowerupTimer.start()
	show_heart_powerup = true
	
func set_rand_bg_color():
	#var red = randf_range(0, 0.5)
	#var green = randf()
	#var blue = randf()
	$ColorRect.color = color_array.pick_random()
	# print($ColorRect.color)
	# print($ColorRect.color)

func _on_heart_powerup_timer_timeout():
	# print($Powerups.heart_show)
	$Heal.stop()
	if $Powerups.heart_show == true:
		$Powerups.hide_heart()
	elif show_heart_powerup == true:
		$Powerups.show_heart()


func _on_player_area_entered(_area: Area2D):
	if $Powerups.heart_show == true:
		heal.emit()
		$Heal.play()
		$HeartPowerupTimer.start()

func hud_helvetica_theme():
	$HUD.simple_theme(true)

func hud_pixel_theme():
	$HUD.simple_theme(false)
	
func change_difficulty(difficulty):
	mob_difficulty = difficulty
	# print(difficulty)
