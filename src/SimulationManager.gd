extends Node2D

var rules : Dictionary = {
	
}

var particle_types : int = 10

var colors : Array = [
	Color.red,
	Color.orange,
	Color.yellow,
	Color.green,
	Color.cyan,
	Color.blue,
	Color.purple,
	Color.violet,
	Color.pink,
	Color.seagreen
]

export var materials : Array = [
	
]

var started : bool = false

func _ready():
	randomize()
	
	new_rules()

func new_rules() -> void:
	rules.clear()
	
	for rule_cr in range(particle_types):
		rules[rule_cr] = {}
	
	for rule_1 in range(particle_types):
		for rule_2 in range(particle_types):
			rules[rule_1][rule_2] = rand_range(-3.0, -1.0) if rule_1 == rule_2 else rand_range(-10.0, 10.0)
