tool
extends EditorScript

var texture  = preload('res://sprites/temp.png')

func _run():

	var tile_size = 16
	var width = 16 * 8
	var height = 16

	var v = height / tile_size
	var h = width / tile_size

	var frame = 0
	var spacing = 10
	for i in range(h):
		for j in range(v):
			var sprite = Sprite.new()
			sprite.position = Vector2((tile_size*i) + spacing*i, (tile_size*j) + spacing*j)
			sprite.texture = texture
			sprite.hframes = h
			sprite.vframes = v
			sprite.frame = frame
			get_scene().add_child(sprite)
			sprite.set_owner(get_scene())
			frame += 1
	print('done')
