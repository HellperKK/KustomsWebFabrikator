# encoding: UTF-8
def lienRetour(chemin)
	nom = File.basename(chemin, ".txt")
	if nom == "index2"
		""	
	elsif nom == "Index"
		parent = File.dirname(File.dirname(chemin))
		if parent == "Input"
			fichier = "../index2.html"
		else
			fichier = "../Index.html"
		end
		"<a href=\"#{fichier}\" class=\"retour\">Retour</a>"
	else
		parent = File.dirname(chemin)
		if parent == "Input"
			fichier = "index2.html"
		else
			fichier = "../Index.html"
		end
		"<a href=\"#{fichier}\" class=\"retour\">Retour</a>"
	end
end
def nbrParents(chemin)
	if File.dirname(chemin) == "Input"
		0
	else
		1 + nbrParents(File.dirname(chemin))
	end
end
def baliseCss(chemin)
	nbr = nbrParents(chemin)
	resultat = "Style.css"
	nbr = nbr *3 + resultat.length
	resultat = resultat.rjust(nbr, "../")
	"<link rel=\"stylesheet\" href=\"#{resultat}\">"
end
def to_html(chemin)
	raw = File.open(chemin,'r').read
	##Début du bloc head
	page = "<!DOCTYPE html>\n<html>\n    <head>\n"
	##Ajout de la balise titre
	if (raw.include?("#TI"))&&(raw.include?("TI#"))
		deb = raw.rindex("#TI") + 3
		fin = raw.rindex("TI#") -2
		titre =  raw[deb..fin].strip
		raw = raw.sub("#TI #{titre} TI#", "")
		page += "        <title>#{titre}</title>\n        "
	##Ajout de début de la balise de css
		page += baliseCss(chemin)
	##Fin du bloc head
		page += "\n    <\head>\n    <body>\n"
	end
	##Ajoutdu lien de retour
	page += lienRetour(chemin)
	##Transformation des balises simples
	hash = {"#UL"=>"<ul>", "UL#"=>"</ul>", "#LI"=>"<li>", "LI#"=>"</li>", "#BO "=>"<b>", " BO#"=>"</b>"}
	hash.merge!({"#I "=>"<i>", " I#"=>"</i>", "#S "=>"<s>", " S#"=>"</s>", "#BQ "=>"<blockquote>", " BQ#"=>"</blockquote>"})
	hash.merge!({"#1 "=>"<h1>", " 1#"=>"</h1>", "#2 "=>"<h2>", " 2#"=>"</h2>","#3"=>"<h3>", " 3#"=>"</h3>"})
	hash.merge!({"#4 "=>"<h4>", " 4#"=>"</h4>", "#5 "=>"<h5>", " 5#"=>"</h5>","#6"=>"<h6>", " 6#"=>"</h6>"})
	hash.merge!({"#BR#"=>"<br>", "#HR#"=>"<hr>"})
	hash.merge!({"#DTETE"=>"<div id=\"entete\">", "DTETE#"=>"</div>", "#DCRP"=>"<div id=\"corps\">", "DCRP#"=>"</div>"})
	hash.each do |avant, apres|
		while raw.include?(avant)
			raw = raw.sub(avant, apres)
		end
	end
	#raws = raw.split("\n")
	##Ajout du texte à la plage
	page += raw
	page += "\n"
	##Ajout de la closure du body
	page += "</body>"
	#puts raw
	#puts page
	page
end
