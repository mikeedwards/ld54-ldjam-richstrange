class_name LinePuzzle
extends Puzzle



#var active_index: int = -1


func _ready():
	buttons  = [
	$HBoxContainer/VBoxContainer/Button1,
	$HBoxContainer/VBoxContainer/Button2,
	$HBoxContainer/VBoxContainer/Button3,
	$HBoxContainer/VBoxContainer/Button4,
	$HBoxContainer/VBoxContainer/Button5,
	$HBoxContainer/VBoxContainer/Button6,
	$HBoxContainer/VBoxContainer/Button7,
	]
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


func _on_button_5_pressed():
	test_press(4)


func _on_button_6_pressed():
	test_press(5)


func _on_button_7_pressed():
	test_press(6)
