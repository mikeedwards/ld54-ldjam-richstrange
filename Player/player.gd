extends CharacterBody2D


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
	var coords := tilemap.local_to_map(position)
	var data := tilemap.get_cell_tile_data(1, coords)

	if data and data.z_index == 2:
		tilemap.set_cell(1, coords, -1)
		var cells := tilemap.get_surrounding_cells(coords)
		cells.append(tilemap.get_neighbor_cell(coords, TileSet.CELL_NEIGHBOR_TOP_LEFT_CORNER))
		cells.append(tilemap.get_neighbor_cell(coords, TileSet.CELL_NEIGHBOR_TOP_RIGHT_CORNER))
		cells.append(tilemap.get_neighbor_cell(coords, TileSet.CELL_NEIGHBOR_BOTTOM_LEFT_CORNER))
		cells.append(tilemap.get_neighbor_cell(coords, TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_CORNER))

		for cell in cells:
			tilemap.set_cell(1, cell, -1)


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
		var coords = tilemap.local_to_map(coll_position)
		var collider = collision.get_collider()
		if collider is TileMap:
			var c:TileMap = collider 
			var atlas_coords := c.get_cell_atlas_coords(0, coords)
			var data := c.get_cell_tile_data(0, coords)
			var source_id := c.get_cell_source_id(0, coords)
			if atlas_coords.x == 4:
				c.set_cell(0, coords, source_id, Vector2i(2,0))
