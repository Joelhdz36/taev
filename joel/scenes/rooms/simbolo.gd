extends Sprite2D

const SIMBOLO = preload("res://assets/dialogos/timelines/simbolo.dtl") as DialogicTimeline

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and !Dialogic.VAR.simbolo:
		DialogueManager.play_dialogue(SIMBOLO)
