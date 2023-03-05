extends Node3D

@onready var cube := %cube
@onready var cubemesh := %cube/mesh
@onready var targetList := %tiles

@export var targetScene : PackedScene
@export var selectedMaterial := Material
@export var pawns : Array[PawnDetail]

@export var PawnColors: Array[Material]
@export var PawnMesh: Array[Mesh]

var cubeSelected := false
var cubeHover := false

var moveSpeed := 40

# Called when the node enters the scene tree for the first time.
func _ready():
	# generate stuff
	for i in range(0,16):
		var spacing = 1.8
		var row = i / 4
		var x = i + i % 4 - ( row % 4 * 2 )
		var y = 0.1		
		var z = i % 4 * spacing - ( row % 4 * spacing )
		var pos = Vector3(x, y, z)
		targetList.add_child(generateTargetScene(pos))
	
	# connect all events in the target list
	for target in targetList.get_children(false):
		target.SelectedChanged.connect(_handleSelectedChanged)
	
	pass # Replace with function body.

func generateTargetScene(pos):
	var result = targetScene.instantiate()
	
	result.position = pos
	
	return result

func _handleSelectedChanged(obj, pos):
	if cubeSelected:
		var tween = create_tween()
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(cube, "position", pos + Vector3.UP * 3, .5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
