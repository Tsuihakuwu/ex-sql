    -- Quelles sont les commandes du fournisseur n°9120 ?

SELECT numcom AS NumeroCommande, nomfou AS Fournisseur FROM ligcom
NATURAL JOIN entcom, fournis
WHERE fournis.numfou = 9120 AND entcom.numfou = 9120;

    -- Afficher le code des fournisseurs pour lesquels des commandes ont été passées.

SELECT numfou AS IDFournisseur, nomfou AS NomFournisseur FROM fournis
NATURAL JOIN entcom
GROUP BY nomfou;

    -- Afficher le nombre de commandes fournisseurs passées, et le nombre de fournisseur concernés.

SELECT COUNT(numcom), nomfou FROM entcom
NATURAL JOIN fournis
GROUP BY nomfou;

    -- Extraire les produits ayant un stock inférieur ou égal au stock d'alerte, et dont la quantité annuelle est inférieure à 1000.

    --     Informations à fournir : n° produit, libellé produit, stock actuel, stock d'alerte, quantité annuelle)

SELECT codart AS CodeArticle, libart AS LibelleArticle, stkphy AS QttPhysique, stkale AS StockAlerte, qteann AS QttAnnuelle FROM produit
WHERE stkphy < stkale AND qteann < 1000;

    -- Quels sont les fournisseurs situés dans les départements 75, 78, 92, 77 ?

    --     L’affichage (département, nom fournisseur) sera effectué par département décroissant, puis par ordre alphabétique.

SELECT nomfou AS NomFournisseur, left(posfou,2) AS Departement FROM fournis
WHERE LEFT(posfou,2) IN (75, 78, 92, 77)
ORDER BY Departement;

    -- Quelles sont les commandes passées en mars et en avril ?

SELECT numcom AS NumeroCommande, datcom AS DateCommande FROM entcom
WHERE MONTH(datcom) IN (3,4);

    -- Quelles sont les commandes du jour qui ont des observations particulières ?

    --     Afficher numéro de commande et date de commande

SELECT numcom AS NumeroCommande, datcom AS DateCommande, obscom FROM entcom
WHERE obscom <> '';

    -- Lister le total de chaque commande par total décroissant.

    --     Afficher numéro de commande et total

SELECT numcom, (qtecde * priuni) AS Total FROM ligcom
ORDER BY numcom;

    -- Lister les commandes dont le total est supérieur à 10000€ ; on exclura dans le calcul du total les articles commandés en quantité supérieure ou égale à 1000.

    --     Afficher numéro de commande et total


SELECT numcom, (qtecde * priuni) AS Total FROM ligcom
WHERE qtecde = 1000 AND  (qtecde * priuni) > 10000
ORDER BY numcom;

    -- Lister les commandes par nom de fournisseur.

    --     Afficher nom du fournisseur, numéro de commande et date

SELECT nomfou AS NomFournisseur, numcom AS NumeroCommande, datcom AS DateCommande FROM fournis
NATURAL JOIN entcom
ORDER BY nomfou;

    -- Sortir les produits des commandes ayant le mot "urgent' en observation.

    --     Afficher numéro de commande, nom du fournisseur, libellé du produit et sous total (= quantité commandée * prix unitaire)

SELECT numcom, nomfou, libart, (qtecde*priuni) AS st FROM fournis
NATURAL JOIN entcom, ligcom, produit
WHERE obscom LIKE '%urgent%'
ORDER BY nomfou;

    -- Coder de 2 manières différentes la requête suivante : Lister le nom des fournisseurs susceptibles de livrer au moins un article.

SELECT nomfou AS NomFournisseur FROM fournis
NATURAL JOIN entcom, ligcom, produit, vente
WHERE qte1 >= 1
GROUP BY nomfou;

    -- Coder de 2 manières différentes la requête suivante : Lister les commandes dont le fournisseur est celui de la commande n°70210.

    --     Afficher numéro de commande et date

SELECT numcom AS NumeroCommande, datcom AS DateCommande FROM ligcom
NATURAL JOIN entcom, fournis
WHERE nomfou = (
    SELECT nomfou FROM fournis
    NATURAL JOIN entcom
    WHERE numcom = 70210
    )

    -- Dans les articles susceptibles d’être vendus, lister les articles moins chers (basés sur Prix1) que le moins cher des rubans (article dont le premier caractère commence par R).

    --     Afficher libellé de l’article et prix1


SELECT MIN(prix1) AS PrixMinimum, libart AS LibelleArticle FROM vente
NATURAL JOIN produit
WHERE LEFT(codart,1) IN ('r','R');


    -- Sortir la liste des fournisseurs susceptibles de livrer les produits dont le stock est inférieur ou égal à 150 % du stock d'alerte.

    --     La liste sera triée par produit puis fournisseur

SELECT numfou, nomfou FROM fournis
NATURAL JOIN entcom, ligcom, produit
WHERE stkphy <= (stkale*1.5)
GROUP BY nomfou
ORDER BY nomfou;

    -- Sortir la liste des fournisseurs susceptibles de livrer les produits dont le stock est inférieur ou égal à 150 % du stock d'alerte, et un délai de livraison d'au maximum 30 jours.

    --     La liste sera triée par fournisseur puis produit

SELECT numfou, nomfou FROM fournis
NATURAL JOIN entcom, ligcom, produit
WHERE stkphy <= (stkale*1.5) AND -- DELAI_DE_LIVRAISON < 30 ?? 
GROUP BY nomfou
ORDER BY nomfou;

    -- Avec le même type de sélection que ci-dessus, sortir un total des stocks par fournisseur, triés par total décroissant.

SELECT SUM(), nomfou FROM fournis
NATURAL JOIN entcom, ligcom, produit
WHERE stkphy <= (stkale*1.5)
GROUP BY nomfou
ORDER BY nomfou;

    -- En fin d'année, sortir la liste des produits dont la quantité réellement commandée dépasse 90% de la quantité annuelle prévue.

    -- Calculer le chiffre d'affaire par fournisseur pour l'année 2018, sachant que les prix indiqués sont hors taxes et que le taux de TVA est 20%.

    -- MANIPULATION DONNEES

--     Les conditions de vente ont changé !
-- Ecrivez les requêtes de mise à jour correspondant aux consignes suivantes :

--     Appliquer une augmentation de tarif de 4% pour le prix 1, et de 2% pour le prix2, pour le fournisseur 9180.

UPDATE vente
SET prix1 = prix1 + (prix1*0.04), prix2 = prix2 + (prix2*0.02)
WHERE numfou = 9180;

--     Dans la table vente, mettre à jour le prix2 des articles dont le prix2 est nul, en affectant la valeur du prix1.

UPDATE vente
SET prix2 = prix1
WHERE prix2 IN (NULL,0);

--     Mettre à jour le champ obscom, en renseignant ***** pour toutes les commandes dont le fournisseur a un indice de satisfaction inférieur à 5.

UPDATE entcom
NATURAL JOIN fournis
SET obscom = '*****'
WHERE satisf < 5;

--     Supprimer le produit "I110".


