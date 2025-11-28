class_name Note
extends Resource

##Titulo que se vera en el menu de inventario
@export var title:String
##Icono que se mostrara en el inventario
@export var inventory_icon:Texture2D
##Texto que tendra la nota
@export var note_text:String

##Tipo de objeto "item" o "key"
@export var obj_type:String

@export_group("Testeo")
@export var color_test:Color 

##En caso de que el objeto tenga un dialogo que reproducir al interactuar con el
@export var dialogo:DialogicTimeline
