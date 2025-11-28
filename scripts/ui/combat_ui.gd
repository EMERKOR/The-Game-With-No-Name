extends CanvasLayer

@onready var combat_panel: Panel = $CombatPanel
@onready var player_stats_label: RichTextLabel = $CombatPanel/VBoxContainer/StatsContainer/PlayerStats
@onready var enemy_stats_label: RichTextLabel = $CombatPanel/VBoxContainer/StatsContainer/EnemyStats
@onready var probability_label: Label = $CombatPanel/VBoxContainer/ProbabilityLabel
@onready var result_panel: Panel = $CombatPanel/VBoxContainer/ResultPanel
@onready var result_label: Label = $CombatPanel/VBoxContainer/ResultPanel/ResultLabel
@onready var dice_label: Label = $CombatPanel/VBoxContainer/DiceLabel
@onready var fight_button: Button = $CombatPanel/VBoxContainer/ButtonContainer/FightButton
@onready var flee_button: Button = $CombatPanel/VBoxContainer/ButtonContainer/FleeButton

var current_player_stats: Dictionary = {}
var current_enemy_stats: Dictionary = {}
var current_enemy_name: String = ""

signal combat_resolved(result: Dictionary)

func _ready() -> void:
	combat_panel.visible = false
	result_panel.visible = false
	fight_button.pressed.connect(_on_fight_pressed)
	flee_button.pressed.connect(_on_flee_pressed)

func start_combat(enemy_name: String, enemy_stats: Dictionary) -> void:
	current_enemy_name = enemy_name
	current_enemy_stats = enemy_stats
	current_player_stats = get_player_combat_stats()

	# Update UI
	player_stats_label.text = format_stats("Erwin", current_player_stats)
	enemy_stats_label.text = format_stats(enemy_name, current_enemy_stats)

	var win_prob = CombatResolver.calculate_win_probability(current_player_stats, current_enemy_stats)
	probability_label.text = "Win Probability: %d%%" % int(win_prob * 100)

	dice_label.text = ""
	result_panel.visible = false
	fight_button.disabled = false
	flee_button.disabled = false
	combat_panel.visible = true

	# Pause game
	get_tree().paused = true

func get_player_combat_stats() -> Dictionary:
	return {
		"swordsmanship": GameManager.get_skill("swordsmanship"),
		"weapon_bonus": 5,  # Placeholder - would come from equipment
		"armor_bonus": 3,   # Placeholder
		"fatigue": 0        # Placeholder
	}

func format_stats(char_name: String, stats: Dictionary) -> String:
	var text = "[b]%s[/b]\n" % char_name
	if stats.has("swordsmanship"):
		text += "Sword Skill: %d\n" % stats.swordsmanship
	if stats.has("combat_skill"):
		text += "Combat Skill: %d\n" % stats.combat_skill
	if stats.has("weapon_bonus"):
		text += "Weapon: +%d\n" % stats.weapon_bonus
	if stats.has("armor_bonus"):
		text += "Armor: +%d\n" % stats.armor_bonus
	return text

func _on_fight_pressed() -> void:
	fight_button.disabled = true
	flee_button.disabled = true

	# Animate dice roll
	dice_label.visible = true
	for i in range(10):
		dice_label.text = "Rolling... %d" % randi_range(1, 100)
		await get_tree().create_timer(0.1).timeout

	# Resolve combat
	var result = CombatResolver.resolve_combat(current_player_stats, current_enemy_stats)

	dice_label.text = "Rolled: %d (Needed: %d or less)" % [int(result.roll * 100), int(result.needed * 100)]

	# Show result
	result_label.text = CombatResolver.get_result_text(result.result)
	if result.result == CombatResolver.CombatResult.VICTORY:
		result_label.modulate = Color.GREEN
	else:
		result_label.modulate = Color.RED

	if result.was_close:
		result_label.text += "\n(Close fight!)"

	result_panel.visible = true

	# Wait then close
	await get_tree().create_timer(2.0).timeout
	end_combat(result)

func _on_flee_pressed() -> void:
	var result = {
		"result": CombatResolver.CombatResult.ESCAPED,
		"roll": 0,
		"needed": 0,
		"was_close": false,
		"margin": 0
	}
	end_combat(result)

func end_combat(result: Dictionary) -> void:
	combat_panel.visible = false
	get_tree().paused = false
	combat_resolved.emit(result)
