extends Node

export(PackedScene) var mob_scene
var score
var button: Button
var timer: Timer
var button2: Button
var timer2: Timer
var button3: Button
var timer3: Timer
var button4: Button
var timer4: Timer

func _ready():
	randomize()
	button = $Button
	timer = $Timer
	button2 = $Button2
	timer2= $Timer2
	button3 = $Button3
	timer3= $Timer3
	button4= $Button4
	timer4 = $Timer4
	timer.connect("timeout", self, "_on_timer_timeout")
	button.connect("pressed", self, "_on_button_pressed")
	timer.start()
	
	timer2.connect("timeout", self, "_on_timer_timeout2")
	button2.connect("pressed", self, "_on_button_pressed2")
	timer2.start()
	
	timer3.connect("timeout", self, "_on_timer_timeout3")
	button3.connect("pressed", self, "_on_button_pressed3")
	timer3.start()
	
	timer4.connect("timeout", self, "_on_timer_timeout4")
	button4.connect("pressed", self, "_on_button_pressed4")
	timer4.start()

func _on_timer_timeout():
	button.show()
	$Ad.play()

func _on_timer_timeout2():
	button2.show()
	$Ad.play()

func _on_timer_timeout3():
	button3.show()
	$Ad.play()

func _on_timer_timeout4():
	button4.show()
	$Ad.play()

func _on_button_pressed():
	button.hide()
	timer.start()

func _on_button_pressed2():
	button2.hide()
	timer2.start()

func _on_button_pressed3():
	button3.hide()
	timer3.start()

func _on_button_pressed4():
	button4.hide()
	timer4.start()
	
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$DeathSound.play()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_MobTimer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instance()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)





