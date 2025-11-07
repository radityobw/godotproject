extends Control

@onready var fade = $Fade

# Nama plugin notifikasi (ganti sesuai kebutuhan)
#var _plugin_name = "utilsgodot"
#var _android_plugin


func _ready() -> void:
	
	# Cek apakah plugin Android aktif
	#if Engine.has_singleton(_plugin_name):
		#_android_plugin = Engine.get_singleton(_plugin_name)
	#else:
		#printerr("Couldn't find plugin: " + _plugin_name)

	# --- Efek Fade In pada saat scene dimulai ---
	fade.modulate.a = 1.0
	fade.mouse_filter = Control.MOUSE_FILTER_STOP  # tangkap input sementara

	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0.0, 1.0)  # durasi 1 detik
	await tween.finished

	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE  # izinkan input
	fade.visible = false  # opsional, sembunyikan fade sepenuhnya


# --- Fungsi tombol Start ---
func _on_start_pressed() -> void:
	SelectSfx.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://scene/level-select.tscn")


# --- Fungsi tombol Option ---
func _on_option_pressed() -> void:
	SelectSfx.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://scene/option.tscn")


# --- Fungsi tombol Exit ---
func _on_exit_pressed() -> void:
	SelectSfx.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().quit()
