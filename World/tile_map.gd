extends TileMap
class_name GameTileMap

enum LayerIDs {
	GROUND,
	DOORS,
	CEILING,
}


enum TileIDs {
	DANGER,
	WALL,
	FLOOR,
	CEILING,
	DOOR,
	TRANSOM,
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func unset_cells(layer:int, cell: Vector2i):
	set_cell(layer, cell, -1)
	
	var cells := get_surrounding_cells(cell)
		
	for next_cell in cells:
		var id = get_cell_source_id(layer, next_cell)
		if id == -1:
			continue
		unset_cells(layer, next_cell)


func swap_cells(layer: int, cell: Vector2i, from_atlas: Vector2i, to_atlas: Vector2i):
	set_cell(layer, cell, get_cell_source_id(0, cell), to_atlas)
	
	var cells := get_surrounding_cells(cell)
		
	for next_cell in cells:
		var next_atlas = get_cell_atlas_coords(layer, next_cell)
		if next_atlas != from_atlas or next_atlas == to_atlas:
			continue
		swap_cells(layer, next_cell, from_atlas, to_atlas)


func check_ceiling(cell: Vector2i):
	var data := get_cell_tile_data(LayerIDs.CEILING, cell)

	if data and data.z_index == 2:
		unset_cells(LayerIDs.CEILING, cell)


func check_doors(collision: KinematicCollision2D):
	var coll_position = collision.get_position()
	var cell = local_to_map(coll_position - collision.get_normal())
	var collider = collision.get_collider()
	if collider == self:
		var atlas_coords := get_cell_atlas_coords(LayerIDs.DOORS, cell)
		if atlas_coords.x == 4:
			swap_cells(LayerIDs.DOORS, cell, Vector2i(TileIDs.DOOR,0), Vector2i(TileIDs.TRANSOM,0))
