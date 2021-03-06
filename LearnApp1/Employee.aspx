<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Employee.aspx.cs" Inherits="LearnApp1.Employee" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@300&display=swap');
        body {
            font-family: 'Source Sans Pro', sans-serif;
        }
        .container {
            border: 1px solid black;
            width: 36%;
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
            width: 40%;
            border: none;
            border-radius: 4px;
        }
    </style>
    <script>
        function insertEmp() {
            $.ajax({
                type: "POST",
                url: "Employee.aspx/insertEmp",
                data: "{_name:'" + emp_name.value + "', _date:'" + date_joined.value + "', _project:'" + project.value + "', _division:" + emp_div.value + ", _manager:" + manager.value + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () {
                    alert("Employee Inserted!");
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
                        <asp:DropDownList runat="server" ID="emp_div" CssClass="drop-down form-control" AutoPostBack="true" OnSelectedIndexChanged="emp_div_SelectedIndexChanged"></asp:DropDownList>
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
    </div>
</body>
</html>
