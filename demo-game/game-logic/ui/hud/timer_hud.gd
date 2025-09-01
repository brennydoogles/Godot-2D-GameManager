extends AbstractHud

@onready var time_label: Label = $TimeLabel


func _process(delta: float) -> void:
	var total_elapse_seconds = data_provider.get_value_as_int()
	var elapsed_minutes = total_elapse_seconds / 60
	var elapsed_seconds = total_elapse_seconds % 60
	time_label.text = "%d:%02d" % [elapsed_minutes, elapsed_seconds]
	
