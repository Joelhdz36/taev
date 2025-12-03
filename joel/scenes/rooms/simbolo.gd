extends Sprite2D

const SIMBOLO = preload("uid://cwshe8c54obol") as DialogicTimeline

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and !Dialogic.VAR.simbolo:
		DialogueManager.play_dialogue(SIMBOLO)
