extends Node

var current_dialogue: Dictionary = {}
var current_node_id: String = ""
var dialogue_active: bool = false

signal dialogue_started(npc_id: String)
signal dialogue_text_updated(speaker: String, text: String)
signal dialogue_choices_updated(choices: Array)
signal dialogue_ended

func _ready() -> void:
	print("DialogueManager initialized")

func load_dialogue(npc_id: String) -> bool:
	var path = "res://data/dialogue/%s_dialogue.json" % npc_id
	if not FileAccess.file_exists(path):
		push_error("Dialogue file not found: " + path)
		return false

	var file = FileAccess.open(path, FileAccess.READ)
	var json = JSON.parse_string(file.get_as_text())
	file.close()

	if json:
		current_dialogue = json
		return true
	return false

func start_dialogue(npc_id: String, start_node: String = "start") -> void:
	if load_dialogue(npc_id):
		dialogue_active = true
		current_node_id = start_node
		dialogue_started.emit(npc_id)
		process_current_node()

func process_current_node() -> void:
	if not dialogue_active or current_node_id.is_empty():
		end_dialogue()
		return

	var node = current_dialogue.get("nodes", {}).get(current_node_id)
	if not node:
		push_error("Dialogue node not found: " + current_node_id)
		end_dialogue()
		return

	var speaker = node.get("speaker", "???")
	var text = node.get("text", "")
	dialogue_text_updated.emit(speaker, text)

	var choices = node.get("choices", [])
	if choices.is_empty():
		# No choices means end of dialogue or auto-continue
		var next_node = node.get("next", "")
		if next_node.is_empty():
			# Show "Continue" to end
			dialogue_choices_updated.emit([{"text": "Continue", "next": ""}])
		else:
			dialogue_choices_updated.emit([{"text": "Continue", "next": next_node}])
	else:
		dialogue_choices_updated.emit(choices)

func select_choice(choice_index: int, choices: Array) -> void:
	if choice_index < 0 or choice_index >= choices.size():
		return

	var choice = choices[choice_index]

	# Apply trust changes if specified
	if choice.has("trust_changes"):
		for npc_id in choice.trust_changes:
			var amount = choice.trust_changes[npc_id]
			TrustManager.modify_trust(npc_id, amount)

	# Apply other effects
	if choice.has("effects"):
		apply_effects(choice.effects)

	# Move to next node
	var next_node = choice.get("next", "")
	if next_node.is_empty():
		end_dialogue()
	else:
		current_node_id = next_node
		process_current_node()

func apply_effects(effects: Dictionary) -> void:
	if effects.has("coins"):
		GameManager.modify_coins(effects.coins)
	if effects.has("skill"):
		for skill_name in effects.skill:
			GameManager.modify_skill(skill_name, effects.skill[skill_name])
	if effects.has("start_mission"):
		GameManager.start_mission(effects.start_mission)
	if effects.has("complete_mission"):
		GameManager.complete_mission(effects.complete_mission)
	if effects.has("guard_rank"):
		GameManager.modify_guard_rank(effects.guard_rank)

func end_dialogue() -> void:
	dialogue_active = false
	current_dialogue = {}
	current_node_id = ""
	dialogue_ended.emit()
