extends Node3D

signal Loading

func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		print("loading level: " + str(get_tree().current_scene.get_name().to_int() + 1) + ".tscn")
		emit_signal("Loading")
		get_tree().change_scene_to_file("res://Levels/Level_" + str(get_tree().current_scene.get_name().to_int() + 1) + ".tscn")

