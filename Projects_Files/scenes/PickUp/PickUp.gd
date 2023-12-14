extends CharacterBody2D

const DIRECTIONS := [Vector2.DOWN,Vector2.UP,Vector2.LEFT,Vector2.RIGHT]
const SPRITES := ["apple","pineapple","bananas","cherry"]

var speed := 90
var direction := Vector2.UP
var start_position: Vector2

@onready var player_detector: Area2D = %PlayerDetector
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var stop_move: Timer = %StopMove
@onready var visibility_timer: Timer = %VisibilityTimer

func _ready() -> void:
	player_detector.set_collision_mask_value(2,false)
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
	player_detector.set_collision_mask_value(2,false)
	speed = 90 
	global_position = start_position
	direction = DIRECTIONS.pick_random()
	_get_next_direction()
	animated_sprite_2d.set_visible(false)

func _on_player_detector_body_entered(_body: Node2D) -> void:
	GameManager.score += 500
	animated_sprite_2d.set_visible(false)
	_restart()
	animated_sprite_2d.play(SPRITES.pick_random())

func _on_stop_move_timeout() -> void:
	player_detector.set_collision_mask_value(2,true)
	speed = 0
	animated_sprite_2d.set_visible(true)
	visibility_timer.start()

func _on_visibility_timer_timeout() -> void:
	_restart()
