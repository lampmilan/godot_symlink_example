extends Control

signal upgrade_bought(upgrade: Upgrade)

@onready var button_container = $MainPanel/VBoxContainer/UpgradeVBoxContainer
@onready var gold_counter = $MainPanel/VBoxContainer/GoldPanel/GoldCounter


func _ready() -> void:
	for button in button_container.get_children():
		button.upgrade_bought.connect(_buy_upgrade)


func upgrade_gold(amount: int):
	gold_counter.update_text(amount)
	_check_upgdare_prices(amount)


func _check_upgdare_prices(amount):
	for button in button_container.get_children():
		var upgrade_price = button.upgrade_resource.price
		if amount < upgrade_price:
			button.disabled = true
		else:
			button.disabled = false


func _buy_upgrade(upgrade: Upgrade):
	upgrade_bought.emit(upgrade)
