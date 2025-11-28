extends CharacterBody2D

@export var move_speed: float = 200.0

@onready var interaction_area: Area2D = $InteractionArea

var can_move: bool = true
var facing_right: bool = true
var nearby_interactable: Node = null

signal interacted_with(target: Node)

func _ready() -> void:
	interaction_area.body_entered.connect(_on_interaction_area_entered)
	interaction_area.body_exited.connect(_on_interaction_area_exited)
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _physics_process(_delta: float) -> void:
	if not can_move:
		velocity = Vector2.ZERO
		return

	var direction = Input.get_axis("move_left", "move_right")

	if direction != 0:
		velocity.x = direction * move_speed
		facing_right = direction > 0
		# Flip the character visually by scaling
		scale.x = 1 if facing_right else -1
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and nearby_interactable and can_move:
		interact_with(nearby_interactable)

func interact_with(target: Node) -> void:
	interacted_with.emit(target)
	if target.has_method("on_interact"):
		target.on_interact(self)

func _on_interaction_area_entered(body: Node) -> void:
	if body.is_in_group("interactable"):
		nearby_interactable = body
		# Show interaction prompt
		if body.has_method("show_prompt"):
			body.show_prompt()

func _on_interaction_area_exited(body: Node) -> void:
	if body == nearby_interactable:
		nearby_interactable = null
		if body.has_method("hide_prompt"):
			body.hide_prompt()

func _on_dialogue_started(_npc_id: String) -> void:
	can_move = false

func _on_dialogue_ended() -> void:
	can_move = true
