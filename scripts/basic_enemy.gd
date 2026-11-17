
extends CharacterBody2D

enum State { IDLE, CHASE, ATTACK, DEAD }

@export var speed: float = 90.0
@export var detection_range: float = 200.0
@export var attack_range: float = 30.0
@export var health: int = 100
@onready var animated_sprite_2d: AnimatedSprite2D = $Visuals/AnimatedSprite2D


var current_state: State = State.IDLE
var player: CharacterBody2D

func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	player = get_tree().get_first_node_in_group("player") as CharacterBody2D
	randomize_appearance()

func randomize_appearance() -> void:
	var red = randf_range(0.5, 1.0)
	var green = randf_range(0.5, 1.0)
	var blue = randf_range(0.5, 1.0)

	animated_sprite_2d.modulate = Color(red, green, blue)
	
func _physics_process(_delta: float) -> void:
	if not is_instance_valid(player):
		velocity = Vector2.ZERO
		animated_sprite_2d.play("Idle")
		return

	var distance = global_position.distance_to(player.global_position)

	if health <= 0:
		current_state = State.DEAD
	elif distance <= attack_range:
		current_state = State.ATTACK
	elif distance <= detection_range:
		current_state = State.CHASE
	else:
		current_state = State.IDLE

	match current_state:
		State.IDLE:
			velocity = Vector2.ZERO
			animated_sprite_2d.play("Idle")
			

		State.CHASE:
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * speed
			animated_sprite_2d.play("run")
			if direction.x < 0:
				$Visuals.scale.x = -1
			elif direction.x > 0:
				$Visuals.scale.x = 1

		State.ATTACK:
			velocity = Vector2.ZERO
			animated_sprite_2d.play("attack_jab")

		State.DEAD:
			velocity = Vector2.ZERO
			# We'll implement death animation later.

	move_and_slide()
