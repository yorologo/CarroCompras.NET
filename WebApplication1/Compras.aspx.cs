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
    public partial class WebForm3 : System.Web.UI.Page
    {
        public int id;
        const string connStr = "server=localhost;user=root;database=dbComprasGO;port=3306";
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["Username"] == null)
            {
                Response.Redirect("~/InicioSesion.aspx");
            }
        }

        protected void logoutButonMethod(object sender, EventArgs e)
        {
            Session["Username"] = null;
            Response.Redirect("~/InicioSesion.aspx");
        }
        protected void createButtonMethod(object sender, EventArgs e)
        {
            string sql = "INSERT INTO producto(nombre, precio) VALUES( @Nombre , @Precio )";

            //*
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Nombre", nuevoNombreTextBox.Text);
                cmd.Parameters.AddWithValue("@Precio", nuevoPrecioTextBox.Text);

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
            }
        }
        protected void updateButtonMethod1(object sender, EventArgs e)
        {
            string sql = "UPDATE producto SET nombre = @Nombre WHERE id LIKE @ID";

            //*
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Nombre", nuevoNombreTextBox.Text);
                cmd.Parameters.AddWithValue("@ID", idFlag.Value);

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
            }
        }
        protected void updateButtonMethod2(object sender, EventArgs e)
        {
            string sql = "UPDATE producto SET precio = @Precio WHERE id LIKE @ID";

            //*
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Precio", nuevoPrecioTextBox.Text);
                cmd.Parameters.AddWithValue("@ID", idFlag.Value);

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
            }
        }
        protected void deleteButtonMethod(object sender, EventArgs e)
        {
            string sql = "DELETE FROM producto WHERE id = @ID";

            //*
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@ID", idFlag.Value);

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
            }
        }

        protected List<Producto> getProductos()
        {
            List < Producto > lista= new List<Producto>();
            string sql = "SELECT id, nombre, precio FROM producto";

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    MySqlCommand cmd = new MySqlCommand(sql, conn);
                    MySqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        lista.Add(new Producto());
                        lista.Last().Id = rdr.GetInt32("id");
                        lista.Last().Nombre = rdr.GetString("nombre");
                        lista.Last().Precio = rdr.GetDouble("precio");
                    }
                    rdr.Close();
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("--- ERROR ---");
                    System.Diagnostics.Debug.WriteLine(ex.ToString());
                }
                finally
                {
                    conn.Close();
                    System.Diagnostics.Debug.WriteLine("Done.");
                }
            }
            return lista;
        }
    }
}