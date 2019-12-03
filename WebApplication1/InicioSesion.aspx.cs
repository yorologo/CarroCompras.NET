using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using MySql.Data;
using MySql.Data.MySqlClient;

namespace WebApplication1
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        const string connStr = "server=localhost;user=root;database=pruebas;port=3306";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                Response.Redirect("~/Compras.aspx");
            }
        }

        protected void loginButtonMethod(object sender, EventArgs e)
        {
            string sql = "SELECT password FROM usuarios WHERE username LIKE @Username";
            string password = "";
            System.Diagnostics.Debug.WriteLine("Usuario: " + usernameTextBox.Text);

            //*
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Username", usernameTextBox.Text);

                try
                {
                    conn.Open();

                    MySqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        password = rdr.GetString("password");
                    }
                    rdr.Close();
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine(ex.ToString());
                }
                finally
                {
                    conn.Close();
                    System.Diagnostics.Debug.WriteLine("Done.");
                }
            }
            //*/

            if (hashFunction(password))
            {
                Session["UserName"] = usernameTextBox.Text;
                Response.Redirect("~/Compras.aspx");
            }
                usernameTextBox.Text = "";
                passwordTextBox.Text = "";
        }

        protected void cancelEventMethod(object sender, EventArgs e)
        {
            usernameTextBox.Text = "";
            passwordTextBox.Text = "";
        }

        private bool hashFunction(string password)
        {
            // Extrae los bytes
            byte[] hashBytes = Convert.FromBase64String(password);

            // Obtiene el valor de salt
            byte[] salt = new byte[16];
            Array.Copy(hashBytes, 0, salt, 0, 16);

            // Calcule el hash en la contraseña que ingresó el usuario
            var pbkdf2 = new Rfc2898DeriveBytes(passwordTextBox.Text, salt, 10000);
            byte[] hash = pbkdf2.GetBytes(20);

            // Compara los resultados
            System.Diagnostics.Debug.WriteLine("Contraseña original: " + password);
            System.Diagnostics.Debug.WriteLine("Contraseña BD: " + Convert.ToBase64String(hashBytes));
            System.Diagnostics.Debug.WriteLine("Contraseña Field: " + Convert.ToBase64String(hash)); ;
            for (int i = 0; i < 20; i++)
            {
                if (hashBytes[i + 16] != hash[i])
                    return false;
            }
            return true;
        }

    }
}