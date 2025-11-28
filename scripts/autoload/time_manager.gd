extends Node

enum TimeOfDay { MORNING, AFTERNOON, EVENING, NIGHT }

var current_day: int = 1
var current_time: TimeOfDay = TimeOfDay.MORNING
var time_names: Array = ["Morning", "Afternoon", "Evening", "Night"]

# Visual settings for each time period
var time_colors: Dictionary = {
	TimeOfDay.MORNING: Color(1.0, 0.95, 0.9, 1.0),      # Warm morning light
	TimeOfDay.AFTERNOON: Color(1.0, 1.0, 1.0, 1.0),     # Neutral daylight
	TimeOfDay.EVENING: Color(1.0, 0.85, 0.7, 1.0),      # Orange sunset
	TimeOfDay.NIGHT: Color(0.4, 0.4, 0.6, 1.0)          # Blue night
}

var time_ambient: Dictionary = {
	TimeOfDay.MORNING: 0.8,
	TimeOfDay.AFTERNOON: 1.0,
	TimeOfDay.EVENING: 0.6,
	TimeOfDay.NIGHT: 0.3
}

signal time_changed(new_time: TimeOfDay, day: int)
signal day_changed(new_day: int)

func _ready() -> void:
	print("TimeManager initialized")

func advance_time() -> void:
	var old_time = current_time
	current_time = ((current_time + 1) % 4) as TimeOfDay

	if current_time == TimeOfDay.MORNING:
		current_day += 1
		day_changed.emit(current_day)

	time_changed.emit(current_time, current_day)

func get_time_string() -> String:
	return "Day %d - %s" % [current_day, time_names[current_time]]

func get_current_color() -> Color:
	return time_colors[current_time]

func get_current_ambient() -> float:
	return time_ambient[current_time]

func is_night() -> bool:
	return current_time == TimeOfDay.NIGHT

func get_time_data() -> Dictionary:
	return {
		"day": current_day,
		"time": current_time
	}

func set_time_data(data: Dictionary) -> void:
	current_day = data.get("day", 1)
	current_time = data.get("time", TimeOfDay.MORNING)
	time_changed.emit(current_time, current_day)
