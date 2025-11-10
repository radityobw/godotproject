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
	preview_texture.position=Vector2(-100,-100)
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
	
	config.save("user://inventory.cfg")
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
	var err = config.load("user://inventory.cfg")
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




#
## --- UTIL ------------------------------------------------
#func _load_texture_from_inventory():
	#var item_name = InventoryManager.items.get(slot_id, "")
	#if item_name == "":
		#print("No item in", slot_id)
		#return
#
	#var texture_path = "res://assets/items/%s.png" % item_name
	#if ResourceLoader.exists(texture_path):
		#$TextureRect.texture = load(texture_path)
		#print("Loaded texture for", slot_id, "->", texture_path)
	#else:
		#var imported_path = "res://.godot/imported/%s.png-18ec9058071d8b38dc8e29c3f5a83b56.ctex" % item_name
		#if ResourceLoader.exists(imported_path):
			#$TextureRect.texture = load(imported_path)
			#print("Loaded imported texture for", slot_id, "->", imported_path)
		#else:
			#print("Texture not found for", slot_id, "item:", item_name)




























#@export var slot_id := ""  # unik per slot, misal "grid_0" atau "scroll_1"
#var item_name := ""
#
#func _ready():
	##await get_tree().process_frame  # beri 1 frame supaya autoload siap
##
	##print("Slot ready:", slot_id)
	##print("InventoryManager items:", InventoryManager.items)
##
	### Ambil data dari inventory manager
	##if InventoryManager.items.has(slot_id):
		##item_name = InventoryManager.items[slot_id]
		##if item_name != "":
			##texture = load("res://icons/%s.png" % item_name)
	##else:
		##print("No item in", slot_id)
		## tunggu satu frame dulu agar autoload sempat _ready() (fallback)
#
	##await get_tree().process_frame
##
	### jika items masih kosong, coba konek ke sinyal inventory_loaded
	##if InventoryManager.items.size() == 0:
		##print("Slot", slot_id, "seems to see empty InventoryManager.items; connecting to inventory_loaded.")
		##InventoryManager.connect("inventory_loaded", Callable(self, "_on_inventory_loaded"))
	##else:
		##_on_inventory_loaded()
#
	#print("Slot ready:", name, "InventoryManager items now:", InventoryManager.items)
	#var item_name = InventoryManager.items.get(name, "")
	#if item_name != "":
		#var texture_path = "res://assets/items/%s.png" % item_name
		#if ResourceLoader.exists(texture_path):
			#$TextureRect.texture = load(texture_path)
			#print("Loaded texture for", name, "->", texture_path)
		#else:
			## coba path lain (misal hasil import)
			#var imported_path = "res://.godot/imported/%s.png-18ec9058071d8b38dc8e29c3f5a83b56.ctex" % item_name
			#if ResourceLoader.exists(imported_path):
				#$TextureRect.texture = load(imported_path)
				#print("Loaded imported texture for", name, "->", imported_path)
			#else:
				#print("Texture not found for", name, "item:", item_name)
	#else:
		#print("No item in", name)
	#
#func _on_inventory_loaded():
	#print("Slot ready:", slot_id, "InventoryManager items now:", InventoryManager.items)
	#if InventoryManager.items.has(slot_id):
		#item_name = InventoryManager.items[slot_id]
		#if item_name != "":
			#var tex = load("res://icons/%s.png" % item_name)
			#if tex:
				#texture = tex
			#else:
				#printerr("Slot", slot_id, "failed to load icon for", item_name)
	#else:
		#print("No item in", slot_id)
#
#func _get_drag_data(_pos):
	#if item_name == "":
		#return null
#
	#var preview := TextureRect.new()
	#preview.texture = texture
	#preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	#set_drag_preview(preview)
	#return {"item_name": item_name, "origin": self}
#
#func _can_drop_data(_pos, data):
	#return data.has("item_name")
#
#func _drop_data(_pos, data):
	#var origin = data["origin"]
	#if origin == self:
		#return  # Jangan tukar dengan diri sendiri
#
	## Tukar item
	#var temp := item_name
	#item_name = data["item_name"]
	#texture = origin.texture
#
	#origin.item_name = temp
	#if temp == "":
		#origin.texture = null
	#else:
		#origin.texture = load("res://icons/%s.png" % temp)
#
	## Simpan ke inventory
	#InventoryManager.items[slot_id] = item_name
	#InventoryManager.items[origin.slot_id] = origin.item_name
	#InventoryManager.save_inventory()
























