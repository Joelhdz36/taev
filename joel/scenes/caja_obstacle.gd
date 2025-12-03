extends AnimatedSprite2D

var health:float = 61.0
@export var IDnumber:int
func _ready() -> void:
	if DataManager.boxes_destroyed.has(IDnumber):
		queue_free()

func take_damage(_damage:float,_global_pos:Vector2):
	$AudioStreamPlayer2D.play()
	frame += 1
	health -= 10
	print(health)
	if health <= 0:
		DataManager.boxes_destroyed.append(IDnumber)
		queue_free()
