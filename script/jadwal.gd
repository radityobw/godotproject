extends Control

@onready var scroll_container: ScrollContainer = $ScrollContainer
@onready var openscrollbtn: Button = $openscrollbtn
@onready var closescrollbtn: Button = $closescrollbtn




func _ready() -> void:
	scroll_container.visible = false
	closescrollbtn.visible = false




func _on_home_pressed() -> void:
	SelectSfx.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://scene/lv1.tscn")


func _on_openscrollbtn_pressed() -> void:
	SelectSfx.play()
	await get_tree().create_timer(0.25).timeout
	scroll_container.visible = true
	openscrollbtn.visible = false
	closescrollbtn.visible = true


func _on_closescrollbtn_pressed() -> void:
	SelectSfx.play()
	await get_tree().create_timer(0.25).timeout
	scroll_container.visible = false
	openscrollbtn.visible = true
	closescrollbtn.visible = false
