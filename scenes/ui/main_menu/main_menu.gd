extends CanvasLayer


var _options_menu: PackedScene = preload("res://scenes/ui/options/options_menu.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	self.get_tree().quit()


func _on_options_button_pressed() -> void:
	var instantiated_options = self._options_menu.instantiate()
	self.add_child(instantiated_options)


func _on_play_button_pressed() -> void:
	self.get_tree().change_scene_to_file("res://scenes/levels/game_scene.tscn")
