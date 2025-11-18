class_name inventoryManager
extends Node2D

var objects_in_inventory:Array[Resource] = []
var keys_in_inventory:Array[Resource] = []

func add_to_inventory(resource_to_add:Resource):
	match resource_to_add.obj_type:
		"item":
			objects_in_inventory.append(resource_to_add)
		"key":
			keys_in_inventory.append(resource_to_add)
