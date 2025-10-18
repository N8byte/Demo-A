extends CSGCylinder3D


var player_here := false
var sunk := false

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
	#pass


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action("interact") and player_here and event.is_pressed():
		if %AnimationPlayer.is_playing():
			return
		if (sunk):
			%AnimationPlayer.play('rise')
			sunk = false
			print('rising')
		else:
			%AnimationPlayer.play('sink')
			%Label3D.visible = false
			sunk = true
			print('sinking')


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == &'CharacterBody3D':
		%Label3D.visible = true
		player_here = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == &'CharacterBody3D':
		%Label3D.visible = false
		player_here = false
