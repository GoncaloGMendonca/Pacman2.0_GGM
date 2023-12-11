extends Node

@onready var tile_map: TileMap = %TileMap
@onready var player: CharacterBody2D = %Player
@onready var siren_sound: AudioStreamPlayer = %SirenSound
@onready var running_sound: AudioStreamPlayer = %RunningSound
@onready var eat_sound: AudioStreamPlayer = %EatSound

func _ready() -> void:
	GameManager.running_mode_entered.connect(_on_running_mode_entered)
	GameManager.running_mode_ended.connect(_on_running_mode_ended)

func _physics_process(_delta: float) -> void:
	var layer := 1
	var local_position := tile_map.to_local(player.global_position)
	var tile := tile_map.local_to_map(local_position)
	var data := tile_map.get_cell_tile_data(layer,tile)
	
	if not data:
		return
	
	if data.get_custom_data("small_pellet"):
		GameManager.eat_small_pellet()
		tile_map.erase_cell(layer,tile)
		if not eat_sound.playing:
			eat_sound.play()
	elif data.get_custom_data("large_pellet"):
		GameManager.eat_large_pellet()
		tile_map.erase_cell(layer,tile)

func _on_running_mode_entered() -> void:
	siren_sound.stop()
	running_sound.play()

func _on_running_mode_ended() -> void:
	running_sound.stop()
	siren_sound.play()
