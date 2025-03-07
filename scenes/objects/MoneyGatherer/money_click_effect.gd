extends CPUParticles2D


@export var texture_to_show: Texture2D = null


func _ready() -> void:
	if self.texture_to_show == null:
		printerr("Texture for MoneyClickEffect is missing")
	
	self.texture = self.texture_to_show
	
	
func play() -> void:
	self.emitting = true 
