extends CanvasLayer
const HEART_SIZE: int = 20
@onready var fade_overlay: ColorRect = $FadeOverlay
@onready var hearts_container: HBoxContainer = $Hearts

 func _ready() -> void:
	_update_health(50)

func _update_health(new_health:int) -> void:
	var hearts = hearts_container.get_children()
	var max_hearts = len(hearts)
	var full = int(new_health / HEART_SIZE)
	var half = 1 if(new_health % HEART_SIZE) > 0 else 0
	var empty = max_heart - (full + half)

	



func fade(to_alpha: float) -> void:
	var tween:= create_tween()
	tween.tween_property(fade_overlay, "modulate", to_alpha, 1.5)
	await tween.finished
