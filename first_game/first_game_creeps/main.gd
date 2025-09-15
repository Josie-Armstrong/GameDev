extends Node

signal heal
signal inc_max_hearts

@export var mob_scene: PackedScene
var score
var score_delta
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
#[Color(0.1216, 0.3569, 0.2980),
#Color(0.1843, 0.1333, 0.2078),
#Color(0.2608, 0.3353, 0.3078),
#Color(0.2706, 0.2941, 0.4),
#Color(0.2863, 0.3020, 0.4078),
#Color(0.3490, 0.2470, 0.3843)]

func _ready():
	randomize()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	$Player.hide()
	$Player.no_physics()
	
	if score > high_score:
		high_score = score
		$HUD.update_high_score(score)

func new_game():
	score = 0
	score_delta = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$HUD.reset_hearts()
	get_tree().call_group("mobs", "queue_free")
	$Music.play()
	set_rand_bg_color();
	$Powerups.modulate.a = 0.5


func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)


func _on_score_timer_timeout() -> void:
	score += 1
	score_delta += 1
	$HUD.update_score(score)
	
	# Checks for a max hearts increase
	if score_delta >= 20:
		score_delta = 0
		inc_max_hearts.emit()


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	$HeartPowerupTimer.start()
	
func set_rand_bg_color():
	#var red = randf_range(0, 0.5)
	#var green = randf()
	#var blue = randf()
	$ColorRect.color = color_array.pick_random()
	print($ColorRect.color)
	# print($ColorRect.color)

func _on_heart_powerup_timer_timeout():
	# print($Powerups.heart_show)
	if $Powerups.heart_show == true:
		$Powerups.hide_heart()
	else:
		$Powerups.show_heart()


func _on_player_area_entered(_area: Area2D):
	if $Powerups.heart_show == true:
		heal.emit()
		$HeartPowerupTimer.start()
