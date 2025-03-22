WITH RECURSIVE
    SubordinatesCTE AS (
        -- Базовый случай: начинаем с всех сотрудников-менеджеров, которые имеют подчинённых.
        SELECT e.EmployeeID, e.Name AS EmployeeName, e.ManagerID, e.DepartmentID, e.RoleID
        FROM Employees e
        WHERE
            EXISTS (
                SELECT 1
                FROM Employees sub
                WHERE
                    sub.ManagerID = e.EmployeeID
            )
        UNION ALL
        -- Рекурсивный случай: находим всех подчинённых.
        SELECT e.EmployeeID, e.Name AS EmployeeName, e.ManagerID, e.DepartmentID, e.RoleID
        FROM
            Employees e
            JOIN SubordinatesCTE s ON e.ManagerID = s.EmployeeID
    ),
    ManagerInfo AS (
        -- Получаем информацию о менеджерах.
        SELECT
            e.EmployeeID,
            e.Name AS EmployeeName,
            e.ManagerID,
            d.DepartmentName,
            r.RoleName,
            STRING_AGG(DISTINCT p.ProjectName, ', ') AS ProjectNames,
            STRING_AGG(DISTINCT t.TaskName, ', ') AS TaskNames
        FROM
            Employees e
            JOIN Roles r ON e.RoleID = r.RoleID
            LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
            LEFT JOIN Projects p ON e.DepartmentID = p.DepartmentID
            LEFT JOIN Tasks t ON e.EmployeeID = t.AssignedTo
        WHERE
            r.RoleName = 'Менеджер'
        GROUP BY
            e.EmployeeID,
            e.Name,
            e.ManagerID,
            d.DepartmentName,
            r.RoleName
    ),
    TotalSubordinates AS (
        -- Считаем общее количество подчинённых для каждого менеджера.
        SELECT
            s.ManagerID AS EmployeeID,
            COUNT(DISTINCT s.EmployeeID) AS TotalSubordinates
        FROM SubordinatesCTE s
        GROUP BY
            s.ManagerID
    )

-- Основной запрос.
SELECT
    mi.EmployeeID AS EmployeeID,
    mi.EmployeeName AS EmployeeName,
    mi.ManagerID AS ManagerID,
    mi.DepartmentName AS DepartmentName,
    mi.RoleName AS RoleName,
    mi.ProjectNames AS ProjectNames,
    mi.TaskNames AS TaskNames,
    ts.TotalSubordinates AS TotalSubordinates
FROM
    ManagerInfo mi
    JOIN TotalSubordinates ts ON mi.EmployeeID = ts.EmployeeID
WHERE
    ts.TotalSubordinates > 0
ORDER BY mi.EmployeeName;