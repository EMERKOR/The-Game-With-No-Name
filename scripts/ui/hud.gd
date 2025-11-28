extends CanvasLayer

@onready var time_label: Label = $HUDPanel/HBoxContainer/TimeLabel
@onready var coins_label: Label = $HUDPanel/HBoxContainer/CoinsLabel
@onready var rank_label: Label = $HUDPanel/HBoxContainer/RankLabel
@onready var mission_label: Label = $HUDPanel/MissionLabel

var rank_names: Array = ["", "Initiate", "Guard", "Senior Guard", "Sergeant", "Lieutenant", "Captain", "Commander", "Marshal"]

func _ready() -> void:
	GameManager.player_data_changed.connect(_on_player_data_changed)
	GameManager.mission_started.connect(_on_mission_started)
	GameManager.mission_completed.connect(_on_mission_completed)
	TimeManager.time_changed.connect(_on_time_changed)

	update_display()

func _on_player_data_changed() -> void:
	update_display()

func _on_mission_started(mission_id: String) -> void:
	mission_label.text = "Mission: " + format_mission_name(mission_id)
	mission_label.visible = true

func _on_mission_completed(_mission_id: String) -> void:
	mission_label.text = "Mission Complete!"
	await get_tree().create_timer(2.0).timeout
	mission_label.visible = false

func _on_time_changed(_new_time: int, _day: int) -> void:
	update_display()

func update_display() -> void:
	time_label.text = TimeManager.get_time_string()
	coins_label.text = "Coins: %d" % GameManager.player_data.coins
	var rank_index = GameManager.player_data.guard_rank
	rank_label.text = "Rank: %s" % rank_names[rank_index]

	if GameManager.player_data.current_mission:
		mission_label.text = "Mission: " + format_mission_name(GameManager.player_data.current_mission)
		mission_label.visible = true
	else:
		mission_label.visible = false

func format_mission_name(mission_id: String) -> String:
	# Convert snake_case to Title Case
	var words = mission_id.split("_")
	var result = ""
	for word in words:
		if result != "":
			result += " "
		result += word.capitalize()
	return result
