extends VBoxContainer

#@export var texture_rect_scene: PackedScene
#
#func add_new_slot(texture: Texture2D):
	#var slot = texture_rect_scene.instantiate()
	#slot.texture = texture
	#add_child(slot)
#
#func _ready():
	#for i in range(get_child_count()):
		#var slot = get_child(i)
		#if slot is TextureRect:
			#slot.slot_id = "scroll_%d" % i
