extends CharacterBody2D

@export var npc_id: String = "unknown"
@export var display_name: String = "Unknown"
@export var dialogue_start_node: String = "start"
@export var npc_color: Color = Color(0.5, 0.5, 0.5, 1.0)

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var name_label: Label = $NameLabel
@onready var prompt_label: Label = $PromptLabel

var player_nearby: bool = false

func _ready() -> void:
	add_to_group("interactable")
	name_label.text = display_name
	prompt_label.visible = false
	sprite.play("idle")
	sprite.modulate = npc_color

func on_interact(_player: Node) -> void:
	# Check for mission-specific dialogue first
	var start_node = get_appropriate_dialogue_node()
	DialogueManager.start_dialogue(npc_id, start_node)

func get_appropriate_dialogue_node() -> String:
	# Check conditions for different dialogue branches
	var trust = TrustManager.get_trust(npc_id)

	# Mission-specific dialogue
	if GameManager.player_data.current_mission == "chapel_theft" and npc_id == "captain_aldric":
		if GameManager.has_completed_mission("chapel_theft"):
			return "start"
		return "mission_report"

	# Trust-based dialogue variations
	if trust >= 75:
		if has_dialogue_node("greeting_allied"):
			return "greeting_allied"
	elif trust < 25:
		if has_dialogue_node("greeting_hostile"):
			return "greeting_hostile"

	return dialogue_start_node

func has_dialogue_node(node_id: String) -> bool:
	# Load dialogue to check if node exists
	var path = "res://data/dialogue/%s_dialogue.json" % npc_id
	if not FileAccess.file_exists(path):
		return false

	var file = FileAccess.open(path, FileAccess.READ)
	var json = JSON.parse_string(file.get_as_text())
	file.close()

	if json and json.has("nodes"):
		return json.nodes.has(node_id)
	return false

func show_prompt() -> void:
	prompt_label.visible = true
	prompt_label.text = "[E] Talk"
	player_nearby = true

func hide_prompt() -> void:
	prompt_label.visible = false
	player_nearby = false

func get_trust() -> int:
	return TrustManager.get_trust(npc_id)

func get_relationship_status() -> String:
	return TrustManager.get_relationship_status(npc_id)
