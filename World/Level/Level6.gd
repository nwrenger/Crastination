extends TileMap

func _exit_tree():
	get_node("/root/Save").level = 6
