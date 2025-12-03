extends CanvasLayer

@onready var animation_player: AnimationPlayer = %AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CameraManager.current_camera._player.enable_context()
	%AnimationPlayer.play("FadeIn")
	await $AnimationPlayer.animation_finished

	queue_free()

func fade_out():
	%AnimationPlayer.play("FadeOut")
	
