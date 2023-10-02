class_name CirclePuzzle
extends Puzzle


func _ready():
	buttons  = [
	$Marker1/Button1,
	$Marker2/Button2,
	$Marker3/Button3,
	$Marker4/Button4,
	$Marker5/Button5,
	$Marker6/Button6,
	$Marker7/Button7,
	$Marker8/Button8,
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


func _on_button_8_pressed():
	test_press(7)

