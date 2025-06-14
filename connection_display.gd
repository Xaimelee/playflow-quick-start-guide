extends Control

@onready var url_input: TextEdit = %UrlInput
@onready var port_input: TextEdit = %PortInput
@onready var connect_button: Button = %ConnectButton
@onready var disconnect_button: Button = %DisconnectButton

func _ready() -> void:
	disconnect_button.visible = false
	multiplayer.connection_failed.connect(_on_connection_failed)

func _on_connect_button_pressed() -> void:
	connect_button.visible = false
	disconnect_button.visible = true
	url_input.editable = false
	port_input.editable = false
	MultiplayerManager.start_client(url_input.text, port_input.text)

func _on_disconnect_button_pressed() -> void:
	connect_button.visible = true
	disconnect_button.visible = false
	url_input.editable = true
	port_input.editable = true
	MultiplayerManager.disconnect_from_server()

# If we are unable to connect then we enable the connect button and text inputs again.
func _on_connection_failed() -> void:
	connect_button.visible = true
	disconnect_button.visible = false
	url_input.editable = true
	port_input.editable = true
