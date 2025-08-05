extends HBoxContainer
class_name HeartController

func set_hearts_to_new_value(oldValue, newValue):
	var increment_value = int(newValue) - int(oldValue)
	if increment_value < 0:
		subtract_hearts(increment_value)
	if increment_value > 0:
		add_hearts(increment_value)

func subtract_hearts(decrement_value: int):
	var all_hearts = get_children()
	all_hearts.reverse()
	for heart : TextureProgressBar in all_hearts:
		if heart.value <= 0:
			all_hearts.erase(heart)
	while decrement_value < 0:
		if all_hearts.is_empty():
			break
		all_hearts[0].value -= 1
		decrement_value += 1
		if all_hearts[0].value == 0:
			all_hearts.remove_at(0)
	
func add_hearts(increment_value: int):
	var all_hearts = get_children()
	for heart : TextureProgressBar in all_hearts:
		if heart.value == heart.max_value:
			all_hearts.erase(heart)
	while increment_value > 0:
		if all_hearts.is_empty():
			break
		all_hearts[0].value += 1
		increment_value -= 1
		if all_hearts[0].value == all_hearts[0].max_value:
			all_hearts.remove_at(0)
