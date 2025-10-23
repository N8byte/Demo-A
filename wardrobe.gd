extends CSGBox3D

var open := false
var player_here := false
var player_color := Color(190, 190, 190)
var color_panel_override : StyleBoxFlat
var player_material_override: StandardMaterial3D
@onready var player_name: String = %player_label.text

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func update_player_color() -> void:
	color_panel_override.bg_color = player_color
	player_material_override.albedo_color = player_color


func update_player_name() -> void:
	%player_label.text = player_name


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey && event.is_action_pressed('interact'):
		if not player_here: return
		get_viewport().set_input_as_handled()
		if not open:
			open = true
			%color_select_ui.visible = true
			%wardrobe_label.visible = false
			%camera_animations.play('go_to_wardrobe')
			%alert_label.visible = false
		else:
			open = false
			%color_select_ui.visible = false
			%camera_animations.play_backwards('go_to_wardrobe')


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == %player1:
		player_here = true
		%wardrobe_animations.play('open')
		%wardrobe_label.visible = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == %player1:
		player_here = false
		if open:
			%camera_animations.play_backwards('go_to_wardrobe')
			open = false
		%color_select_ui.visible = false
		%wardrobe_animations.play('close')
		%wardrobe_label.visible = false


func _on_color_panel_ready() -> void:
	color_panel_override = %color_panel.get_theme_stylebox('panel')
	color_panel_override.bg_color = player_color


func _on_red_slider_value_changed(value: float) -> void:
	player_color.r = value
	update_player_color()


func _on_green_slider_value_changed(value: float) -> void:
	player_color.g = value
	update_player_color()


func _on_blue_slider_value_changed(value: float) -> void:
	player_color.b = value
	update_player_color()


func _on_player_mesh_ready() -> void:
	player_material_override = %player_mesh.material_override


func _on_color_select_ui_done_pressed() -> void:
	%color_select_ui.visible = false
	%camera_animations.play_backwards('go_to_wardrobe')


func _on_line_edit_text_changed(new_text: String) -> void:
	player_name = new_text
	update_player_name()


func _on_item_list_item_selected(index: int) -> void:
	for child in %player_hats.get_children():
		child.visible = false
	if index > 0:
		%player_hats.get_child(index - 1).visible = true


func _on_hats_ui_done_pressed() -> void:
	%color_select_ui.visible = false
	%camera_animations.play_backwards('go_to_wardrobe')
