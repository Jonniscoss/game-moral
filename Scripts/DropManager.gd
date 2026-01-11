extends Node

var drop_texts := [
	"Adão é criado a partir do pó da terra. Seu nome vem de “adamah”, que em hebraico significa “solo”.",
	"Eva é criada a partir do lado de Adão, simbolizando igualdade, parceria e companheirismo — não inferioridade.",
	"A Bíblia nunca diz que o fruto proibido era uma maçã. Essa ideia vem da arte europeia e do latim “malum”, que significa “mal” e “maçã”.",
	"A serpente simboliza tentação e questionamento, mas nunca é identificada como o diabo no texto bíblico original.",
	"Ao perceberem que estão nus, Adão e Eva perdem a inocência e ganham consciência moral e responsabilidade.",
	"A mortalidade surge como consequência: o ser humano vem do pó e a ele retorna.",
	"Adão e Eva não morrem imediatamente. “Morrer” significa entrar na condição de mortalidade.",
	"A palavra “Éden” significa “delícia” ou “prazer”. Perdê-lo simboliza a perda de uma vida sem sofrimento.",
	"A ideia de que Eva foi a única culpada pela queda surgiu depois. No texto original, ambos são responsáveis.",
	"A árvore do conhecimento não representa inteligência, mas maturidade moral: saber distinguir o bem e o mal.",
	
]

var remaining_drops := []
var total := 0
var collected := 0

func _ready():
	remaining_drops = drop_texts.duplicate()
	total = drop_texts.size()
	collected = 0

func get_drop_text() -> String:
	if remaining_drops.size() == 0:
		return "null"
	var index = randi() % remaining_drops.size()
	var chosen_text = remaining_drops[index]
	remaining_drops.remove_at(index)
	return chosen_text

# Call this **when a scroll is picked up**
func mark_collected():
	collected += 1

# Check if all scrolls have been collected
func is_last_drop() -> bool:
	return collected >= total
