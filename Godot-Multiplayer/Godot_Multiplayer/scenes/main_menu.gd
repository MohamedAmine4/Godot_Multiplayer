extends Control #hérite des fonctionnalités de la classe Control
class_name  MainMenu #Cette ligne définit le nom de la classe du script
#@onready permet d'éviter d'avoir à chercher manuellement les nœuds dans l'arbre de scène
@onready var host_button: Button = $MarginContainer/VBoxContainer/HostButton
@onready var join_button: Button = $MarginContainer/VBoxContainer/JoinButton
#démarrage du jeu, la variable address_entry est automatiquement initialisée avec la référence à l'objet LineEdit
#associé à "AddressEntry" dans la hiérarchie de nœuds.
@onready var address_entry: LineEdit = $MarginContainer/VBoxContainer/AddressEntry
@onready var player_name_entry: LineEdit = $MarginContainer/VBoxContainer/NameEntry

