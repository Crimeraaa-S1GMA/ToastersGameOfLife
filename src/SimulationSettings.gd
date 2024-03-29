extends CanvasLayer

onready var rules_list : VBoxContainer = $UI/ScrollContainer/VBoxContainer/RulesList

onready var friction_slider : HSlider = $UI/ScrollContainer/VBoxContainer/Friction/HSlider
onready var simulation_speed_slider : HSlider = $UI/ScrollContainer/VBoxContainer/SimulationSpeed/HSlider
onready var repulse_close_particles_checkbox : CheckBox = $UI/ScrollContainer/VBoxContainer/RepulseCloseParticles

onready var rule_setting : PackedScene = preload("res://src/RuleSetting.tscn")

func _ready():
	friction_slider.value = SimulationManager.friction
	simulation_speed_slider.value = SimulationManager.simulationSpeed
	repulse_close_particles_checkbox.pressed = SimulationManager.repulseCloseParticles

	for i in SimulationManager.rules:
		for j in SimulationManager.rules[i]:
			var rule_setting_ins = rule_setting.instance()

			rule_setting_ins.from = i
			rule_setting_ins.to = j

			rules_list.add_child(rule_setting_ins)

func _on_Rules_Randomize_pressed():
	SimulationManager.NewRules()


func _on_HSlider_value_changed(value):
	SimulationManager.friction = value


func _on_RepulseCloseParticles_pressed():
	SimulationManager.repulseCloseParticles = repulse_close_particles_checkbox.pressed


func _on_SimulationSpeed_HSlider_value_changed(value):
	SimulationManager.simulationSpeed = value
