extends Control

@onready var correctpanel: Panel = $correctpanel
@onready var wrongpanel: Panel = $wrongpanel


func _on_backsenang_pressed() -> void:
	SelectSfx.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://scene/lv2.tscn")

func _ready() -> void:
	correctpanel.visible = false
	wrongpanel.visible = false

func _on_btn_1_pressed() -> void:
	Correctsfx.play()
	correctpanel.visible = true
	await get_tree().create_timer(2).timeout
	correctpanel.visible = false


func _on_btn_2_pressed() -> void:
	Wrongsfx.play()
	wrongpanel.visible = true
	await get_tree().create_timer(2).timeout
	wrongpanel.visible = false
