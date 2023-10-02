extends Node2D


@onready var door_puzzle:DoorPuzzle = $GUI/DoorPuzzle
@onready var tilemap:GameTileMap = $TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	door_puzzle.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_tile_map_door_touched(_cell):
	door_puzzle.visible = true


func _on_door_puzzle_puzzle_passed():
	door_puzzle.visible = false
	print("puzzle pass")


func _on_door_puzzle_puzzle_failed():
	door_puzzle.visible = false
	print("puzzle fail")
