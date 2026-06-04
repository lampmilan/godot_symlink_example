extends Label

var total_amount: int = 0

func add_gold(gold: int):
	total_amount += gold
	text = "gold: %s" % [str(total_amount)]
