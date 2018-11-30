extends Node

export (PackedScene) var Coin
export (int) var playtime

var level
var score
var time_left
var screensize
var playing = false

func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	$Player.screensize = screensize
	$Player.hide()
	
func new_game():
	playing = true
	level = 1
	score = 0
	time_left = playtime
	$Player.start($PlayerStart.position)
	$Player.show()
	$GameTime.start()
	spawn_coins()
	$HUD.update_score(score)
	$HUD.update_timer(time_left)

func spawn_coins():
	for i in range(4 + level):
		var c = Coin.instance()
		$CoinContainer.add_child(c)
		c.screensize = Vector2(63,633)
		c.position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))

func _on_GameTime_timeout():
	time_left -= 1
	$HUD.update_timer(time_left)
	if time_left <= 0:
		game_over()

func _on_Player_hurt():
	game_over()


func _on_Player_pickup():
	score += 1
	$HUD.update_score(score)
	
func game_over():
	playing = false
	$GameTime.stop()
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	$HUD.show_game_over()
	$Player.die()
