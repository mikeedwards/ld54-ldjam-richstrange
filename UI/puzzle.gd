class_name Puzzle
extends Panel

signal entry_passed(puzzle: int, button: int)
signal entry_failed(puzzle: int, button: int)

@onready var buttons: Array[PuzzleButton]

var active_index: int = -1


func make_active(code: int, first: bool = false):
	active_index = code
	for button in buttons:
		button.flashing = false
	if first:
		buttons[code].flashing = true
#
#func reset_buttons():
#	for button in buttons:
#		button.call_deferred("set_disabled", false)


func test_press(index):
	if active_index == index:
		buttons[index].flashing = false
		entry_passed.emit(0, index)	
	else:
		entry_failed.emit(0, index)

