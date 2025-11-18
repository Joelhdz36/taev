class_name inventoryManager
extends Node2D

var objects_in_inventory:Array[Resource] = []

func add_to_inventory(resource_to_add:Resource):
	objects_in_inventory.append(resource_to_add)
