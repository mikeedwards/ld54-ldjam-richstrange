class_name LinePuzzle
extends Puzzle


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
