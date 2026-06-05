extends Control

@onready var win: AudioStreamPlayer2D = $WinBgm

func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn") # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
