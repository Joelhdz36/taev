class_name dialogueManager
extends Node


func play_dialogue(dialogue:DialogicTimeline):
		Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
		Dialogic.start(dialogue).process_mode = Node.PROCESS_MODE_ALWAYS
