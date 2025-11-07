extends Control

func _on_backlv2_pressed() -> void:
	SelectSfx.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://scene/level-select.tscn")



func _on_senang_pressed() -> void:
	SelectSfx.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://scene/emosi/senang.tscn")


func _on_marah_pressed() -> void:
	SelectSfx.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://scene/emosi/marah.tscn")


func _on_sedih_pressed() -> void:
	SelectSfx.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://scene/emosi/sedih.tscn")


func _on_terkejut_pressed() -> void:
	SelectSfx.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://scene/emosi/terkejut.tscn")


func _on_malu_pressed() -> void:
	SelectSfx.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://scene/emosi/malu.tscn")


func _on_takut_pressed() -> void:
	SelectSfx.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://scene/emosi/takut.tscn")
