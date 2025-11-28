extends CanvasLayer

@onready var dialogue_panel: Panel = $DialoguePanel
@onready var speaker_label: Label = $DialoguePanel/VBoxContainer/SpeakerLabel
@onready var text_label: RichTextLabel = $DialoguePanel/VBoxContainer/TextLabel
@onready var choices_container: VBoxContainer = $DialoguePanel/VBoxContainer/ChoicesContainer
@onready var trust_popup: Panel = $TrustPopup
@onready var trust_popup_label: Label = $TrustPopup/ChangeLabel

var current_choices: Array = []
var trust_popup_queue: Array = []
var is_showing_popup: bool = false

func _ready() -> void:
	dialogue_panel.visible = false
	trust_popup.visible = false

	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_text_updated.connect(_on_text_updated)
	DialogueManager.dialogue_choices_updated.connect(_on_choices_updated)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	TrustManager.trust_changed.connect(_on_trust_changed)

func _on_dialogue_started(_npc_id: String) -> void:
	dialogue_panel.visible = true

func _on_text_updated(speaker: String, text: String) -> void:
	speaker_label.text = speaker
	text_label.text = text

func _on_choices_updated(choices: Array) -> void:
	current_choices = choices

	# Clear existing choice buttons
	for child in choices_container.get_children():
		child.queue_free()

	# Wait a frame to ensure children are freed
	await get_tree().process_frame

	# Create new choice buttons
	for i in range(choices.size()):
		var choice = choices[i]
		var button = Button.new()
		button.text = "%d. %s" % [i + 1, choice.text]

		# Add trust change preview if available
		if choice.has("trust_changes"):
			var preview_text = ""
			for npc_id in choice.trust_changes:
				var amount = choice.trust_changes[npc_id]
				var sign_str = "+" if amount > 0 else ""
				preview_text += " [%s%d with %s]" % [sign_str, amount, get_npc_name(npc_id)]
			button.text += preview_text

		button.pressed.connect(_on_choice_pressed.bind(i))
		choices_container.add_child(button)

func _on_choice_pressed(index: int) -> void:
	DialogueManager.select_choice(index, current_choices)

func _on_dialogue_ended() -> void:
	dialogue_panel.visible = false
	current_choices = []

func _on_trust_changed(npc_id: String, old_value: int, new_value: int) -> void:
	# Queue floating trust change indicator
	var change = new_value - old_value
	if change != 0:
		trust_popup_queue.append({"npc_id": npc_id, "change": change})
		if not is_showing_popup:
			show_next_trust_popup()

func show_next_trust_popup() -> void:
	if trust_popup_queue.is_empty():
		is_showing_popup = false
		return

	is_showing_popup = true
	var popup_data = trust_popup_queue.pop_front()
	show_trust_popup(popup_data.npc_id, popup_data.change)

func show_trust_popup(npc_id: String, change: int) -> void:
	var sign_str = "+" if change > 0 else ""
	var color = Color.GREEN if change > 0 else Color.RED
	trust_popup_label.text = "%s%d Trust with %s" % [sign_str, change, get_npc_name(npc_id)]
	trust_popup_label.modulate = color
	trust_popup.visible = true

	# Auto-hide after delay
	await get_tree().create_timer(1.5).timeout
	trust_popup.visible = false

	# Show next popup if any
	await get_tree().create_timer(0.2).timeout
	show_next_trust_popup()

func get_npc_name(npc_id: String) -> String:
	# Map NPC IDs to display names
	var names = {
		"captain_aldric": "Captain Aldric",
		"lord_harlan": "Lord Harlan",
		"servant_mira": "Mira"
	}
	return names.get(npc_id, npc_id)

func _input(event: InputEvent) -> void:
	if not dialogue_panel.visible:
		return

	# Number key shortcuts for dialogue choices
	if event is InputEventKey and event.pressed:
		var key_code = event.keycode
		# Check for keys 1-9
		if key_code >= KEY_1 and key_code <= KEY_9:
			var index = key_code - KEY_1
			if index < current_choices.size():
				_on_choice_pressed(index)
