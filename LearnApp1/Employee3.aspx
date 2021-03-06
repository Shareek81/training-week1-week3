<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Employee3.aspx.cs" Inherits="LearnApp1.Employee3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee</title>
    <link rel="stylesheet" href="https://kendo.cdn.telerik.com/2021.1.119/styles/kendo.default-v2.min.css"/>

    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="https://kendo.cdn.telerik.com/2021.1.119/js/kendo.all.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@300&display=swap');
        body {
            font-family: 'Source Sans Pro', sans-serif;
        }
        .container {
            border: 1px solid black;
            width: 90%;
            padding: 16px;
        }
        h3 {
            width: 90%;
            padding: 8px;
            border-bottom: 2px solid #00ffff;
        }
        td {
            padding: 10px;
        }
        td * {
            width: 104%;
        }
        .form-control {
            height: 20px;
            padding: 1px;
        }
        input {
            width: 100%;
        }
        .drop-down {
            background: url(https://cdn4.iconfinder.com/data/icons/ios-edge-glyph-3/25/Down-Carrot-Square-512.png) no-repeat;
            background-size: 24px 110%;
            background-position: right;
            border-radius: 5px;
            width: 104%;
            -webkit-appearance: none;
        }
        .btn {
            background-color: #0094ff;
            color: white;
            padding: 8px;
            width: 80px;
            border: none;
            margin: 4px;
            border-radius: 4px;
        }
        #grid .k-grid-content {
            height: 200px;
            overflow-y: scroll;
            color: black;
        }
        #grid .k-grid-header {
            color: black;
            font-weight: bolder;
        }
    </style>
    <script>
        var grid;
        window.onload = () => {

            fetchEmployees();
            document.getElementById("emp_div").onchange = () => {
                $.ajax({
                    type: "POST",
                    url: "Employee3.aspx/PopulateManager",
                    data: "{_division:'" + emp_div.value + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        let managers = JSON.parse(data.d);
                        let manager_list = document.getElementById("manager");
                        while (manager_list.options.length) {
                            manager_list.remove(0);
                        }
                        for (m of managers) {
                            let opt = document.createElement("option");
                            opt.text = m['managerName'];
                            opt.value = m['managerId'];
                            manager_list.add(opt);
                        }
                    }
                });
            }

            grid = $('#grid').kendoGrid({
                columns: [
                    { field: "employeeId", title: "Employee ID" },
                    { field: "employeeName", title: "Employee Name" },
                    { field: "joiningDate", title: "Joining Date" },
                    { field: "project", title: "Project" },
                    { field: "divisionName", title: "Division" },
                    { field: "managerName", title: "Manager" },
                    { title: "Actions", template: '<input type="button" class="btn add" value="Edit" onclick="edit(this)" /><input type="button" class="btn delete" value="Delete" onclick="del(this)" />' }
                ]
            }).data("kendoGrid");
        }
        function fetchEmployees() {
            $.ajax({
                type: "POST",
                url: "Employee3.aspx/GetEmployees",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    let _employees = JSON.parse(data.d);
                    console.log(_employees);
                    var dataSource = new kendo.data.DataSource({
                        data: _employees
                    });
                    grid.setDataSource(dataSource);
                }
            });
        }

        function insertEmp() {
            $.ajax({
                type: "POST",
                url: "Employee3.aspx/InsertEmp",
                data: "{_id:'" + (emp_id.value != 'new' ? emp_id.value:'-1')+"', _name:'" + emp_name.value + "', _date:'" + date_joined.value + "', _project:'" + project.value + "', _division:" + emp_div.value + ", _manager:" + manager.value + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () {
                    fetchEmployees();
                    alert("Employee Inserted!")
                    document.getElementById("emp_id").value = "new";
                    document.getElementById("emp_name").value = "";
                    document.getElementById("date_joined").value = "";
                    document.getElementById("project").value = "";
                }
            });
        }

        function edit(obj) {
            var row = $(obj).closest("tr");
            var item = grid.dataItem(row);
            document.getElementById("emp_id").value = item.employeeId;
            document.getElementById("emp_name").value = item.employeeName;
            $("#emp_div").val("");
            $("#manager").val("");
            document.getElementById("date_joined").value = new Date(item.joiningDate);
            document.getElementById("project").value = item.project;
        }

        function del(obj) {
            var row = $(obj).closest("tr");
            var item = grid.dataItem(row);
            $.ajax({
                type: "POST",
                url: "Employee3.aspx/DeleteEmp",
                data: "{_id:'" + item.employeeId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () {
                    fetchEmployees();
                    alert("Employee Deleted!")
                }
            });
        }
    </script>
</head>
<body>
    <div class="container">
        <h3>Employee details</h3>
        <form id="emp_form" runat="server">
            <table>
                <tr>
                    <td>
                        <label for="emp_id">EmployeeId</label>
                    </td>
                    <td>       
                        <asp:TextBox runat="server" ID="emp_id" class="form-control" Text="new"  ReadOnly="true"></asp:TextBox>
                        <!--<input id="emp_name" type="text" class="form-control" required="required"/>-->
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="emp_name">EmployeeName</label>
                    </td>
                    <td>      
                        <asp:TextBox runat="server" ID="emp_name" class="form-control"></asp:TextBox>
                        <!--<input id="emp_name" type="text" class="form-control" required="required"/>-->
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="date_joined">Joined Date</label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="date_joined" class="form-control" type="date"></asp:TextBox>
                        <!--<input id="date_joined" type="date" class="form-control" required="required"/>-->
                    </td>
                </tr>
            
                <tr>
                    <td>
                        <label for="project">Project</label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="project" class="form-control"></asp:TextBox>
                        <!--<input id="project" type="text" class="form-control" required="required"/>-->
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="emp_div">Employee Division</label>
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="emp_div" CssClass="drop-down form-control"></asp:DropDownList>
                    </td>
                </tr>
            
                <tr>
                    <td>
                        <label for="manager">Manager</label>
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="manager" CssClass="drop-down form-control" ></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input type="button" value="Save" onclick="insertEmp()" class="btn" />
                    </td>
                </tr>
            </table>
        </form>
        <div id="grid"></div>
    </div>
</body>
</html>
