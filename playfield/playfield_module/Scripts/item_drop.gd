class_name DropCalculator extends Node

const DROP_POOL: Array[Gold] = [
	preload("res://playfield_module/Resources/Gold/small.tres"),
	preload("res://playfield_module/Resources/Gold/medium.tres"),
	preload("res://playfield_module/Resources/Gold/large.tres"),
]

static func get_random_item(luck: float) -> Gold:
	var boosted_weights: Dictionary = {}
	var sum_of_weight := 0.0

	for item in DROP_POOL:
		var base_weight: float = item.drop_weight
		var boosted_weight = base_weight + (luck / max(base_weight, 0.01))
		
		boosted_weights[item] = boosted_weight
		sum_of_weight += boosted_weight
		
	var rnd: float = randf() * sum_of_weight
	
	for item in boosted_weights:
		var weight: float = boosted_weights[item]
		
		if rnd < weight:
			return item
		
		rnd -= weight
	
	return DROP_POOL[0]
