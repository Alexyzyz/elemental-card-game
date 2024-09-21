class_name UtilMath

static func get_vector_from_angle(angle: float) -> Vector2:
	return Vector2(cos(angle), sin(angle))


static func get_angle_from_vector(vec: Vector2) -> float:
	return vec.angle()


static func exp_decay(a: float, b: float, decay: float, delta: float) -> float:
	return b + (a - b) * exp(-decay * delta)


static func exp_decay_vec2(a: Vector2, b: Vector2, decay: float, delta: float) -> Vector2:
	return b + (a - b) * exp(-decay * delta)


static func exp_decay_vec3(a: Vector3, b: Vector3, decay: float, delta: float) -> Vector3:
	return b + (a - b) * exp(-decay * delta)
