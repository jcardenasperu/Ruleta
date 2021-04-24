using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
   public class ENRoulettes
    {
        public int IdRuleta { get; set; }
        public int IdParticipante { get; set; }
        public string DesParticipante { get; set; }
        public float NumCreditoApostado { get; set; }
        public float NumCreditoGanado { get; set; }
        public string ValorApostado { get; set; }
        public string ValorGanador { get; set; }
        public string MotivoGanador { get; set; }
        public string DesNomEstado { get; set; }
        public string Estado { get; set; }
        public string Resultado { get; set; }
    }
}
