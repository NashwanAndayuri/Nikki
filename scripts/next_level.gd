extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		##print("hello player")
		#var current_scene = get_tree().current_scene.scene_file_path
		#var next_level = current_scene.get_file().to_int() + 1
		#var next_level_path = "res://scenes/" + str(next_level) + ".tscn"
		#
		get_tree().call_deferred("change_scene_to_file","res://levels/level0.tscn")
	
