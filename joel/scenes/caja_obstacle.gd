extends AnimatedSprite2D

var health:float = 61.0

func _ready() -> void:
	if DataManager.box_destroyed:
		queue_free()

func take_damage(_damage:float,_global_pos:Vector2):
	$AudioStreamPlayer2D.play()
	frame += 1
	health -= 10
	print(health)
	if health <= 0:
		DataManager.box_destroyed = true
		queue_free()
