extends Control

func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	if get_tree():
		get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_resume_pressed():
	resume()


func _on_restart_pressed():
	get_tree().reload_current_scene()
	resume()


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Menus/main-menu.tscn")


func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	if Input.is_action_just_pressed("escape") and not get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("escape"):
		resume()
