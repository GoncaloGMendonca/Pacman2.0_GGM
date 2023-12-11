extends CanvasLayer

func _on_level_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/Level_1/level_1.tscn")

func _on_level_2_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/Level_2/level_2.tscn")

func _on_level_3_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/Level_3/level_3.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
