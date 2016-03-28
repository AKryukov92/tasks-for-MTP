using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;

namespace BabylonARM.dto
{
    public struct Units
    {
        private String description;
        private Units(String description)
        {
            this.description = description;
        }

        public override string ToString()
        {
            return description;
        }

        public static Units BOTTLE_033 { get { return new Units("бутылка 0.33 л."); } }
        public static Units BOTTLE_05 { get { return new Units("бутылка 0.5 л."); } }
        public static Units BOX { get { return new Units("коробка"); } }
        public static Units CRATE { get { return new Units("ящик"); } }
        public static Units GLASS_POT { get { return new Units("банка, стекло"); } }
        public static Units PACK { get { return new Units("пачка"); } }
        public static Units PACKING { get { return new Units("упаковка"); } }
        public static Units TIN_POT { get { return new Units("банка, жесть"); } }
        public static Units UNIT { get { return new Units("штука"); } }

        public static ReadOnlyCollection<Units> UnitsList = new ReadOnlyCollection<Units>(new List<Units> {
            BOTTLE_033,
            BOTTLE_05,
            BOX,
            CRATE,
            GLASS_POT,
            PACK,
            PACKING,
            TIN_POT,
            UNIT
        });

        public static Units FromDbName(String dbName)
        {
            switch(dbName)
            {
                case "BOTTLE_033": return BOTTLE_033;
                case "BOTTLE_05": return BOTTLE_05;
                case "BOX": return BOX;
                case "CRATE": return CRATE;
                case "GLASS_POT": return GLASS_POT;
                case "PACK": return PACK;
                case "PACKING":return PACKING;
                case "TIN_POT": return TIN_POT;
                case "UNIT": return UNIT;
                default:
                    throw new ArgumentException("Unexpected unit id");
            }
        }
    }
}
