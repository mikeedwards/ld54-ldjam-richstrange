class_name PuzzleButton
extends Button

@export var bg_color: Color
@export var flashing: bool = false
var flashed: bool = false
var sbDefault: StyleBoxFlat
var sbFlash: StyleBoxFlat
var sbDisabled: StyleBoxFlat
var sbHover: StyleBoxFlat
var time: float = 0.0


func _add_all_overrides(sb: StyleBoxFlat):
	add_theme_stylebox_override("normal", sb)
	add_theme_stylebox_override("focus", sb)
	add_theme_stylebox_override("pressed", sb)


func flash(delta: float):
	if not flashing:
		_add_all_overrides(sbDefault)
		return
	
	time += delta
	if time > 1.0:
		time -= 1.0
		
	if time < 0.5 and flashed == false:
		_add_all_overrides(sbFlash)
		flashed = true
	if time >= 0.5 and flashed == true:
		_add_all_overrides(sbDefault)
		flashed = false


func _ready():
	sbDefault = get_theme_stylebox("normal", "Button").duplicate()
	sbDefault.bg_color = bg_color

	sbFlash = theme.get_stylebox("normal", "Button").duplicate()
	sbFlash.bg_color = bg_color
	sbFlash.border_color = Color.WHITE

	sbDisabled = theme.get_stylebox("normal", "Button").duplicate()
	sbDisabled.bg_color = Color.SLATE_GRAY
	sbDisabled.border_color = Color.DIM_GRAY

	sbHover = theme.get_stylebox("normal", "Button").duplicate()
	sbHover.bg_color = Color.GHOST_WHITE
	sbHover.border_color = Color.DARK_SLATE_GRAY

	_add_all_overrides(sbDefault)
	add_theme_stylebox_override("hover", sbHover)


func _process(delta):
	flash(delta)


func _on_pressed():
#	self.call_deferred("set_disabled", true)
	pass
