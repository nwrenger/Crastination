extends ColorRect

@export var shortcut: Shortcut

func _input(event: InputEvent) -> void:
	if shortcut.matches_event(event):
		if event is InputEventKey and event.is_pressed():
			toggle()

func toggle():
	visible = not visible
	get_tree().paused = visible
