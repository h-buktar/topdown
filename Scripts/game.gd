extends Node2D
@onready var hud: CanvasLayer = $"../HUD"
@onready var current_level_root = $LevelRoot

const LEVELS = [
	preload("res://Scenes/levels/base_level.tscn"),
	preload("res://Scenes/levels/level_1.tscn"),
	preload("res://Scenes/levels/level_2.tscn"),
	preload("res://Scenes/levels/level_3.tscn")
]

var level: int = 0
var loaded_level: Node = null
var changing_level: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print("GAME READY")
	_load_level()


func _load_level():
	if loaded_level != null:
		current_level_root.remove_child(loaded_level)
		loaded_level.queue_free()
		loaded_level = null
		
		
	if level >= LEVELS.size():
		print("CONGRATULATIONS! GAME COMPLETED!")
		return
	
	loaded_level = LEVELS[level].instantiate()
	current_level_root.add_child(loaded_level)
	changing_level = false
	print("Loaded level: " , level + 1)
	
	
	
	
func change_level():
		if changing_level:
			return
			
			changing_level = true
			level += 1
			
			_load_level()
			
			
func _on_exit_body_entered(body:Node2D):
	if body.is_in_group("player"):
		change_level()




 
func _setup_level(level_root: Node) -> void:
	print("SETUP LEVEL CALLED")
	var player = level_root.get_node("Player")
	$"../HUD".call_deferred("set_player" , player)
	player.player_died.connect(_on_player_died)
	
	
	
	
	var exit =level_root.get_node_or_null("Exit")
	if exit:
		exit.body_entered.connect(_on_exit_body_entered)
		print("Exit CONNECTED,LEVEL INDEX:" , level)




func _on_player_died() -> void:
	# pause for 1 second before resetting everything
	await get_tree().create_timer(1.0).timeout
	await hud.fade(1.0)
	level = 1
	PlayerStats.reset()
	_load_level()
	await hud.fade(0.0)
