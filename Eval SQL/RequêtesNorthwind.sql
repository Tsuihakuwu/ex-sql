-- # 1- Liste des clients français :

SELECT CompanyName AS Société, ContactName AS Contact, ContactTitle AS Fonction, Phone AS Téléphone
FROM customers
WHERE Country = 'France';

-- # 2- Liste des produits vendus par le fournisseur "Exotic Liquids" :


SELECT ProductName AS Produit, UnitPrice AS Prix
FROM products
NATURAL JOIN suppliers
WHERE CompanyName = 'Exotic Liquids';

-- # 3- Nombre de produits mis à disposition par les fournisseurs français (tri par nombre de produits décroissant) :

SELECT CompanyName AS Fournisseur, COUNT(products.SupplierID) AS 'Nbre produits' FROM suppliers
NATURAL JOIN products
WHERE Country='France'
GROUP BY CompanyName
ORDER BY COUNT(products.SupplierID) DESC;

-- # 4- Liste des clients français ayant passé plus de 10 commandes :

SELECT CompanyName AS 'Client', COUNT(orders.CustomerID) AS 'Nbre commandes' FROM customers
NATURAL JOIN orders
WHERE Country='France'
GROUP BY CompanyName
HAVING COUNT(orders.CustomerID) > 10;

-- # 5- Liste des clients dont le montant cumulé de toutes les commandes passées est supérieur à 30000 € :
-- # NB: chiffre d'affaires (CA) = total des ventes

SELECT CompanyName AS 'Client', SUM(UnitPrice * Quantity) AS 'CA', Country AS 'Pays' FROM customers
NATURAL JOIN orders
NATURAL JOIN order_details
GROUP BY CustomerID
HAVING SUM(UnitPrice * Quantity) > 30000
ORDER BY SUM(UnitPrice * Quantity) DESC;

-- # 6- Liste des pays dans lesquels des produits fournis par "Exotic Liquids" ont été livrés :

SELECT ShipCountry AS 'Pays' FROM orders
JOIN order_details ON orders.OrderID = order_details.OrderID
JOIN products ON order_details.ProductID = products.ProductID
JOIN suppliers ON products.SupplierID = suppliers.SupplierID
WHERE CompanyName = 'Exotic Liquids'
GROUP BY ShipCountry;

-- # 7- Chiffre d'affaires global sur les ventes de 1997 :
-- # NB: chiffre d'affaires (CA) = total des ventes
-- #     Attention : dans une même vente, un produit peut être vendu plusieurs fois ! Il faut donc d'abord préparer le sous-total de chaque produit, qui tient compte de son prix unitaire et de la quantité vendue...

SELECT SUM(UnitPrice*Quantity) FROM order_details
JOIN orders ON order_details.OrderID = orders.OrderID
WHERE YEAR(OrderDate)=1997;

-- # 8- Chiffre d'affaires détaillé par mois, sur les ventes de 1997 :

SELECT MONTH(OrderDate) AS 'Mois 97', SUM(UnitPrice*Quantity) AS 'Montant Ventes' FROM order_details
JOIN orders ON order_details.OrderID = orders.OrderID
WHERE YEAR(OrderDate)=1997
GROUP BY MONTH(OrderDate);

-- # 9- A quand remonte la dernière commande du client nommé "Du monde entier" ?

SELECT MAX(OrderDate) AS DerniereCommande FROM orders
JOIN customers ON orders.CustomerID = customers.CustomerID
WHERE CompanyName = 'Du monde entier';

-- # 10- Quel est le délai moyen de livraison en jours ? 

SELECT ROUND(AVG(DATEDIFF(ShippedDate,OrderDate))) FROM orders;