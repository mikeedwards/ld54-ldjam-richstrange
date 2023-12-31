class_name DoorPuzzle
extends Control

signal puzzle_passed
signal puzzle_failed

@export var player: Player
@onready var color_puzzle: ColorPuzzle = $Panel/VBoxContainer/GridContainer/ColorPuzzle
@onready var line_puzzle: LinePuzzle = $Panel/VBoxContainer/GridContainer/LinePuzzle
@onready var circle_puzzle: CirclePuzzle = $Panel/VBoxContainer/GridContainer/CirclePuzzle
@onready var puzzles = [color_puzzle, line_puzzle, circle_puzzle]

var answer_index = 0
@export var answer_limit = 1
var first_puzzle = true

var answers: Array[Vector2i] = [
	Vector2i(1, 1), 
	Vector2i(1, 2), 
	Vector2i(1, 3), 
	Vector2i(1, 4), 
	Vector2i(2, 1), 
	Vector2i(2, 2), 
	Vector2i(2, 3), 
	Vector2i(2, 4), 
	Vector2i(2, 5), 
	Vector2i(2, 6), 
	Vector2i(2, 7), 
	Vector2i(3, 1), 
	Vector2i(3, 2), 
	Vector2i(3, 3), 
	Vector2i(3, 4), 
	Vector2i(3, 5), 
	Vector2i(3, 6), 
	Vector2i(3, 7), 
	Vector2i(3, 8), 
	]


func advance_answers():
	var current_answer = answers[answer_index]
	var current_puzzle = puzzles[current_answer.x - 1]
	current_puzzle.make_active(current_answer.y - 1, first_puzzle)
	first_puzzle = false


func _ready():
	answers.shuffle()
	advance_answers()



func reset():
	answer_index = 0
	answer_limit = 1
	first_puzzle = true
	
	
func puzzle_pass():
	answer_index -= 1
	if answer_index < 0: 
		answer_limit += 1
		answer_index = answer_limit - 1
		first_puzzle = true
#		for puzzle in puzzles:
#			puzzle.reset_buttons()
		puzzle_passed.emit()
	advance_answers()


func _on_color_puzzle_entry_passed(_puzzle, _button):
	print("color puzzle pass")
	puzzle_pass()


func _on_color_puzzle_entry_failed(_puzzle, _button):
	print("color puzzle fail")
	reset()
	puzzle_failed.emit()


func _on_line_puzzle_entry_passed(_puzzle, _button):
	print("line puzzle pass")
	puzzle_pass()


func _on_line_puzzle_entry_failed(_puzzle, _button):
	print("line puzzle fail")
	reset()
	puzzle_failed.emit()


func _on_circle_puzzle_entry_passed(_puzzle, _button):
	print("circle puzzle pass")
	puzzle_pass()


func _on_circle_puzzle_entry_failed(_puzzle, _button):
	print("circle puzzle fail")
	reset()
	puzzle_failed.emit()

