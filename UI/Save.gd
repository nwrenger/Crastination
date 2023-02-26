extends Node

var file := "user://save.json"
var volume := 1.0
var level := 0

func _ready():
	get_tree().set_auto_accept_quit(false)
	#todo load
	var f := File.new()
	if f.open(file, File.READ) == OK:
		var save = parse_json(f.get_as_text())
		if save is Dictionary:
			print(save)
			OS.window_fullscreen = save.get("fullscreen", OS.window_fullscreen)
			volume = save.get("volume", volume)
			level = save.get("level", level)


func _notification(what):
	match what:
		MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
			#todo save
			for node in get_tree().get_nodes_in_group("Save"):
				node.save()
			print("saving")
			var f := File.new()
			if f.open(file, File.WRITE) == OK:
				var save = {
					"fullscreen": OS.window_fullscreen,
					"volume": volume,
					"level": level,
				}
				f.store_string(to_json(save))
			get_tree().quit()
