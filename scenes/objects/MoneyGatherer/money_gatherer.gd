extends Node2D

@export var icon_to_show: Texture2D = null
@export var amount_to_earn: int = 0
@export var disabled: bool = false
@export var cool_down: float = 0

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $TextureRect/Label
@onready var money_click_effect: CPUParticles2D = $MoneyClickEffect
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var money_added_container: Node2D = $MoneyAddedContainer

var money_added_label: PackedScene = preload("res://scenes/objects/MoneyGatherer/money_added_label.tscn")


func set_disabled(value: bool):
	if value:
		self.texture_rect.modulate.a = 0.5
	else:
		self.texture_rect.modulate.a = 1
	self.disabled = value


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.texture_rect.texture = self.icon_to_show
	self.money_click_effect.set_texture(self.icon_to_show)
	self.label.text = str(self.amount_to_earn)
	
	if self.disabled:
		self.texture_rect.modulate.a = 0.5
	


func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if self.disabled:
		return
	
	if event.is_action_pressed("left_click"):
		GameEvents.money_collected.emit(self.amount_to_earn)
		self.money_click_effect.play()
		self.audio_stream_player_2d.play()
		
		var instantiated = self.money_added_label.instantiate() as Label
		instantiated.money = str(self.amount_to_earn)
		instantiated.global_position = self.money_added_container.position
		self.money_added_container.add_child(instantiated)
		
		self.set_disabled(true)
		await self.get_tree().create_timer(self.cool_down).timeout
		self.set_disabled(false)
