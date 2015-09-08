# KustomsWebFabrikator v 0.1 du 08/09/2015
KustomWebFabrikator est un generateur de site statique en ruby.
Il fonctionne en prenant une arborescence de fichiers (dans un dossier Input) et en la copiant dans un dossier Output. Pendant la copie, les fichiers txt sont convertis en fichiers HTML, remplaçant le format de base par un format HTML.
Le format de base est un format de balise crée pour l'occasion. Il est basé sur le principe suivant

#BALISE_D_OUVERTURE   (ex : #BO pour <b>)
BALISE_DE_FERMETURE#  (ex : BO# pour </b>)
#AUTRE_BALISE#        (ex : #BR# pour <br>)

La version actuelle gère surtout le remplacement de baslises simple telles que <b>, <i>, <blockquote>... auquel s'ajoute quelques fonctionalité (plutôt simples) implémentées. A savoir :
- Gestion de la balise <Title>
- Lisaison du chaque fichier html avec le fichier CSS, présent à la racine de l'arborescence
- Liaison de chaque fichier (hors page d'accueil) à son fichier "parent"

(A noter que ce générateur est créé pour répondre à un besoin précis et de fait ne se veut pas totalement généraliste)
