extends Node

const SAVE_PATH := "user://save.res"

var data := SaveData.new()

func _ready() -> void:
	load_data()

func save_data() -> void:
	ResourceSaver.save(data,SAVE_PATH)

func load_data() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		data = ResourceLoader.load(SAVE_PATH)
