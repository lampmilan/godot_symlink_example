class_name PricedButton extends Button

signal upgrade_bought(upgrade_resource: Upgrade)

@onready var price_label = $HBoxContainer/HBoxContainer/PriceLabel
@onready var name_label = $HBoxContainer/UpgradeLabel
@onready var coin_texture = $HBoxContainer/HBoxContainer/TextureRect

@export var upgrade_resource: Upgrade


func _ready() -> void:
	price_label.text = str(upgrade_resource.price)
	name_label.text = str(upgrade_resource.upgrade_name)
	coin_texture.texture = upgrade_resource.coin_icon

func _pressed() -> void:
	upgrade_bought.emit(upgrade_resource)
