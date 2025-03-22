WITH RECURSIVE
    Subordinates AS (
        -- Базовый случай: начинаем с Ивана Иванова.
        SELECT e.EmployeeID, e.Name AS EmployeeName, e.ManagerID, e.DepartmentID, e.RoleID
        FROM Employees e
        WHERE
            e.EmployeeID = 1
        UNION ALL
        -- Рекурсивный случай: находим всех подчиненных сотрудников.
        SELECT e.EmployeeID, e.Name AS EmployeeName, e.ManagerID, e.DepartmentID, e.RoleID
        FROM Employees e
            INNER JOIN Subordinates s ON e.ManagerID = s.EmployeeID
    )
    -- Основной запрос.
SELECT
    s.EmployeeID AS EmployeeID,
    s.EmployeeName AS EmployeeName,
    s.ManagerID AS ManagerID,
    d.DepartmentName AS DepartmentName,
    r.RoleName AS RoleName,
    STRING_AGG(DISTINCT p.ProjectName, ', ') AS ProjectNames,
    STRING_AGG(DISTINCT t.TaskName, ', ') AS TaskNames
FROM
    Subordinates s
    LEFT JOIN Departments d ON s.DepartmentID = d.DepartmentID
    LEFT JOIN Roles r ON s.RoleID = r.RoleID
    LEFT JOIN Projects p ON s.DepartmentID = p.DepartmentID
    LEFT JOIN Tasks t ON s.EmployeeID = t.AssignedTo
GROUP BY
    s.EmployeeID,
    s.EmployeeName,
    s.ManagerID,
    d.DepartmentName,
    r.RoleName
ORDER BY s.EmployeeName;
