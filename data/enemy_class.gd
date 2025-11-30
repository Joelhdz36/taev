class_name Enemy
extends Resource

var id = generate_scene_unique_id()
@export var name:String
@export var health:float
@export var damage:float
@export var wonder_speed:float
@export var follow_speed:float

@export_group("Animacion y Sprites")
@export var sprite_frames:SpriteFrames
