extends TextureRect

#var slot_id: String = name

func _ready():
	_load_inventory()
	print("Slot ready:", name)
	#_load_texture_from_inventory()

# --- DRAG ------------------------------------------------
func _get_drag_data(_at_position):
	if texture == null:
		return null

	SelectSfx.play()

	var preview_texture = TextureRect.new()
	preview_texture.texture = texture
	preview_texture.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	preview_texture.size = Vector2(181, 190)

	var preview = Control.new()
	preview.add_child(preview_texture)
	set_drag_preview(preview)

	var data = {
		"texture": texture,
		"source": self
	}
	return data


func _can_drop_data(_pos, data):
	return typeof(data) == TYPE_DICTIONARY and data.has("texture") and data["source"] != self


func _drop_data(_pos, data):
	if typeof(data) == TYPE_DICTIONARY and data.has("texture"):
		if data["source"] == self:
			return
		
		SelectSfx.play()
		
		# Tukar di tampilan
		var temp_tex = texture
		texture = data["texture"]
		data["source"].texture = temp_tex
		
		#simpan data
		_autosave_inventory()
		
		## Tukar juga di inventory data global
		#var temp_item = InventoryManager.items.get(slot_id, "")
		#InventoryManager.items[slot_id] = InventoryManager.items.get(data["source"].slot_id, "")
		#InventoryManager.items[data["source"].slot_id] = temp_item
		#
		## Auto-save setiap kali ditukar
		#InventoryManager.save_inventory()
		#print("[Slot] Autosaved after swap:", InventoryManager.items)
		

func _autosave_inventory():
	#var config = ConfigFile.new()
	#var parent = get_parent()  # Asumsikan semua slot ada di node yang sama
	#for slot in parent.get_children():
		#if slot is TextureRect:
			#var tex_path = ""
			#if slot.texture and slot.texture.resource_path != "":
				#tex_path = slot.texture.resource_path
			#config.set_value("inventory", slot.name, tex_path)
	#config.save("user://inventory.cfg")
	#print("Autosaved inventory.")
	
	var config = ConfigFile.new()
	var root = get_tree().root.get_node(".") # ganti sesuai path-mu
	var all_slots = _get_all_slots(root)

	for slot in all_slots:
		var tex_path = ""
		if slot.texture and slot.texture.resource_path != "":
			tex_path = slot.texture.resource_path
		config.set_value("inventory", slot.name, tex_path)
	
	config.save("user://inventory3.cfg")
	print("Autosaved inventory with", all_slots.size(), "slots.")



func _load_inventory():
	#var config = ConfigFile.new()
	#var err = config.load("user://inventory.cfg")
	#if err != OK:
		#return
	#
	#var parent = get_parent()
	#for slot in parent.get_children():
		#if slot is TextureRect:
			#var tex_path = config.get_value("inventory", slot.name, "")
			#if tex_path != "":
				#slot.texture = load(tex_path)

	var config = ConfigFile.new()
	var err = config.load("user://inventory3.cfg")
	if err != OK:
		return
	
	var root = get_tree().root.get_node(".")
	var all_slots = _get_all_slots(root)

	for slot in all_slots:
		var tex_path = config.get_value("inventory", slot.name, "")
		if tex_path != "":
			slot.texture = load(tex_path)
		else:
			slot.texture = null
	print("Inventory loaded:", all_slots.size(), "slots.")


func _get_all_slots(root: Node) -> Array:
	var slots = []
	for child in root.get_children():
		if child is TextureRect:
			slots.append(child)
		elif child.get_child_count() > 0:
			slots += _get_all_slots(child)  # rekursif
	return slots
