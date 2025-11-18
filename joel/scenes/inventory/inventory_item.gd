extends Control


func display_info(item:Resource):
	self.texture = item.inventory_icon
	self_modulate = random_color()


func random_color() -> Color:
	var new_color:Color
	new_color.r = randf()
	new_color.g = randf()
	new_color.b = randf()
	new_color.a = 1.0
	
	return new_color
