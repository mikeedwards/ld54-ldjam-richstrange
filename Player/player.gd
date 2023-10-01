extends CharacterBody2D
class_name Player

const SPEED = 10000.0

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var tilemap: TileMap = $"/root/Main/TileMap"

func _get_direction() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

func _play_animation(direction):
	if direction.length() > 0 and abs(direction.x) - abs(direction.y) == 0:
		if direction.x == direction.y:
			sprite.play("down_right")
		else:
			sprite.play("down_left")
	elif abs(direction.x) > abs(direction.y):
		sprite.play("left")
	else:
		sprite.play("up")

func _process(_delta):
	var cell := tilemap.local_to_map(position)
	var data := tilemap.get_cell_tile_data(1, cell)

	if data and data.z_index == 2:
		unset_cells(tilemap, cell)

func unset_cells(current_tilemap: TileMap, cell: Vector2i):
	current_tilemap.set_cell(1, cell, -1)
	
	var cells := current_tilemap.get_surrounding_cells(cell)
		
	for next_cell in cells:
		var id = current_tilemap.get_cell_source_id(1, next_cell)
		if id == -1:
			continue
		unset_cells(current_tilemap, next_cell)
	
func swap_cells(current_tilemap: TileMap, cell: Vector2i, from_atlas: Vector2i, to_atlas: Vector2i):
	current_tilemap.set_cell(0, cell, current_tilemap.get_cell_source_id(0, cell), to_atlas)
	
	var cells := current_tilemap.get_surrounding_cells(cell)
		
	for next_cell in cells:
		var next_atlas = current_tilemap.get_cell_atlas_coords(0, next_cell)
		if next_atlas != from_atlas or next_atlas == to_atlas:
			continue
		swap_cells(current_tilemap, next_cell, from_atlas, to_atlas)

func _physics_process(delta):
	var direction = _get_direction()
	_play_animation(direction)

	if direction.length() > 0:
		velocity = direction.normalized() * SPEED * delta
	else:
		velocity = Vector2.ZERO

	var slide := move_and_slide()

	if (slide):
		var collision := get_last_slide_collision()
		var coll_position = collision.get_position()
		var coords = tilemap.local_to_map(coll_position - collision.get_normal())
		var collider = collision.get_collider()
		if collider is TileMap:
			var c:TileMap = collider 
			var atlas_coords := c.get_cell_atlas_coords(0, coords)
			if atlas_coords.x == 4:
				swap_cells(tilemap, coords, Vector2i(4,0), Vector2i(2,0))
