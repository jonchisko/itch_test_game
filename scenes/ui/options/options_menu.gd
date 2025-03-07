extends MarginContainer
class_name OptionsMenu

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var master_slider: HScrollBar = %MasterSlider
@onready var music_slider: HScrollBar = %MusicSlider
@onready var sfx_slider: HScrollBar = %SFXSlider
@onready var audio_button: AudioButton = %AudioButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.modulate = Color.TRANSPARENT
	self._update_display()
	self.animation_player.play("in")
	
	
func _close_menu() -> void:
	self.animation_player.play("out")


func _update_display() -> void:
	self.audio_button.text = "Windowed"
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_WINDOWED:
		self.audio_button.text = "Fullscreen"
		
	self.master_slider.value = self._get_bus_volume_percent("Master")
	self.music_slider.value = self._get_bus_volume_percent("Music")
	self.sfx_slider.value = self._get_bus_volume_percent("SFX")
	

func _get_bus_volume_percent(bus: String):
	var bus_index = AudioServer.get_bus_index(bus)
	return db_to_linear(AudioServer.get_bus_volume_db(bus_index))


func _on_master_slider_value_changed(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func _on_music_slider_value_changed(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func _on_sfx_slider_value_changed(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func _on_audio_button_pressed() -> void:
	var mode = DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
	self._update_display()


func _on_back_button_pressed() -> void:
	self._close_menu()
