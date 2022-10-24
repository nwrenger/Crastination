extends Button

func _ready():
    if AudioServer.is_bus_mute(0):
        pressed = true

func toggle(button_pressed):
    AudioServer.set_bus_mute(0, button_pressed)
