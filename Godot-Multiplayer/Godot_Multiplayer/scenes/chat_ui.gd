extends Control
class_name ChatUI
#Les signaux sont utilisés pour notifier d'autres parties du programme lorsque certains événements se produisent.
signal signal_is_typing
signal signal_done_typing

@onready var chat_log = $MarginContainer/HBoxContainer/VBoxContainer/ChatLogLabel
@onready var chat_line_edit = $MarginContainer/HBoxContainer/VBoxContainer/ChatLineEdit
var current_time = Time.get_unix_time_from_system() 
var current_date = Time.get_datetime_string_from_unix_time(Time.get_unix_time_from_system())
var new_clock
func _ready():
	# Emit is_typing signal when you click on line edit
	chat_line_edit.focus_entered.connect(on_focus_entered)
	chat_line_edit.focus_exited.connect(on_focus_exited)
	# Obtenir le temps UNIX actuel
	#send_time.rpc(current_time)
	print("Date actuelle :", current_date)

func _process(delta):
	current_time += delta
func _input(_event):
	if Input.is_action_just_pressed("enter"):
		write_msg()
	if Input.is_action_pressed("escape"):
		chat_line_edit.release_focus()
		
		
func write_msg():
	#send_time.rpc(current_time)
	if !chat_line_edit.text.is_empty():
		#receive_msg.rpc(": " + new_clock)
		receive_msg.rpc(": " + Time.get_datetime_string_from_unix_time(Time.get_unix_time_from_system() + 3600))
		receive_msg.rpc(str(multiplayer.get_unique_id()) + ": " + chat_line_edit.text)
		print(multiplayer.get_unique_id())
		chat_line_edit.text = ""

# call_local allows the server to run the rpc function on itself and also on clients
# any_peer allows the clients to run the rpc function on the server
# reliable means the network packets will not be lost, packets will be sent until received and acknowledged
# send the rpc on rpc channel 1 (to keep message traffic off of the standard movement traffic)
@rpc("call_local", "any_peer", "reliable", 1)
func receive_msg(msg: String):
	chat_log.text = chat_log.text + "\n" + msg

#@rpc("authority")
#func send_time(current_time):
#	pass

#@rpc("any_peer")func send_server_time (client_time, server_time):
#	var latence = Time.get_unix_time_from_system() - client_time
#	new_clock = server_time + latence
#	pass

func on_focus_entered():
	signal_is_typing.emit()

func on_focus_exited():
	signal_done_typing.emit()