#@export var slot_id := ""  # unik per slot, misal "grid_1", "scroll_3"
#var item_name := ""  # nama item yang sedang dipegang slot ini
#
#func _ready():
	## Load data dari inventory manager
	#if InventoryManager.items.has(slot_id):
		#item_name = InventoryManager.items[slot_id]
		#texture = load("res://icons/%s.png" % item_name)
#
#func _get_drag_data(_pos):
	#if item_name == "":
		#print("No item in ", slot_id)
		#return null
	#
	#print("Dragging from", slot_id)
	#SelectSfx.play()
	#var preview = TextureRect.new()
	#preview.texture = texture
	#preview.expand_mode = 1
	#set_drag_preview(preview)
	#return {"item_name": item_name, "origin": self}
#
#func _can_drop_data(_pos, data):
	##return data.has("item_name")
	#return typeof(data) == TYPE_DICTIONARY and data.has("item_name")
#
#func _drop_data(_pos, data):
	## Tukar item antara slot asal dan slot tujuan
	#var origin = data["origin"]
	#var temp = item_name
	#item_name = data["item_name"]
	#texture = origin.texture
	#
	#SelectSfx.play()
	#print("Dropped on", slot_id, "data:", data)
	#origin.item_name = temp
	#if temp == "":
		#origin.texture = null
	#else:
		#origin.texture = load("res://icons/%s.png" % temp)
#
	## Simpan perubahan
	#InventoryManager.items[slot_id] = item_name
	#InventoryManager.items[origin.slot_id] = origin.item_name
	#InventoryManager.save_inventory()

























#func _get_drag_data(_at_position):
	##if texture == null:
		##return null  # Tidak bisa drag kalau slot kosong
##
		### Mainkan SFX saat mulai drag
	##SelectSfx.play()
	##
	### Buat tampilan preview (ghost image) saat drag
	##var preview_texture = TextureRect.new()
	##preview_texture.texture = texture
	##preview_texture.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	##preview_texture.size = Vector2(181, 190)
##
	##var preview = Control.new()
	##preview.add_child(preview_texture)
	##set_drag_preview(preview)
##
	### Kirim data yang dibawa saat drag
	##var data = {
		##"texture": texture,
		##"source": self
	##}
	##return data
	#
	#if texture == null:
		#return null
#
	#SelectSfx.play()
#
	#var preview_texture = TextureRect.new()
	#preview_texture.texture = texture
	#preview_texture.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	#preview_texture.size = Vector2(181, 190)
#
	#var preview = Control.new()
	#preview.add_child(preview_texture)
	#set_drag_preview(preview)
#
	#var data = {
		#"texture": texture,
		#"source": self
	#}
	#return data
#
#
#
#func _can_drop_data(_pos, data):
	#return typeof(data) == TYPE_DICTIONARY and data.has("texture") and data["source"] != self
#
	#
#
#func _drop_data(_pos, data):
	#SelectSfx.play()
	##if typeof(data) == TYPE_DICTIONARY and data.has("texture"):
		##SelectSfx.play()
##
		### Kalau sumber dan target sama, jangan lakukan apa-apa
		##if data["source"] == self:
			##return
##
		### Jika berbeda, baru tukar
		##texture = data["texture"]
		##data["source"].texture = null
	#if typeof(data) == TYPE_DICTIONARY and data.has("texture"):
		#if data["source"] == self:
			#return
		#
		#texture = data["texture"]
		#data["source"].texture = null
		
		### Setelah berhasil drag & drop, simpan ke file
		##var parent = get_parent()  # asumsi parent-nya VBoxContainer
		##var slots = parent.get_children()
		##InventoryManager.save_inventory(slots)
			## Simpan otomatis setelah drag & drop berhasil
	#var parent := get_parent()
	#if parent:
		#var slots := parent.get_children()
		#InventoryManager.save_inventory(slots)

#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
##extends TextureRect
##
##
##func _get_drag_data(_at_position):
	##
	##var preview_texture = TextureRect.new()
	##
	##preview_texture.texture = texture
	##preview_texture.expand_mode = 1
	##preview_texture.size = Vector2(181,190)
	##
	##var preview = Control.new()
	##preview.add_child(preview_texture)
	##
	##set_drag_preview(preview)
	##texture = null
	##
	##return preview_texture.texture
##
##func _can_drop_data(_pos, data):
	##return data is Texture2D
##
##func _drop_data(_pos, data):
	##texture = data
