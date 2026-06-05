extends Control



func _on_return_button_pressed() -> void:
	get_tree().reload_current_scene() # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
