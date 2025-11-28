extends Node2D

@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var current_level: Node2D = $CurrentLevel
@onready var camera: Camera2D = $Camera2D

var player: CharacterBody2D = null

func _ready() -> void:
	# Connect to time changes for day/night cycle
	TimeManager.time_changed.connect(_on_time_changed)

	# Apply initial time color
	update_time_visual()

	# Find player in the level
	find_player()

func _on_time_changed(_new_time: int, _day: int) -> void:
	update_time_visual()

func update_time_visual() -> void:
	var target_color = TimeManager.get_current_color()
	# Tween the color change for smooth transition
	var tween = create_tween()
	tween.tween_property(canvas_modulate, "color", target_color, 1.0)

func find_player() -> void:
	# Find the player node in the current level (search recursively)
	player = find_node_by_name(current_level, "Player")
	if player:
		# Make camera follow player
		camera.position = player.position

func find_node_by_name(root: Node, node_name: String) -> Node:
	for child in root.get_children():
		if child.name == node_name:
			return child
		var found = find_node_by_name(child, node_name)
		if found:
			return found
	return null

func _process(_delta: float) -> void:
	# Camera follows player
	if player:
		camera.position = camera.position.lerp(player.position, 0.1)

func _input(event: InputEvent) -> void:
	# Debug keys for testing
	if event.is_action_pressed("ui_page_down"):
		# Advance time (debug)
		TimeManager.advance_time()
		print("Time advanced to: ", TimeManager.get_time_string())

	if event.is_action_pressed("ui_page_up"):
		# Test combat (debug)
		test_combat()

	if event.is_action_pressed("ui_home"):
		# Save game (debug)
		GameManager.save_game()
		print("Game saved!")

	if event.is_action_pressed("ui_end"):
		# Load game (debug)
		if GameManager.load_game():
			print("Game loaded!")
		else:
			print("No save file found")

func test_combat() -> void:
	var combat_ui = get_node_or_null("UILayer/CombatUI")
	if combat_ui:
		var test_enemy = {
			"combat_skill": 8,
			"weapon_bonus": 3,
			"armor_bonus": 2
		}
		combat_ui.start_combat("Test Bandit", test_enemy)
