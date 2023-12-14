extends Node

signal running_mode_entered
signal running_mode_ending
signal running_mode_ended
signal pacman_died

var score := 0
var lives := 3
var is_running_mode := false

func restart_game() -> void:
	score = 0 
	lives = 3
	is_running_mode = false
	get_tree().change_scene_to_file("res://scenes/Main_menu/main_menu.tscn")

func eat_small_pellet() -> void:
	score += 2

func eat_large_pellet() -> void:
	score += 10 
	_enter_running_mode()

func eat_ghost() -> void:
	score += 100

func _enter_running_mode() -> void:
	is_running_mode = true
	running_mode_entered.emit()
	await get_tree().create_timer(10).timeout
	running_mode_ending.emit()
	await get_tree().create_timer(5).timeout
	running_mode_ended.emit()
	is_running_mode = false
