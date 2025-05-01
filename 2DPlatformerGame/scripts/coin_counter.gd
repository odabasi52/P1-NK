extends HBoxContainer

func _ready():
	var base_levels = get_tree().get_nodes_in_group("base_level")
	if base_levels.size() > 0:
		base_levels[0].collected_coin_changed.connect(self.on_collected_coin_changed)
		update_display(base_levels[0].totalCoins, base_levels[0].collectedCoins)

func update_display(totalCoin, collectedCoin):
	$CoinLabel.text = "%s/%s"%[collectedCoin, totalCoin]

func on_collected_coin_changed(totalCoin, collectedCoin):
	update_display(totalCoin, collectedCoin)
