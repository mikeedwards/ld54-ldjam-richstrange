class_name ColorPuzzle
extends Puzzle

#signal entry_passed(puzzle: int, button: int)
#signal entry_failed(puzzle: int, button: int)

func _ready():
	buttons  = [
		$GridContainer/Button1,
		$GridContainer/Button2,
		$GridContainer/Button3,
		$GridContainer/Button4,
		]


#var active_index: int = -1
#
#

#	pass
#
#
#func _process(delta):
#	pass
#
#
#func make_active(code: int):
#	active_index = code
#	for button in buttons:
#		button.flashing = false
#	buttons[code].flashing = true
#
#
#func test_press(index):
#	if active_index == index:
#		buttons[index].flashing = false
#		entry_passed.emit(0, index)	
#	else:
#		entry_failed.emit(0, index)


func _on_button_1_pressed():
	test_press(0)


func _on_button_2_pressed():
	test_press(1)


func _on_button_3_pressed():
	test_press(2)


func _on_button_4_pressed():
	test_press(3)
