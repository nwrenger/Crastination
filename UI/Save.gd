extends Node

var file := "user://save.json"
var volume := 1.0
var level := 0
var zoom := 1.5
var time := 0.0
var dash := false

func _ready():
	get_tree().set_auto_accept_quit(false)
	#todo load
	var f := FileAccess.open(file,FileAccess.READ)
	if FileAccess.file_exists(file):
		var test_json_conv = JSON.new()
		test_json_conv.parse(f.get_as_text(), true)
		var save = test_json_conv.get_data()
		if save is Dictionary:
#			print(save)
			get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (save.get("fullscreen", ((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN)))) else Window.MODE_WINDOWED
			volume = save.get("volume", volume)
			level = save.get("level", level)
			zoom = save.get("zoom", zoom)
			time = save.get("time", time)
			dash = save.get("dash", dash)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		#todo save
#		print("saving")
		for node in get_tree().get_nodes_in_group("Save"):
			node.save()
#			print("save_group")
		var f := FileAccess.open(file, FileAccess.WRITE)
		var save = {
			"fullscreen": ((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN)),
			"volume": volume,
			"level": level,
			"zoom": zoom,
			"time": time,
			"dash": dash,
		}
		f.store_string(JSON.stringify(save))
		get_tree().quit()
