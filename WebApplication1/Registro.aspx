﻿<%@ Page Title="Registrar Usuario" Language="C#" MasterPageFile="~/MasterPages/Base.Master" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="WebApplication1.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPHContenido" runat="server">
    <h3>Registrar Usuario</h3>
    Usuario:
    <asp:TextBox ID="usernameTextBox" class="form-control rounded-pill" runat="server" />
    Contraseña:
    <asp:TextBox ID="passwordTextBox" class="form-control rounded-pill" TextMode="Password" runat="server" /> <br />

    <asp:Button ID="submitButton" Text="Registrar" OnClick="submiEventMethod" style="width: 40%" class="btn btn-primary btn-lg" runat="server" />
    <asp:Button ID="cleanButton" Text="Cancelar" OnClick="cancelEventMethod" style="width: 40%" class="btn btn-danger btn-lg float-right" runat="server" />

</asp:Content>
