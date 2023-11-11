extends HBoxContainer

var from : int = 0
var to : int = 0

onready var label : Label = $Label
onready var slider : HSlider = $HSlider

func _ready():
	get_value_from_settings()
	
	SimulationManager.connect("on_rule_update", self, "get_value_from_settings")

func get_value_from_settings() -> void:
	slider.value = SimulationManager.rules[from][to]

func _process(delta):
	label.text = "{from} -> {to}".format({
		"from" : from,
		"to" : to
	})


func _on_HSlider_value_changed(value):
	SimulationManager.rules[from][to] = value
