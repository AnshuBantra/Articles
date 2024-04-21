WITH
    RecursiveOrg AS (
        SELECT  RLE.BusinessEntityID        AS EmployeeID
                , RLE.LoginID
                , RLE.JobTitle
                , RLE.OrganizationLevel     AS ManagerID
            FROM    HumanResources.Employee AS RLE
            WHERE   OrganizationLevel IS NULL -- Root Level Employees
        UNION ALL
        SELECT      DRE.BusinessEntityID    AS EmployeeID
                    , DRE.LoginID
                    , DRE.JobTitle
                    , DRE.OrganizationLevel AS ManagerID
            FROM    HumanResources.Employee AS DRE
                JOIN
                    RecursiveOrg            AS RO ON DRE.OrganizationLevel = RO.EmployeeID  -- Direct Reporting Employees
        )
-- Main Query --
SELECT      *
    FROM    RecursiveOrg;