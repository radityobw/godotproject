extends Control


func _on_home_pressed() -> void:
	SelectSfx.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://scene/main-menu.tscn")


var music_on := true

func _on_music_pressed() -> void:
	SelectSfx.play()
	await get_tree().create_timer(0.25).timeout
	if Backsound.playing:
		Backsound.stop()
		music_on = false

	else:
		Backsound.play()
		music_on = true


func _on_unknown_pressed() -> void:
	Backsound.stop()
	get_tree().change_scene_to_file("res://scene//tools/dreamcore.tscn")
