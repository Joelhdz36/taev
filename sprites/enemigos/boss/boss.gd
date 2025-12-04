extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

@export var cooldown_atk:float = 3.0
var _cooldown_atk:float = 3.0

var damage:float = 15
var start_pos:Vector2 
var life:float = 150
func _ready() -> void:
	_cooldown_atk = cooldown_atk
	start_pos = global_position


func _process(delta: float) -> void:
	if cooldown_atk <= 0:
		animated_sprite_2d.play("Attack")
		if animated_sprite_2d.frame == 0:
			global_position.x = lerpf(global_position.x,start_pos.x - 48,delta*50)
		await animated_sprite_2d.animation_finished
		cooldown_atk = _cooldown_atk
	else:
		animated_sprite_2d.play("GoingBack")
		cooldown_atk -= delta
		global_position.x = move_toward(global_position.x,start_pos.x,delta*25)


func take_damage(_damage:float,_pos:Vector2):
	life -= _damage
	if life <= 0:
		die()

func die():
	SceneManager.cambio_escena("uid://bumpkbs527cjo")
	queue_free()

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.take_damage(damage,global_position)
