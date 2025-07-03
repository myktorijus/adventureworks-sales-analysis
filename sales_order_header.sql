/* Query retrieves salesorderheader table JOINED with address, stateprovince
 and sales territory tables with necessary demographic data */

SELECT
  salesorderheader.*,
  province.stateprovincecode AS ship_province,
  province.CountryRegionCode AS country_code,
  province.name AS country_state_name,
  territory.group AS territory_group,
  territory.name AS territory_name
FROM
  `tc-da-1.adwentureworks_db.salesorderheader` AS salesorderheader
INNER JOIN
  `tc-da-1.adwentureworks_db.address` AS address
ON
  salesorderheader.ShipToAddressID = address.AddressID
INNER JOIN
   `tc-da-1.adwentureworks_db.stateprovince` AS province
ON
  address.stateprovinceid = province.stateprovinceid
INNER JOIN
  `tc-da-1.adwentureworks_db.salesterritory` AS territory
ON
  salesorderheader.territoryid = territory.territoryid
