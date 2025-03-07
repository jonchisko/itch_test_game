extends Node

@onready var label: Label = %Label

var _current_money: int = 0


var _level: int = 0
var _level_limits = [10, 200]


func _ready() -> void:
	self.label.text = str(self._current_money)
	GameEvents.money_collected.connect(self._on_money_collected)
	
	
func _on_money_collected(amount: int):
	print("Money collected: ", amount)
	print("Money: ", self._current_money)
	self._current_money += amount
	self.label.text = str(self._current_money)
	
	if self._level < self._level_limits.size() and self._current_money >= self._level_limits[self._level]:
		print("Level reached!")
		self._level += 1
		GameEvents.level_reached.emit()
