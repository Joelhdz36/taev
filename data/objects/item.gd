class_name Item
extends Resource

##Titulo que se vera en el menu de inventario
@export var title:String
##Icono que se mostrara en el juego 16x16
@export var game_icon:Texture2D
##Icono que se mostrara en el inventario 300x300
@export var inventory_icon:Texture2D
##Texto que tendra la nota
@export var note_text:String

##Tipo de objeto "item" o "key"
@export var obj_type:String
##En caso de que el objeto tenga un dialogo que reproducir al interactuar con el
@export var dialogo:DialogicTimeline


@export_group("Testeo")
@export var color_test:Color 
