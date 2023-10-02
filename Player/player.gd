extends CharacterBody2D
class_name Player

const SPEED = 10000.0

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var tilemap: GameTileMap = $"/root/Main/TileMap"

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


func _move(direction: Vector2, delta: float) -> bool:
	if direction.length() > 0:
		velocity = direction.normalized() * SPEED * delta
	else:
		velocity = Vector2.ZERO
	return move_and_slide()


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

