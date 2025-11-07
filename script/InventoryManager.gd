extends Node
##
#var save_path := "user://inventory_save.json"
#
#var contents_to_save: Dictionary= {
	#"grid_0": TextureRect,
	#"grid_1": "",
	#"grid_2": "",
	#"grid_3": "",
	#"grid_4": "",
	#"grid_5": "",
	#"grid_6": "",
	#"grid_7": "",
	#"grid_8": "",
	#"grid_9": "",
	#"scroll_0": "ioboldcat",
	#"scroll_1": "ioboldcat",
	#"scroll_2": "ioboldcat",
	#"scroll_3": "ioboldcat",
	#"scroll_4": "ioboldcat",
	#"scroll_5": "ioboldcat",
	#"scroll_6": "ioboldcat",
	#"scroll_7": "ioboldcat",
	#"scroll_8": "ioboldcat",
	#"scroll_9": "ioboldcat",
	#
#}
#
#func _save():
	#var file = FileAccess.open(save_path, FileAccess.WRITE)
	#file.store_var(contents_to_save.duplicate())
	#file.close()
	#
#func _load():
	#if FileAccess.file_exists(save_path):
		#var file = FileAccess.open(save_path, FileAccess.READ)
		#var data = file.get_var()
		#file.close()
		#
		#var savedata = data.duplicate()
		#contents_to_save.grid_0 = savedata.grid_0

























#signal inventory_loaded
#
#var save_path := "user://inventory_save.json"
#var items := {} # slot_id -> item_name
#
#func _ready():
	#print("---------------- InventoryManager _ready() ----------------")
	#print("OS.get_user_data_dir():", OS.get_user_data_dir())
	#print("Resolved save_path:", save_path)
	#load_inventory()
	#emit_signal("inventory_loaded")
	#print("---------------- end InventoryManager _ready() ----------------")
#
#
#func save_inventory() -> void:
	#print("[InventoryManager] save_inventory() called. items:", items)
	#var file = FileAccess.open(save_path, FileAccess.WRITE)
	#if file:
		#file.store_string(JSON.stringify(items))
		#file.close()
		#print("[InventoryManager] Inventory saved to:", save_path)
	#else:
		#printerr("[InventoryManager] ERROR: Failed to open file for writing.")
#
#
#func load_inventory() -> void:
	#print("[InventoryManager] load_inventory() called.")
	#if not FileAccess.file_exists(save_path):
		#print("[InventoryManager] No save file found, creating default.")
		#_reset_to_default()
		#save_inventory()
		#return
	#
	#var file = FileAccess.open(save_path, FileAccess.READ)
	#if not file:
		#printerr("[InventoryManager] ERROR: failed to open file for read.")
		#_reset_to_default()
		#save_inventory()
		#return
	#
	#var text = file.get_as_text()
	#file.close()
#
	#if text.strip_edges().is_empty():
		#printerr("[InventoryManager] File empty, resetting defaults.")
		#_reset_to_default()
		#save_inventory()
		#return
#
	#var parsed = JSON.parse_string(text)
	#if typeof(parsed) == TYPE_DICTIONARY:
		#items = parsed
		#print("[InventoryManager] Loaded items:", items)
	#else:
		#printerr("[InventoryManager] Invalid JSON, resetting defaults.")
		#_reset_to_default()
		#save_inventory()
#
#
#func _reset_to_default() -> void:
	#items = {
		#"grid_0": "ioboldcat",
		#"grid_1": "",
		#"grid_2": "",
		#"grid_3": "",
		#"grid_4": "",
		#"grid_5": "",
		#"grid_6": "",
		#"grid_7": "",
		#"grid_8": "",
		#"grid_9": "",
		#"scroll_0": "",
		#"scroll_1": "",
		#"scroll_2": "",
		#"scroll_3": "",
		#"scroll_4": "",
		#"scroll_5": "",
		#"scroll_6": "",
		#"scroll_7": "",
		#"scroll_8": "",
		#"scroll_9": "",
	#}





























#signal inventory_loaded
#
#var save_path := "user://inventory_save.json"
#var items := {} # slot_id -> item_name
#
#func _ready():
	#print("---------------- InventoryManager _ready() ----------------")
	#print("Is autoload? Trying to print global name: InventoryManager ->", typeof(InventoryManager) != TYPE_NIL)
	#print("OS.get_user_data_dir():", OS.get_user_data_dir())
	#print("Resolved save_path:", save_path)
	## Cek apakah file ada
	#print("File exists:", FileAccess.file_exists(save_path))
	## Panggil load
	#load_inventory()
	#emit_signal("inventory_loaded")
	#print("---------------- end InventoryManager _ready() ----------------")
