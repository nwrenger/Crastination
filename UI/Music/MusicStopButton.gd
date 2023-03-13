extends Button

@export var width := 16
@export var slider: NodePath

@onready var _slider = get_node(slider)
@onready var style_hover := get("theme_override_styles/hover") as StyleBoxTexture
@onready var style_pressed := get("theme_override_styles/pressed") as StyleBoxTexture
@onready var style_normal := get("theme_override_styles/normal") as StyleBoxTexture
@onready var style_disabled := get("theme_override_styles/disabled") as StyleBoxTexture

enum State{
	MUTED,
	QUIET,
	HALF,
	LOUD,
}

var state :int = State.LOUD : set = set_state
var last_state: float


func _ready():
	_slider.value = get_node("/root/Save").volume
	if _slider.value == 0:
		set_state(0)

func _exit_tree():
	save()

func save():
	get_node("/root/Save").volume = _slider.value

func _pressed():
	if state == State.MUTED:
		_slider.value = last_state
	else:
		if _slider.value == 0.0:
			last_state = 1.0
		else:
			last_state = _slider.value
		print(last_state)
		_slider.value = 0
		set_state(State.MUTED)

func set_state(s:int):
	state = s
	var offset = s * width

	style_hover.region_rect.position.x = offset
	style_pressed.region_rect.position.x = offset
	style_normal.region_rect.position.x = offset
	style_disabled.region_rect.position.x = offset

	AudioServer.set_bus_mute(0, _slider.value == 0)
	AudioServer.set_bus_volume_db(0, -(exp(1-_slider.value)-1)/(exp(1)-1) * 40)


func _on_slider_changed(value: float):
	var s = ceil(value * 3)
	set_state(s)
