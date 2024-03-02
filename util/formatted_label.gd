extends Label


@export var format_string: String


func apply_formatted_values(format_values):
	text = format_string % format_values
