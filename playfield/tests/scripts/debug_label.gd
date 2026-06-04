extends Label


@onready var coin_manager = $"../CoinManager"
@onready var player = $"../CharacterBody2D"

func _process(delta: float) -> void:
	text = (
		"luck: %s \n" % [str(coin_manager.luck)] +
		"spawn rate: %s \n" % [str(coin_manager.spawn_rate)] +
		"movement speed: %s \n" % [str(player.speed)]
	)
