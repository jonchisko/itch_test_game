extends PanelContainer

func pause() -> void:
	self.get_tree().paused = true
	self.visible = true


func _on_continue_button_pressed() -> void:
	self.visible = false
	self.get_tree().paused = false


func _on_main_menu_button_pressed() -> void:
	self.get_tree().paused = false
	self.get_tree().change_scene_to_file("res://scenes/ui/main_menu/main_menu.tscn")
