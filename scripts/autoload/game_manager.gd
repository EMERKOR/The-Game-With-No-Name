extends Node

# Player data
var player_data: Dictionary = {
	"name": "Erwin",
	"guard_rank": 1,  # 1 = Initiate
	"court_standing": 0,
	"common_folk_rep": 0,
	"coins": 50,
	"skills": {
		"swordsmanship": 10,
		"archery": 5,
		"stealth": 5,
		"persuasion": 5,
		"investigation": 5
	},
	"current_mission": null,
	"completed_missions": []
}

# Game state
var current_scene: String = ""
var game_paused: bool = false

# Signals
signal player_data_changed
signal mission_started(mission_id: String)
signal mission_completed(mission_id: String)
signal mission_failed(mission_id: String)

func _ready() -> void:
	print("GameManager initialized")

func get_skill(skill_name: String) -> int:
	return player_data.skills.get(skill_name, 0)

func modify_skill(skill_name: String, amount: int) -> void:
	if skill_name in player_data.skills:
		player_data.skills[skill_name] += amount
		player_data.skills[skill_name] = clamp(player_data.skills[skill_name], 0, 100)
		player_data_changed.emit()

func modify_coins(amount: int) -> void:
	player_data.coins += amount
	player_data.coins = max(0, player_data.coins)
	player_data_changed.emit()

func modify_guard_rank(amount: int) -> void:
	player_data.guard_rank += amount
	player_data.guard_rank = clamp(player_data.guard_rank, 1, 8)
	player_data_changed.emit()

func modify_court_standing(amount: int) -> void:
	player_data.court_standing += amount
	player_data_changed.emit()

func modify_common_folk_rep(amount: int) -> void:
	player_data.common_folk_rep += amount
	player_data_changed.emit()

func start_mission(mission_id: String) -> void:
	player_data.current_mission = mission_id
	mission_started.emit(mission_id)

func complete_mission(mission_id: String) -> void:
	if player_data.current_mission == mission_id:
		player_data.completed_missions.append(mission_id)
		player_data.current_mission = null
		mission_completed.emit(mission_id)

func fail_mission(mission_id: String) -> void:
	if player_data.current_mission == mission_id:
		player_data.current_mission = null
		mission_failed.emit(mission_id)

func has_completed_mission(mission_id: String) -> bool:
	return mission_id in player_data.completed_missions

func save_game() -> void:
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_data = {
		"player_data": player_data,
		"trust_data": TrustManager.npc_trust,
		"time_data": TimeManager.get_time_data()
	}
	save_file.store_string(JSON.stringify(save_data))
	save_file.close()

func load_game() -> bool:
	if not FileAccess.file_exists("user://savegame.save"):
		return false
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var save_data = JSON.parse_string(save_file.get_as_text())
	save_file.close()
	if save_data:
		player_data = save_data.player_data
		TrustManager.npc_trust = save_data.trust_data
		TimeManager.set_time_data(save_data.time_data)
		player_data_changed.emit()
		return true
	return false
