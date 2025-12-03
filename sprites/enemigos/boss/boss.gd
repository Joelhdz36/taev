extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

@export var cooldown_atk:float = 3.0
var _cooldown_atk:float = 3.0

var start_pos:Vector2 

func _ready() -> void:
	_cooldown_atk = cooldown_atk
	start_pos = global_position


func _process(delta: float) -> void:
	if cooldown_atk <= 0:
		animated_sprite_2d.play("Attack")
		if animated_sprite_2d.frame == 0:
			global_position.x = lerpf(global_position.x,start_pos.x + 48,delta*50)
		await animated_sprite_2d.animation_finished
		cooldown_atk = _cooldown_atk
	else:
		animated_sprite_2d.play("GoingBack")
		cooldown_atk -= delta
		global_position.x = move_toward(global_position.x,start_pos.x,delta*25)
