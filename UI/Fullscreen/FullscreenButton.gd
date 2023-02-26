extends Button

func _ready():
	pressed = OS.window_fullscreen

func togglescreen(button_pressed):
	OS.window_fullscreen = button_pressed
