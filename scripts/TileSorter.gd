tool
extends EditorScript

func _run():
	var width = 500

	for child in get_scene().get_children():
		print(child.name)
		print(child.get_viewport_rect())

