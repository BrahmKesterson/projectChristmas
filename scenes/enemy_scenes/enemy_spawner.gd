extends Node2D

@export var enemy_types: Array[PackedScene] = []

func spawn_enemy() -> void:
	if enemy_types.is_empty():
		push_warning("No enemy types assigned to spawner!")
		return

	# Pick a random enemy scene
	var selected_scene: PackedScene = enemy_types.pick_random()

	# Create the enemy
	var enemy = selected_scene.instantiate()

	# Add it to the current level
	get_parent().add_child.call_deferred(enemy)

	# Place it at the spawner's position
	enemy.global_position = global_position
	
func _ready() -> void:
		spawn_enemy()
