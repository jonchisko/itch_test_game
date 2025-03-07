extends Label

@export var money: int
@export var up_amount: int
@export var scale_amount: float
@export var duration: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text = "+{money}".format({"money": self.money})
	
	var tween = self.create_tween()
	
	tween.set_parallel()
	tween.tween_property(self, "global_position", self.global_position + Vector2(0, self.up_amount), self.duration)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "scale", Vector2(self.scale_amount, self.scale_amount), self.duration)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, self.duration)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	
	tween.chain()
	tween.tween_callback(self.queue_free)
