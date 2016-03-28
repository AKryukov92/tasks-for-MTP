using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BabylonARM.dto
{
    public class Product
    {
        public Product(String id, Units unit, int quantity)
        {
            Id = id;
            Unit = unit;
            Quantity = quantity;
        }

        public String Id { get; private set; }
        public Units Unit { get; private set; }
        public int Cost { get; set; }
        public String Name { get; set; }
        public int Quantity { get; private set; }

        public override string ToString()
        {
            return Name;
        }
    }
}
