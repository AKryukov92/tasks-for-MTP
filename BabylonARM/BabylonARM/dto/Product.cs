using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BabylonARM.dto
{
    public class Product
    {
        public Guid Id { get; set; }
        public String Name { get; set; }
        public String Unit { get; set; }
        public Guid GroupId { get; set; }
        public Decimal Cost { get; set; }
        public int Quantity { get; set; }
        public float Weight { get; set; }

        public override string ToString()
        {
            return Name;
        }
    }
}
