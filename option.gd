extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://main-menu.tscn")

var music_on := true

func _on_music_pressed() -> void:
	if Backsound.playing:
		Backsound.stop()
		music_on = false

	else:
		Backsound.play()
		music_on = true
