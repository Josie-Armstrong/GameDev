extends RigidBody2D

# @export var body_type = "enemy"

@export var start_x = 0;

func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	#$AnimatedSprite2D.animation = mob_types.pick_random()
	#$AnimatedSprite2D.play()
	
	#start_x = randi_range(0,1);
	#print(start_x)
	
	if start_x == 0:
		var anim_array = [mob_types[1], mob_types[3], mob_types[5]]
		$AnimatedSprite2D.animation = anim_array.pick_random()
	else:
		var anim_array = [mob_types[0], mob_types[2], mob_types[4]]
		$AnimatedSprite2D.animation = anim_array.pick_random()
	
	$AnimatedSprite2D.play()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
