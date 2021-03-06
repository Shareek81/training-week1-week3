<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Shop.aspx.cs" Inherits="LearnApp1.Shop" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Shop</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@300&display=swap');
        body {
            font-family: 'Source Sans Pro', sans-serif;
        }
        td {
            padding: 10px;
        }
        .form-control {
            width: 100%;
            height: 20px;
            padding: 1px;
        }
        h3 {
            width: 50%;
            padding-bottom: 8px;
            margin-bottom: 0;
            border-bottom: 2px solid rgba(0, 255, 255, 0.7);
        }
        .drop-down {
            background: url(https://cdn4.iconfinder.com/data/icons/ios-edge-glyph-3/25/Down-Carrot-Square-512.png) no-repeat;
            background-size: 30px 110%;
            background-position: right;
            border-radius: 5px;
            width: 108%;
            -webkit-appearance: none;
        }
        .choosen-product {
            font-weight: 900;
        }
    </style>
</head>
<body>
    <h3>Shopping</h3>
    <form runat="server">
        <table>
            <tr>
                <td>
                    <label>Product</label>
                </td>
                <td>
                    <asp:TextBox ID="product_code" runat="server" CssClass="form-control" OnTextChanged="product_name_Selected" AutoPostBack="true"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td> 
                    <label>Product Name</label>
                </td>
                <td>
                    <asp:DropDownList ID="product_name" runat="server" CssClass="form-control drop-down" OnSelectedIndexChanged="product_name_Selected" AutoPostBack="true">
                        
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    <label>Choosen Product</label>                
                </td>
                <td>
                    <asp:Label ID="choosen_product" runat="server" CssClass="choosen-product"></asp:Label>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
