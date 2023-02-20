-- # 1- Liste des clients français :

SELECT CompanyName AS Société, ContactName AS Contact, ContactTitle AS Fonction, Phone AS Téléphone
FROM customers
WHERE Country = 'France';

-- # 2- Liste des produits vendus par le fournisseur "Exotic Liquids" :




-- # 3- Nombre de produits mis à disposition par les fournisseurs français (tri par nombre de produits décroissant) :


-- # 4- Liste des clients français ayant passé plus de 10 commandes :


-- # 5- Liste des clients dont le montant cumulé de toutes les commandes passées est supérieur à 30000 € :
-- # NB: chiffre d'affaires (CA) = total des ventes


-- # 6- Liste des pays dans lesquels des produits fournis par "Exotic Liquids" ont été livrés :


-- # 7- Chiffre d'affaires global sur les ventes de 1997 :
-- # NB: chiffre d'affaires (CA) = total des ventes
-- #     Attention : dans une même vente, un produit peut être vendu plusieurs fois ! Il faut donc d'abord préparer le sous-total de chaque produit, qui tient compte de son prix unitaire et de la quantité vendue...


-- # 8- Chiffre d'affaires détaillé par mois, sur les ventes de 1997 :


-- # 9- A quand remonte la dernière commande du client nommé "Du monde entier" ?


-- # 10- Quel est le délai moyen de livraison en jours ? 