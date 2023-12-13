extends CharacterBody2D

const DIRECTIONS := [Vector2.DOWN,Vector2.UP,Vector2.LEFT,Vector2.RIGHT]

@export var speed := 70 
 
var direction := Vector2.UP
var start_position: Vector2

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var stop_move: Timer = %StopMove
@onready var visibility_timer: Timer = %VisibilityTimer

func _ready() -> void:
	GameManager.pacman_died.connect(_restart)
	start_position = global_position
	animated_sprite_2d.set_visible(false)

func _physics_process(delta: float) -> void:
	var collision := move_and_collide(direction * speed * delta)
	if collision:
		direction = _get_next_direction()

func _get_next_direction() -> Vector2:
	return DIRECTIONS.pick_random()

func _restart() -> void:
	speed = 70 
	global_position = start_position
	direction = DIRECTIONS.pick_random()
	_get_next_direction()

func _on_player_detector_body_entered(body: Node2D) -> void:
	print("ETESG")
	GameManager.score += 500
	animated_sprite_2d.set_visible(false)
	_restart()
	animated_sprite_2d.play("cherry")
#	if animated_sprite_2d == "apple":
#		play("apple")
#	elif animated_sprite_2d == "cherry":
#		play("cherry")
#	elif animated_sprite_2d == "pineapple":
#		play("pineapple")
#	elif animated_sprite_2d == "banana":
#		play("banana")
#	else:
#		pass

func _on_stop_move_timeout() -> void:
	speed = 0
	animated_sprite_2d.set_visible(true)
	visibility_timer.start()
	print("START TIMER")

func _on_visibility_timer_timeout() -> void:
	print("TEIMEERAD")
	_restart()
