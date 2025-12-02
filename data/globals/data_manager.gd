@tool
class_name dataManager
extends Node


var defeated_enemies:Array[Resource]
var spawn_enemies:bool = InventoryManager.keys_in_inventory.has(preload("res://data/objects/keys/key_tubo.tres"))
