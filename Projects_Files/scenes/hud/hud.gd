extends CanvasLayer

@onready var life_1: TextureRect = %Life1
@onready var life_2: TextureRect = %Life2
@onready var life_3: TextureRect = %Life3
@onready var score: Label = %Score

func _process(_delta: float) -> void:
	life_1.visible = GameManager.lives > 0 
	life_2.visible = GameManager.lives > 1 
	life_3.visible = GameManager.lives > 2 
	score.text = str(GameManager.score) + " | " + str(SaveSystem.data.highscore) 
	
	if GameManager.score > 0 and GameManager.score % 1000 == 0:
		_extra_life()

func _extra_life() -> void:
	if GameManager.lives > 3:
		GameManager.lives = 3
	else:
		GameManager.lives += 1
