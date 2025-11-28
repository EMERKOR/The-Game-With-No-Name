extends Node

# Trust scores for all NPCs (0-100)
# Below 50 = enemy, 50 = neutral, above 50 = ally
var npc_trust: Dictionary = {
	"captain_aldric": 55,  # Starts slightly friendly (your superior)
	"lord_harlan": 45,     # Starts slightly cold (noble, dismissive of low-rank)
	"servant_mira": 60     # Starts friendly (fellow commoner background)
}

# NPC relationships with each other (affects trust cascades)
var npc_relationships: Dictionary = {
	"captain_aldric": {
		"lord_harlan": -20,  # Captain dislikes the lord
		"servant_mira": 10   # Captain is neutral-positive to servants
	},
	"lord_harlan": {
		"captain_aldric": -20,  # Mutual dislike
		"servant_mira": -30     # Lord looks down on servants
	},
	"servant_mira": {
		"captain_aldric": 10,
		"lord_harlan": -40  # Mira fears/dislikes the lord
	}
}

signal trust_changed(npc_id: String, old_value: int, new_value: int)

func _ready() -> void:
	print("TrustManager initialized")

func get_trust(npc_id: String) -> int:
	return npc_trust.get(npc_id, 50)

func set_trust(npc_id: String, value: int) -> void:
	var old_value = get_trust(npc_id)
	npc_trust[npc_id] = clamp(value, 0, 100)
	trust_changed.emit(npc_id, old_value, npc_trust[npc_id])

func modify_trust(npc_id: String, amount: int, apply_cascade: bool = true) -> Dictionary:
	# Returns a dictionary of all trust changes for UI display
	var changes: Dictionary = {}

	var old_value = get_trust(npc_id)
	npc_trust[npc_id] = clamp(old_value + amount, 0, 100)
	changes[npc_id] = amount
	trust_changed.emit(npc_id, old_value, npc_trust[npc_id])

	# Apply cascade effects based on NPC relationships
	if apply_cascade and amount != 0:
		for other_npc in npc_relationships.get(npc_id, {}):
			var relationship = npc_relationships[npc_id][other_npc]
			# If you help someone's friend, they like you more
			# If you help someone's enemy, they like you less
			var cascade_amount = int(amount * relationship / 100.0)
			if cascade_amount != 0:
				var other_old = get_trust(other_npc)
				npc_trust[other_npc] = clamp(other_old + cascade_amount, 0, 100)
				changes[other_npc] = cascade_amount
				trust_changed.emit(other_npc, other_old, npc_trust[other_npc])

	return changes

func is_ally(npc_id: String) -> bool:
	return get_trust(npc_id) > 50

func is_enemy(npc_id: String) -> bool:
	return get_trust(npc_id) < 50

func get_relationship_status(npc_id: String) -> String:
	var trust = get_trust(npc_id)
	if trust >= 75:
		return "Allied"
	elif trust >= 50:
		return "Friendly"
	elif trust >= 25:
		return "Unfriendly"
	else:
		return "Hostile"
