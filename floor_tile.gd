extends StaticBody3D
class_name FloorTile

@export var IsActive := false
@export var IsSelected := false
@export var SelectedMaterial :StandardMaterial3D
@export var MeshType : Mesh

@onready var mesh = $mesh
signal SelectedChanged

# Called when the node enters the scene tree for the first time.
func _ready():
	mesh.mesh = MeshType
	if mesh.position != null and MeshType.height != null:
		mesh.position.y = MeshType.height / 2 * -1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	checkOverlay()
	
			
func checkOverlay():
	if IsActive and IsSelected:
		mesh.material_overlay = SelectedMaterial
	elif IsActive == false or IsSelected == false:
		mesh.material_overlay = null


func _on_mouse_entered():
	if IsActive:
		IsSelected = true


func _on_mouse_exited():
	if IsActive:
		IsSelected = false


func _on_input_event(camera, event, position, normal, shape_idx):
	if IsSelected and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		SelectedChanged.emit(self, self.position);


func _on_property_list_changed():
	checkOverlay()
