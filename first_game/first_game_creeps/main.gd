extends Node

@export var mob_scene: PackedScene
var score
# var hearts = 3
var high_score = 0
var color_array = [Color(0.12156862745098039, 0.3568627450980392, 0.2980392156862745),
Color(0.1843137254901961, 0.13333333333333333, 0.20784313725490197),
Color(0.5372549019607843, 0.8235294117647058, 0.8627450980392157),
Color(1, 0.8941176470588236, 0.9803921568627451),
Color(0.48627450980392156, 0.5019607843137255, 0.6078431372549019)]

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
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$HUD.show_hearts()
	get_tree().call_group("mobs", "queue_free")
	$Music.play()
	set_rand_bg_color();


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
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	
func set_rand_bg_color():
	#var red = randf_range(0, 0.5)
	#var green = randf()
	#var blue = randf()
	$ColorRect.color = color_array.pick_random()
	print($ColorRect.color)
