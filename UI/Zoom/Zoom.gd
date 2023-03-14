extends HSlider

func _ready():
	value = get_node("/root/Save").zoom

func _on_value_changed(value):
	@warning_ignore("unused_parameter")
	get_node("/root/Save").zoom = value
