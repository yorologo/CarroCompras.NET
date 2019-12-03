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
    public partial class WebForm1 : System.Web.UI.Page
    {

        const string connStr = "server=localhost;user=root;database=pruebas;port=3306";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                Response.Redirect("~/Compras.aspx");
            }
        }

        protected void submiEventMethod(object sender, EventArgs e)
        {
            string sql = "INSERT INTO usuarios(username, password) VALUES( @Username , @Password )";
            string password = hashFunction(passwordTextBox.Text);

            System.Diagnostics.Debug.WriteLine("Usuario: " + usernameTextBox.Text);
            System.Diagnostics.Debug.WriteLine("Contraseña: " + password);

            //*
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Username", usernameTextBox.Text);
                cmd.Parameters.AddWithValue("@Password", password);

                try
                {
                    conn.Open();
                    Int32 rowsAffected = cmd.ExecuteNonQuery();
                    System.Diagnostics.Debug.WriteLine("RowsAffected: {0}", rowsAffected);
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
                usernameTextBox.Text = "";
                passwordTextBox.Text = "";
            }
            //*/

        }

        protected void cancelEventMethod(object sender, EventArgs e)
        {
            usernameTextBox.Text = "";
            passwordTextBox.Text = "";
        }

        private string hashFunction(string password)
        {
            //Crea la variable salt con una criptografia PRNG
            byte[] salt;
            new RNGCryptoServiceProvider().GetBytes(salt = new byte[16]);

            //Crea el Rfc2898DeriveBytes y obtiene el valor hash
            var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 10000);
            byte[] hash = pbkdf2.GetBytes(20);

            //Combine los bytes de salt y contraseña para su uso posterior
            byte[] hashBytes = new byte[36];
            Array.Copy(salt, 0, hashBytes, 0, 16);
            Array.Copy(hash, 0, hashBytes, 16, 20);

            return Convert.ToBase64String(hashBytes);
        }
    }
}