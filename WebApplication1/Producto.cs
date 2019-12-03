using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication1
{
    public class Producto
    {
        private int id;
        private string nombre;
        private double precio;

        public Producto() { }

        public int Id { get => id; set => id = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public double Precio { get => precio; set => precio = value; }

        public string ToString()
        {
            return "Id: " + id + ", Nombre: " + nombre + ", Precio: " + precio;
        }
    }
}