extends Node


const DEFAULT_PORT  = 28960 
const MAX_CLIENTS = 6
var server = null
var client = null
var ip_address = "127.0.0.1"

func create_server():
	print("creating server")
	server = NetworkedMultiplayerENet.new()
