/*
Chapter 14 | Databases

14.1 Multiple Apartments
Write a SQL query to get a list of tenants who are renting more than one apartment.
Hints: #408
*/
SELECT
  TenantID,
  MAX(Tenants.TenantName)
  COUNT(AptTenants.AptID)
FROM Tenants
  INNER JOIN AptTenants
    ON Tenants.TenantID = AptTenants.TenantID
GROUP BY TenantID
HAVING COUNT(AptTenants.AptID) > 1

SELECT
  TenantName,
  Tenants.TenantID,
  ApartmentCount
FROM Tenants
  INNER JOIN (
    SELECT
      TenantID,
      COUNT(AptTenants.AptID) as [ApartmentCount]
    FROM Tenants
      INNER JOIN AptTenants
        ON Tenants.TenantID = AptTenants.TenantID
    GROUP BY TenantID
    HAVING ApartmentCount > 1
  ) T ON Tenants.TenantID = T.TenantID

/*
14.2 Open Requests
Write a SQL query to get a list of all buildings and the number of open requests
(Requests in which status equals 'Open')
Hints: #411
*/
SELECT
  Buildings.BuildingID,
  MAX(Buildings.BuildingName),
  COUNT(Requests.RequestID)
FROM Buildings
  INNER JOIN Apartments
    ON Buildings.BuildingID = Apartments.BuildingID
  LEFT OUTER JOIN Requests
    ON Apartments.AptID = Requests.AptID
WHERE Requests.Status = "Open"
GROUP BY Buildings.BuildingID
