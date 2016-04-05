using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;

namespace BabylonARM.dto
{
    public struct Unit
    {
        private String description;
        public String DbName { private set; get; }

        private Unit(String description, String dbName)
        {
            this.description = description;
            this.DbName = dbName;
        }

        public override string ToString()
        {
            if (description == null)
            {
                return "";
            }
            return description;
        }

        //Для того, чтобы было эквивалентно неинициализированному значению
        public static Unit EMPTY = new Unit(null, null);

        //Этот список - отступление от принципов SOLID
        //Но в данной ситуации это разумный компромисс: минимум вспомогательного кода при данных требованиях
        public static ReadOnlyCollection<Unit> UnitsList = new ReadOnlyCollection<Unit>(new List<Unit> {
            EMPTY,
            new Unit("бутылка 0.33 л.", "BOTTLE_033"),
            new Unit("бутылка 0.5 л.",  "BOTTLE_05"),
            new Unit("коробка",         "BOX"),
            new Unit("ящик",            "CRATE"),
            new Unit("банка, стекло",   "GLASS_POT"),
            new Unit("пачка",           "PACK"),
            new Unit("упаковка",        "PACKING"),
            new Unit("банка, жесть",    "TIN_POT"),
            new Unit("штука",           "UNIT")
        });

        public static Unit FromDbName(String dbName)
        {
            foreach(Unit u in UnitsList)
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
