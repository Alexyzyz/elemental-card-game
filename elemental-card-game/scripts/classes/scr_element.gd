class_name Element

enum ElementType {
	PYRO,
	CRYO,
	HYDRO,
	ELECTRO,
}

static var ELEMENT_COLOR: Dictionary = {
	ElementType.PYRO: Color.ORANGE,
	ElementType.CRYO: Color.CYAN,
	ElementType.HYDRO: Color.BLUE,
	ElementType.ELECTRO: Color.PURPLE,
}
