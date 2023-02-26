extends ColorRect

export var shortcut: ShortCut

func _input(event: InputEvent) -> void:
	if shortcut.is_shortcut(event):
		if event is InputEventKey and event.is_pressed():
			toggle()

func toggle():
	visible = not visible
	get_tree().paused = visible
