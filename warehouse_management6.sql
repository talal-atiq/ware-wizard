-- Functions in SQL:

-- Calculate total inventory cost for a given warehouse:
DELIMITER $$
CREATE FUNCTION GetTotalInventoryCost(WarehouseID INT) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE totalCost DECIMAL(10, 2);
    SELECT SUM(i.Quantity * p.CostPrice) INTO totalCost
    FROM Inventory i
    JOIN Products p ON i.ProductID = p.ProductID
    WHERE i.WarehouseID = WarehouseID;
    RETURN totalCost;
END$$
DELIMITER ;

SELECT GetTotalInventoryCost(1) AS TotalCostForWarehouse1;


-- Calculate the average selling price of products in a given category:
DELIMITER $$
CREATE FUNCTION GetAverageSellingPrice(CategoryID INT) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE avgPrice DECIMAL(10, 2);
    SELECT AVG(SellingPrice) INTO avgPrice
    FROM Products
    WHERE CategoryID = CategoryID;
    RETURN avgPrice;
END$$
DELIMITER ;


-- Count number of products supplied by a specific supplier:
DELIMITER $$
CREATE FUNCTION GetProductCountBySupplier(SupplierID INT) 
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE productCount INT;
    SELECT COUNT(ProductID) INTO productCount
    FROM Products
    WHERE SupplierID = SupplierID;
    RETURN productCount;
END$$
DELIMITER ;

SELECT GetProductCountBySupplier(1) AS ProductCountForSupplier1;


-- Calculate the total weight of shipments for a specific order:
DELIMITER $$
CREATE FUNCTION GetTotalShipmentWeight(Carrier VARCHAR(100)) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE totalWeight DECIMAL(10, 2);
    SELECT SUM(sd.CargoWeight) INTO totalWeight
    FROM Shipments sh
    JOIN ShipmentDetails sd ON sh.ShipmentID = sd.ShipmentID
    WHERE sh.Carrier = Carrier;
    RETURN totalWeight;
END$$
DELIMITER ;

SELECT GetTotalShipmentWeight('TCS') AS TotalWeightForCarrier;

SELECT * FROM shipments;


