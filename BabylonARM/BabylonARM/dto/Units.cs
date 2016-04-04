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
        public String DbName { private set; get; }

        private Units(String description, String dbName)
        {
            this.description = description;
            this.DbName = dbName;
        }

        public override string ToString()
        {
            return description;
        }

        public static Units BOTTLE_033 { get { return new Units("бутылка 0.33 л.", "BOTTLE_033"); } }
        public static Units BOTTLE_05 { get { return new Units("бутылка 0.5 л.", "BOTTLE_05"); } }
        public static Units BOX { get { return new Units("коробка", "BOX"); } }
        public static Units CRATE { get { return new Units("ящик", "CRATE"); } }
        public static Units GLASS_POT { get { return new Units("банка, стекло", "GLASS_POT"); } }
        public static Units PACK { get { return new Units("пачка", "PACK"); } }
        public static Units PACKING { get { return new Units("упаковка", "PACKING"); } }
        public static Units TIN_POT { get { return new Units("банка, жесть", "TIN_POT"); } }
        public static Units UNIT { get { return new Units("штука", "UNIT"); } }

        public static Units EMPTY { get { return new Units(null, null); } }

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
            foreach(Units u in UnitsList)
            {
                if (u.DbName == dbName)
                {
                    return u;
                }
            }
            throw new ArgumentException("Unexpected unit id");
        }
    }
}
