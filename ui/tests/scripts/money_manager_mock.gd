class_name MoneyManagerMock extends Node

signal amount_changed(new_total: int)

@export var total_amount: int = 0

func _ready() -> void:
	amount_changed.emit(total_amount)

func change_money(amount_to_add: int):
	var new_money = total_amount + amount_to_add
	total_amount = maxi(new_money, 0)
	
	amount_changed.emit(total_amount)


func _on_upgrade_bought(upgrade: Upgrade):
	change_money(-upgrade.price)
