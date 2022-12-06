extends WindowDialog

signal pressed()

# Lorsque le bouton est appuye, envoi un signal au Main pour commencer le niveau 1
func _on_Button_pressed():
	emit_signal("pressed")
