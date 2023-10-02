extends CharacterBody2D
class_name Player

const SPEED = 10000.0

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var tilemap: GameTileMap = $"/root/Main/TileMap"
var original_position: Vector2
var door_cell = null

func _get_direction() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")


func _play_animation(direction):
	if direction.length() > 0 and abs(direction.x) - abs(direction.y) == 0:
		if direction.x == direction.y:
			if direction.y < 0:
				sprite.play("up_left")
			else:
				sprite.play("down_right")
		else:
			if direction.y < 0:
				sprite.play("up_right")
			else:
				sprite.play("down_left")
	elif abs(direction.x) > abs(direction.y):
		if direction.x < 0:
			sprite.play("left")
		else:
			sprite.play("right")
	else:
		if direction.y < 0:
			sprite.play("up")
		else:
			sprite.play("down")


func _move(direction: Vector2, delta: float) -> bool:
	if direction.length() > 0:
		velocity = direction.normalized() * SPEED * delta
	else:
		velocity = Vector2.ZERO
	return move_and_slide()

func _ready():
	original_position = position

func _process(_delta):
	var cell := tilemap.local_to_map(position)
	tilemap.check_ceiling(cell)


func _physics_process(delta):
	var direction = _get_direction()
	
	_play_animation(direction)

	var slide = _move(direction, delta)

	if (slide):
		var collision := get_last_slide_collision()
		tilemap.check_doors(collision)



func _on_tile_map_door_opened():
	pass


func _on_tile_map_door_touched(cell):
	door_cell = cell
#	tilemap.open_door(cell)


func _on_door_puzzle_puzzle_passed():
	print("passed")
	if door_cell != null:
		tilemap.open_door(door_cell)
	door_cell = null


func _on_door_puzzle_puzzle_failed():
	position = original_position


func _on_area_2d_area_entered(area):
	get_tree().change_scene_to_file("res://Scenes/outro.tscn")
