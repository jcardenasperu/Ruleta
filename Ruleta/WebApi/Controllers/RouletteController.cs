using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using UnitOfWork;

namespace WebApi.Controllers
{
    [RoutePrefix("api/roulette")]
    public class RouletteController : BaseController
    {
        public RouletteController(IUnitOfWork unit) : base(unit)
        {
        }
        [Route("createRoulette")]
        [HttpPost]
        public IHttpActionResult Post()
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);
            String message = "";
            _unit.Roulette.createRoulette(ref message);
            string[] resultados = message.Split('|');
            if (resultados.Length == 1)
            {
                return BadRequest("Denegada");
            }
            else
            {
                return Ok(new { IdRuleta = resultados[1] });
            }
        }
        [Route("openRoulette")]
        [HttpPut]
        public IHttpActionResult Put([FromBody] ENRoulettes roulettes)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);
            if (roulettes == null) return BadRequest("Denegada");
            if (roulettes.IdRuleta == 0) return BadRequest("Denegada");
            String message = "";
            _unit.Roulette.openRoulette(roulettes, ref message);
            string[] resultados = message.Split('|');
            if (resultados.Length == 1)
            {
                return BadRequest("Denegada");
            }
            else
            {
                return Ok(new { Message = "Exitosa" });
            }
        }
        [Route("betRoulette")]
        [HttpPut]
        public IHttpActionResult PutApostar([FromBody] ENRoulettes roulettes)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);
            if (roulettes == null) return BadRequest("Denegada");
            if (roulettes.IdRuleta == 0) return BadRequest("Denegada");
            int IdParticipateInput = 0;
            var therequest = Request;
            var theheader = therequest.Headers;
            int aprobacion = 0;
            if (theheader.Contains("Participante"))
            {
                IdParticipateInput = int.Parse(theheader.GetValues("Participante").First());
                ENParticipates participates = new ENParticipates();
                participates.IdParcipante = IdParticipateInput;
                participates.CreditoApostar = roulettes.NumCreditoApostado;
                String CreditStatus = "";
                _unit.Roulette.participanteValidateCredit(participates, ref CreditStatus);
                string[] resultadaValidacion = CreditStatus.Split('|');
                if (resultadaValidacion.Length == 1)
                {
                    aprobacion = 0;
                }
                else
                {
                    aprobacion = 1;
                }
            }
            else
            {
                return BadRequest("Denegada");
            }
            if (aprobacion == 0) return BadRequest("Denegada");
            String message = "";
            roulettes.IdParticipante = IdParticipateInput;
            _unit.Roulette.betRouletteByParticipate(roulettes, ref message);
            string[] resultados = message.Split('|');
            if (resultados.Length == 1)
            {
                return BadRequest("Denegada");
            }
            else
            {
                return Ok(new { Message = "Exitosa" });
            }
        }
        [Route("closeRoulette")]
        [HttpPut]
        public IHttpActionResult PutCerrar([FromBody] ENRoulettes roulettes)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);
            if (roulettes == null) return BadRequest("Denegada");
            if (roulettes.IdRuleta == 0) return BadRequest("Denegada");
            List<ENRoulettes> lstParticipates = new List<ENRoulettes>();
            roulettes.ValorGanador = ReturnValueWinner();
            lstParticipates = _unit.Roulette.closeRoulette(roulettes).ToList();
            if (lstParticipates.Count == 0)
            {
                return BadRequest("Denegada");
            }
            else
            {
                if (lstParticipates.Count == 1)
                {
                    if (lstParticipates[0].Resultado != null) {
                        if (lstParticipates[0].Resultado != "") return BadRequest("Denegada");
                    }
                    return Ok(new { results = lstParticipates });
                }
                return Ok(new { results = lstParticipates });
            }
        }
        [Route("listRoulette")]
        [HttpGet]
        public IHttpActionResult GetList()
        {
            List<ENRoulettes> ListRoulettes = new List<ENRoulettes>();
            ListRoulettes = _unit.Roulette.listRoulette().ToList();
            return Ok(new { results = ListRoulettes });
        }
        public string ReturnValueWinner()
        {
            //Allow the app to get winner value
            String betWinner = "";
            Random rndNumber = new Random();
            int numberWinner = rndNumber.Next(1, 36);
            if ((numberWinner % 2) == 0)
                betWinner = numberWinner.ToString() + "|Rojo";
            else
                betWinner = numberWinner.ToString() + "|Negro";
            return betWinner;
        }
    }
}
