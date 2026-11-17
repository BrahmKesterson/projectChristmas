
extends CharacterBody2D

@export var move_speed: float = 180.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	# Get movement input
	var direction: Vector2 = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)

	# Move the player
	velocity = direction * move_speed
	move_and_slide()

	# Play the correct animation
	if direction != Vector2.ZERO:
		animated_sprite.play("Walk")
	else:
		animated_sprite.play("Idle")

	# Flip the character based on horizontal direction
	if direction.x < 0:
		animated_sprite.flip_h = true
	elif direction.x > 0:
		animated_sprite.flip_h = false
