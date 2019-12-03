<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Compras.aspx.cs" Inherits="WebApplication1.WebForm3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>CarroCompras</title>

    <!-- BOOTSTRAP -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
</head>
<body>
    <form id="form1" runat="server">
        <h1>Carrito de compras</h1>
        <asp:Button ID="logoutButon" Text="Cerrar Sesion" OnClick="logoutButonMethod" class="btn btn-warning" runat="server" />
        <div class="jumbotron bg-white">
            <div class="container-fluid text-center">
                <table class="table">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Producto</th>
                            <th scope="col">Precio</th>
                            <th scope="col">Cantidad</th>
                            <th scope="col">
                                <button type="button" class="btn btn-light" data-toggle="modal" data-target="#exampleModal"
                                    onclick="changeModal(0, 1)">
                                    Añadir</button></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var lista = getProductos();
                            int i = 0;
                            foreach (var item in lista)
                            {

                                Response.Write("<tr>" +
                                "<th scope=\"row\" id=\"elemento" + i + "_ID\">" + item.Id + "</th>" +
                                "<td id=\"elemento" + i + "_NOMBRE\">" + item.Nombre + "</td>" +
                                "<td id=\"elemento" + i + "_PRECIO\">$ " + item.Precio + "</td>" +
                                "<td>" +
                                    "<input type=\"number\" name=\"element" + i + "\" id=\"elemento" + i + "_CANTIDAD\" min=\"0\" step=\"1\" value=\"0\"" +
                                        "onchange=\"calcula()\"></td>" +
                                "<td>" +
                                    "<button id=\"btnGroupDrop1\" type=\"button\" class=\"btn btn-primary dropdown-toggle\" data-toggle=\"dropdown\"" +
                                        "aria-haspopup=\"true\" aria-expanded=\"false\">" +
                                        "Opciones" +
                                    "</button>" +
                                    "<div class=\"dropdown-menu\" aria-labelledby=\"btnGroupDrop1\">" +
                                        "<button type=\"button\" class=\"btn btn-secondary btn-sm\" data-toggle=\"modal\" data-target=\"#exampleModal\"" +
                                            "onclick=\"changeModal(" + i + ", 2)\">" +
                                            "Editar Nombre</button>" +
                                        "<button type=\"button\" class=\"btn btn-secondary btn-sm\" data-toggle=\"modal\" data-target=\"#exampleModal\"" +
                                            "onclick=\"changeModal(" + i + ", 3)\">" +
                                            "Editar Precio</button>" +
                                        "<button type=\"button\" class=\"btn btn-danger btn-sm\" data-toggle=\"modal\" data-target=\"#exampleModal\"" +
                                            "onclick=\"changeModal(" + i + ", 4)\">" +
                                            "Eliminar" +
                                        "</button>" +
                                "</td>" +
                            "</tr>");
                                i++;
                            }
                        %>
                    </tbody>
                </table>
                <div class="row justify-content-end">
                    <div class="col-4">
                        <h4>Total</h4>
                    </div>
                    <div class="col-4 bg-white">
                        <h4 id="total">$ 0</h4>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
            aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" id="modalBody">
                        <div class="input-group mb-3" id="modalNombre">
                            <div class="input-group-prepend"><span class="input-group-text">Nombre</span></div>
                            <asp:TextBox ID="nuevoNombreTextBox" type="text" class="form-control" runat="server" />
                        </div>
                        <div class="input-group mb-3" id="modalPrecio">
                            <div class="input-group-prepend"><span class="input-group-text">$</span></div>
                            <asp:TextBox ID="nuevoPrecioTextBox" class="form-control" type="number" min="1" step="0.1" value="1" runat="server" />
                        </div>
                        <div id="mensajeModal">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                        <asp:Button ID="createButton" Text="Aceptar" OnClick="createButtonMethod" class="btn btn-success" runat="server" />
                        <asp:Button ID="updateButton1" Text="Aceptar" OnClick="updateButtonMethod1" class="btn btn-success" runat="server" />
                        <asp:Button ID="updateButton2" Text="Aceptar" OnClick="updateButtonMethod2" class="btn btn-success" runat="server" />
                        <asp:Button ID="deleteButton" Text="Aceptar" OnClick="deleteButtonMethod" class="btn btn-success" runat="server" />
                        <asp:HiddenField ID="idFlag" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
        function calcula() {
            var total = 0;

            var i = 0;

            var cantidad;
            var precio = 0;

            try {
                cantidad = document.getElementById("elemento" + i + "_CANTIDAD");
                precio = document.getElementById("elemento" + i + "_PRECIO").innerHTML.substr(2);
            } catch (error) {
                precio = 0;
            }

            while (precio != 0) {
                if (cantidad.value == "") {
                    cantidad.value = 0;
                }

                console.log(parseInt(cantidad.value));
                console.log(parseInt(precio));

                total += parseInt(cantidad.value) * parseInt(precio);

                console.log(total);

                i += 1;
                try {
                    cantidad = document.getElementById("elemento" + i + "_CANTIDAD");
                    precio = document.getElementById("elemento" + i + "_PRECIO").innerHTML.substr(2);
                } catch (error) {
                    precio = 0;
                }
            }
            document.getElementById("total").innerHTML = "$ " + total.toString();
        }
        function changeModal(element, action) {
            var ID = document.getElementById("elemento" + element + "_ID").innerHTML;
            var nombre = document.getElementById("elemento" + element + "_NOMBRE").innerHTML;
            switch (action) {
                case 1:
                    document.getElementById("idFlag").value = ID;
                    document.getElementById("exampleModalLabel").innerHTML = "Añadir nuevo producto";
                    document.getElementById("modalNombre").classList.remove("d-none");
                    document.getElementById("modalPrecio").classList.remove("d-none");
                    document.getElementById("mensajeModal").classList.add("d-none");

                    document.getElementById("createButton").classList.remove("d-none");
                    document.getElementById("updateButton1").classList.add("d-none");
                    document.getElementById("updateButton2").classList.add("d-none");
                    document.getElementById("deleteButton").classList.add("d-none");
                    break;
                case 2:
                    document.getElementById("idFlag").value = ID;
                    document.getElementById("exampleModalLabel").innerHTML = "Editar nombre de " + nombre;
                    document.getElementById("modalNombre").classList.remove("d-none");
                    document.getElementById("modalPrecio").classList.add("d-none");
                    document.getElementById("mensajeModal").classList.add("d-none");

                    document.getElementById("createButton").classList.add("d-none");
                    document.getElementById("updateButton1").classList.remove("d-none");
                    document.getElementById("updateButton2").classList.add("d-none");
                    document.getElementById("deleteButton").classList.add("d-none");
                    break;
                case 3:
                    document.getElementById("idFlag").value = ID;
                    document.getElementById("exampleModalLabel").innerHTML = "Editar precio de " + nombre;
                    document.getElementById("modalNombre").classList.add("d-none");
                    document.getElementById("modalPrecio").classList.remove("d-none");
                    document.getElementById("mensajeModal").classList.add("d-none");

                    document.getElementById("createButton").classList.add("d-none");
                    document.getElementById("updateButton1").classList.add("d-none");
                    document.getElementById("updateButton2").classList.remove("d-none");
                    document.getElementById("deleteButton").classList.add("d-none");
                    break;
                case 4:
                    document.getElementById("idFlag").value = ID;
                    document.getElementById("exampleModalLabel").innerHTML = "Borrar producto " + nombre;
                    document.getElementById("mensajeModal").innerHTML = "¿Esta seguro de eliminar <i>" + nombre + "</i>?";
                    document.getElementById("modalNombre").classList.add("d-none");
                    document.getElementById("modalPrecio").classList.add("d-none");
                    document.getElementById("mensajeModal").classList.remove("d-none");

                    document.getElementById("createButton").classList.add("d-none");
                    document.getElementById("updateButton1").classList.add("d-none");
                    document.getElementById("updateButton2").classList.add("d-none");
                    document.getElementById("deleteButton").classList.remove("d-none");
                    break;
                default:

            }
        }
    </script>
</body>
</html>
