extends CSGCylinder3D


var player_here := false
var sunk := false

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
	#pass


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("interact") and player_here:
		if (sunk):
			%AnimationPlayer.play('rise')
			sunk = false
		else:
			%AnimationPlayer.play_backwards('rise')
			%Label3D.visible = false
			sunk = true
		get_viewport().set_input_as_handled()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == %player1:
		%Label3D.visible = true
		player_here = true
		%camera_animations.play('go_to_elevator')


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == %player1:
		%Label3D.visible = false
		player_here = false
		%camera_animations.play_backwards('go_to_elevator')
