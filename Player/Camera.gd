extends Camera2D

@export var default_zoom := 1

func _ready():
	zoom.y = get_node("/root/Save").zoom * default_zoom
	zoom.x = get_node("/root/Save").zoom * default_zoom

func _process(_delta):
	zoom.y = get_node("/root/Save").zoom * default_zoom
	zoom.x = get_node("/root/Save").zoom * default_zoom