#
#func save_inventory() -> void:
	#print("[InventoryManager] save_inventory() called. items:", items)
	#var ok_file := FileAccess.open(save_path, FileAccess.WRITE)
	#if not ok_file:
		#printerr("[InventoryManager] ERROR: failed to open file for write:", save_path)
		#return
	#ok_file.store_string(JSON.stringify(items))
	#ok_file.close()
	#print("[InventoryManager] WROTE file:", save_path)
	## show full filesystem location (helpful to find file on disk)
	#print("[InventoryManager] Full user data dir (OS.get_user_data_dir()):", OS.get_user_data_dir())
#
##func load_inventory() -> void:
	##print("[InventoryManager] load_inventory() called.")
	### Jika file tidak ada, buat default dan simpan
	##if not FileAccess.file_exists(save_path):
		##print("[InventoryManager] No save file found. Creating default data and saving.")
		##items = {
			##"grid_0": "ioboldcat",
			##"grid_1": "",
			##"grid_2": "",
			##"grid_3": "",
			##"grid_4": "",
			##"grid_5": "",
			##"grid_6": "",
			##"grid_7": "",
			##"grid_8": "",
			##"grid_9": "",
			##"scroll_0": "",
			##"scroll_1": ""
		##}
		### pastikan kita bisa menulis
		##save_inventory()
		##return
#
#func load_inventory() -> void:
	#print("[InventoryManager] load_inventory() called.")
	#var should_reset := false
#
	#if not FileAccess.file_exists(save_path):
		#print("[InventoryManager] No save file found. Will create default.")
		#should_reset = true
	#else:
		#var f := FileAccess.open(save_path, FileAccess.READ)
		#if not f:
			#printerr("[InventoryManager] ERROR: failed to open file for read:", save_path)
			#should_reset = true
		#else:
			#var text := f.get_as_text()
			#f.close()
			#print("[InventoryManager] Read file raw text:", text)
			#if text.strip_edges().is_empty():
				#printerr("[InventoryManager] WARNING: file is empty. Will reset to defaults.")
				#should_reset = true
			#else:
				#var parsed = JSON.parse_string(text)
				#if typeof(parsed) == TYPE_DICTIONARY:
					#items = parsed
					#print("[InventoryManager] Parsed items:", items)
				#else:
					#printerr("[InventoryManager] WARNING: JSON invalid or not a dictionary. Resetting defaults.")
					#should_reset = true
#
	#if should_reset:
		#items = {
			#"grid_0": "ioboldcat",
			#"grid_1": "",
			#"grid_2": "",
			#"grid_3": "",
			#"grid_4": "",
			#"grid_5": "",
			#"grid_6": "",
			#"grid_7": "",
			#"grid_8": "",
			#"grid_9": "",
			#"scroll_0": "",
			#"scroll_1": "",
			#"scroll_2": "",
			#"scroll_3": "",
			#"scroll_4": "",
			#"scroll_5": "",
			#"scroll_6": "",
			#"scroll_7": "",
			#"scroll_8": "",
			#"scroll_9": "",
		#}
		#save_inventory()
#
#
	## Kalau file ada, baca isinya
	#var f := FileAccess.open(save_path, FileAccess.READ)
	#if not f:
		#printerr("[InventoryManager] ERROR: failed to open file for read:", save_path)
		#return
	#var text := f.get_as_text()
	#f.close()
	#print("[InventoryManager] Read file raw text:", text)
	#var parsed = JSON.parse_string(text)
	## JSON.parse_string dapat mengembalikan Dictionary/Array tergantung isi
	#if typeof(parsed) == TYPE_DICTIONARY:
		#items = parsed
		#print("[InventoryManager] Parsed items (dictionary):", items)
	#else:
		## Jika parse gagal atau bukan dict, laporkan dan reset
		#printerr("[InventoryManager] WARNING: parsed json is not a dictionary. type:", typeof(parsed))
		#items = {}























#var save_path := "user://inventory_save.json"
#var items := {} # Dictionary: slot_id -> item_name
#
#func _ready():
	#load_inventory()
	#
