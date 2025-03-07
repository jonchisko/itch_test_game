extends Node2D

@onready var money_manager: Node = $MoneyManager
@onready var pause: PanelContainer = $CanvasLayer/Pause

@export var money_gatherers: Array[Node2D]

var _next = 1


func _ready() -> void:
	GameEvents.level_reached.connect(self._on_level_reached)


func _process(_delta: float) -> void:
	if not self.get_tree().paused and Input.is_action_pressed("pause"):
		self.pause.pause()


func _on_level_reached() -> void:
	if self._next >= self.money_gatherers.size():
		return
	self.money_gatherers[self._next].set_disabled(false)
	self._next += 1
