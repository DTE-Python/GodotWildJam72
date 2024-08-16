extends Control



func _on_play_pressed():
	get_tree().change_scene_to_file("res://Levels/Level_1.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Menus/options-menu.tscn")


func _on_levels_pressed():
	get_tree().change_scene_to_file("res://Menus/levels.tscn")


func _on_exit_pressed():
	get_tree().quit()