#
#func save_inventory():
	#var file = FileAccess.open(save_path, FileAccess.WRITE)
	#if file:
		#file.store_string(JSON.stringify(items))
		#file.close()
#
#func load_inventory():
	#if not FileAccess.file_exists(save_path):
		## Buat data awal bila belum ada
		#items = {
			#"grid_0": "ioboldcat",
			#"grid_1": "",
			#"grid_2": "",
			#"grid_3": "",
			#"grid_4": "",
			#"grid_5": "",
			#"grid_6": "",
			#"grid_7": "",
			#"grid_8": "",
			#"grid_9": "",
#
			#"scroll_0": "",
			#"scroll_1": "",
			#"scroll_2": "",
			#"scroll_3": "",
			#"scroll_4": "",
			#"scroll_5": "",
			#"scroll_6": "",
			#"scroll_7": "",
			#"scroll_8": "",
			#"scroll_9": "",
		#}
		#save_inventory()
	#else:
		#var file = FileAccess.open(save_path, FileAccess.READ)
		#var data = JSON.parse_string(file.get_as_text())
		#file.close()
#
		#if typeof(data) == TYPE_DICTIONARY:
			#items = data
		#else:
			#items = {}


























#var save_path = "user://inventory_save.json"
#var items = {}  # ini dictionary utama yang menyimpan semua slot_id -> item_name
#
#func _ready():
	#load_inventory()
#
#func save_inventory():
	##var file = FileAccess.open(save_path, FileAccess.WRITE)
	##file.store_string(JSON.stringify(items))
	##file.close()
	#var file = FileAccess.open(save_path, FileAccess.WRITE)
	#var data = {}
	#for key in items.keys():
		#var tex = items[key]
		#if tex is Texture2D and tex.resource_path.begins_with("res://.godot/"):
			## coba tebak nama file asli dari namanya
			#var nameing = tex.resource_path.get_file().split(".")[0]  # ambil 'ioboldcat'
			#data[key] = "res://items/%s.png" % nameing
		#else:
			#data[key] = tex
	#file.store_string(JSON.stringify(data))
	#file.close()
#
#
#func load_inventory():
	##if not FileAccess.file_exists(save_path):
		### --- data awal jika belum ada file ---
		##items = {
			##"grid_0": "ioboldcat",
##
		##}
		##save_inventory()
		##return
##
	##var file = FileAccess.open(save_path, FileAccess.READ)
	##var data = JSON.parse_string(file.get_as_text())
	##file.close()
##
	##if typeof(data) == TYPE_DICTIONARY:
		##items = data
	#if not FileAccess.file_exists(save_path):
		#return
	#var file = FileAccess.open(save_path, FileAccess.READ)
	#var data = JSON.parse_string(file.get_as_text())
	#file.close()
#
	#if typeof(data) == TYPE_DICTIONARY:
		#items = data
		#for slot_id in items:
			#var path = items[slot_id]
			#if path != "":
				#var tex = load(path)
				#var slot = get_node_or_null(slot_id)
				#if slot:
					#slot.texture = tex





























#var items := {}  # key = path unik slot, value = nama item atau data item
#
#func save_inventory():
	#var file = FileAccess.open("user://inventory.save", FileAccess.WRITE)
	#file.store_var(items)
	#file.close()
#
#func load_inventory():
	#if not FileAccess.file_exists("user://inventory.save"):
		#return
	#var file = FileAccess.open("user://inventory.save", FileAccess.READ)
	#items = file.get_var()
	#file.close()





























#extends Node
#
#var save_path = "user://inventory_save.json"
#
#
#func save_inventory(slots: Array):
	#var save_data = []
	#for slot in slots:
		#var item_path = ""
		#if slot.texture:
			#item_path = slot.texture.resource_path
		#save_data.append(item_path)
	#
	#var file = FileAccess.open(save_path, FileAccess.WRITE)
	#file.store_string(JSON.stringify(save_data))
	#file.close()
#
#func load_inventory(slots: Array):
	#if not FileAccess.file_exists(save_path):
		#return
	#
	#var file = FileAccess.open(save_path, FileAccess.READ)
	#var data = JSON.parse_string(file.get_as_text())
	#file.close()
	#
	#if typeof(data) != TYPE_ARRAY:
		#return
	#
	#for i in range(min(data.size(), slots.size())):
		#var path = data[i]
		#if path != "":
			#slots[i].texture = load(path)
		#else:
			#slots[i].texture = null
