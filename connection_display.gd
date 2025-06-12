extends Control

@onready var address_input: TextEdit = %AddressInput
@onready var connect_button: Button = %ConnectButton
@onready var disconnect_button: Button = %DisconnectButton

func _ready() -> void:
	disconnect_button.visible = false

func _on_connect_button_pressed() -> void:
	connect_button.visible = false
	disconnect_button.visible = true

func _on_disconnect_button_pressed() -> void:
	connect_button.visible = true
	disconnect_button.visible = false
