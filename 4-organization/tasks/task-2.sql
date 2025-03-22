WITH RECURSIVE
    Subordinates AS (
        -- Базовый случай: начнем с Ивана Иванова.
        SELECT e.EmployeeID, e.Name AS EmployeeName, e.ManagerID, e.DepartmentID, e.RoleID
        FROM Employees e
        WHERE
            e.EmployeeID = 1
        UNION ALL
        -- Рекурсивный случай: находим всех подчиненных сотрудников.
        SELECT e.EmployeeID, e.Name AS EmployeeName, e.ManagerID, e.DepartmentID, e.RoleID
        FROM Employees e
            INNER JOIN Subordinates s ON e.ManagerID = s.EmployeeID
    ),
    EmployeeProjectsTasks AS (
        -- Объединяем задачи и проекты для каждого сотрудника.
        SELECT
            s.EmployeeID,
            s.EmployeeName,
            s.ManagerID,
            d.DepartmentName,
            r.RoleName,
            STRING_AGG(DISTINCT p.ProjectName, ', ') AS ProjectNames,
            STRING_AGG(DISTINCT t.TaskName, ', ') AS TaskNames,
            COUNT(t.TaskID) AS TotalTasks
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
    )
    -- Основной запрос.
SELECT
    ep.EmployeeID AS EmployeeID,
    ep.EmployeeName AS EmployeeName,
    ep.ManagerID AS ManagerID,
    ep.DepartmentName AS DepartmentName,
    ep.RoleName AS RoleName,
    ep.ProjectNames AS ProjectNames,
    ep.TaskNames AS TaskNames,
    ep.TotalTasks AS TotalTasks,
    -- Подсчитываем прямых подчиненных (не рекурсивно, только на один уровень).
    (
        SELECT COUNT(*)
        FROM Employees e
        WHERE
            e.ManagerID = ep.EmployeeID
    ) AS TotalSubordinates
FROM EmployeeProjectsTasks ep
ORDER BY ep.EmployeeName;
