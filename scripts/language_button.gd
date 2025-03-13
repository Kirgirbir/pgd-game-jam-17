extends Button

@onready var LocalizationList = ["ru", "en"]
@onready var selected_locale: int = 0

func loop_locale() -> int:
	if self.selected_locale == 1:
		selected_locale = 0
	else:
		selected_locale += 1
	return selected_locale

func _on_button_pressed() -> void:
	TranslationServer.set_locale(LocalizationList[loop_locale()])
