extends Node
class_name CombatResolver

enum CombatResult { VICTORY, DEFEAT, DRAW, ESCAPED }

static func calculate_win_probability(player_stats: Dictionary, enemy_stats: Dictionary) -> float:
	# Base calculation using relevant skills and equipment
	var player_power = 0.0
	var enemy_power = 0.0

	# Player power calculation
	player_power += player_stats.get("swordsmanship", 10) * 1.5
	player_power += player_stats.get("weapon_bonus", 0)
	player_power += player_stats.get("armor_bonus", 0)
	player_power -= player_stats.get("fatigue", 0) * 0.5

	# Enemy power calculation
	enemy_power += enemy_stats.get("combat_skill", 10) * 1.5
	enemy_power += enemy_stats.get("weapon_bonus", 0)
	enemy_power += enemy_stats.get("armor_bonus", 0)

	# Calculate probability (sigmoid-like curve)
	var difference = player_power - enemy_power
	var probability = 0.5 + (difference / 200.0)  # Scales difference to probability
	probability = clamp(probability, 0.05, 0.95)  # Always some chance either way

	return probability

static func resolve_combat(player_stats: Dictionary, enemy_stats: Dictionary) -> Dictionary:
	var win_probability = calculate_win_probability(player_stats, enemy_stats)
	var roll = randf()  # 0.0 to 1.0

	var result: CombatResult
	var margin = abs(roll - win_probability)

	if roll <= win_probability:
		result = CombatResult.VICTORY
	else:
		result = CombatResult.DEFEAT

	# Determine if it was a close fight
	var was_close = margin < 0.1

	return {
		"result": result,
		"roll": roll,
		"needed": win_probability,
		"was_close": was_close,
		"margin": margin
	}

static func get_result_text(result: CombatResult) -> String:
	match result:
		CombatResult.VICTORY:
			return "Victory"
		CombatResult.DEFEAT:
			return "Defeat"
		CombatResult.DRAW:
			return "Draw"
		CombatResult.ESCAPED:
			return "Escaped"
	return "Unknown"
