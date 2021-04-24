using Models;
using Repositories.Games;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Repositories.Dapper.Games
{
    public class RouletteRepository : Repository<ENRoulettes>, IRouletteRepository
    {
        public RouletteRepository(string connectionString) : base(connectionString)
        {
        }
        public void openRoulette(ENRoulettes roulettes, ref string message)
        {
            try
            {
                using (var connection = new SqlConnection(_connectionString))
                {
                    var parameters = new DynamicParameters();
                    parameters.Add("@pIdRuleta", roulettes.IdRuleta);
                    parameters.Add("@oMensajeError", message, System.Data.DbType.String, System.Data.ParameterDirection.Output);
                    var userReturn = connection.QueryFirstOrDefault<ENRoulettes>("dbo.usp_RuletaPrincial_Abrir",
                        parameters, commandType: System.Data.CommandType.StoredProcedure);
                    message = parameters.Get<String>("@oMensajeError");
                }
            }
            catch (Exception e)
            {
                message = e.Message.ToString();
            }
        }
        public void createRoulette(ref string message)
        {
            try
            {
                using (var connection = new SqlConnection(_connectionString))
                {
                    var parameters = new DynamicParameters();
                    parameters.Add("@oMensajeError", message, System.Data.DbType.String, System.Data.ParameterDirection.Output);
                    var userReturn = connection.QueryFirstOrDefault<ENRoulettes>("dbo.usp_RuletaPrincial_Crear",
                        parameters, commandType: System.Data.CommandType.StoredProcedure);
                    message = parameters.Get<String>("@oMensajeError");
                }
            }
            catch (Exception e)
            {
                message = e.Message.ToString();
            }
        }
        public void participanteValidateCredit(ENParticipates participates, ref string message)
        {
            try
            {
                using (var connection = new SqlConnection(_connectionString))
                {
                    var parameters = new DynamicParameters();
                    parameters.Add("@pIdParticipante", participates.IdParcipante);
                    parameters.Add("@pCreditoApostar", participates.CreditoApostar);
                    parameters.Add("@oMensajeError", message, System.Data.DbType.String, System.Data.ParameterDirection.Output);
                    var userReturn = connection.QueryFirstOrDefault<ENRoulettes>("dbo.usp_RuletaParticpante_Validar",
                        parameters, commandType: System.Data.CommandType.StoredProcedure);
                    message = parameters.Get<String>("@oMensajeError");
                }
            }
            catch (Exception e)
            {
                message = e.Message.ToString();
            }
        }
        public void betRouletteByParticipate(ENRoulettes roulettes, ref string message)
        {
            try
            {
                using (var connection = new SqlConnection(_connectionString))
                {
                    var parameters = new DynamicParameters();
                    parameters.Add("@pIdRuleta", roulettes.IdRuleta);
                    parameters.Add("@pIdParticipante", roulettes.IdParticipante);
                    parameters.Add("@pValorApostar", roulettes.ValorApostado);
                    parameters.Add("@pCreditoApostar", roulettes.NumCreditoApostado);
                    parameters.Add("@oMensajeError", message, System.Data.DbType.String, System.Data.ParameterDirection.Output);
                    var userReturn = connection.QueryFirstOrDefault<ENRoulettes>("dbo.usp_RuletaParticipante_Apostar",
                        parameters, commandType: System.Data.CommandType.StoredProcedure);
                    message = parameters.Get<String>("@oMensajeError");
                }
            }
            catch (Exception e)
            {
                message = e.Message.ToString();
            }
        }
        public IEnumerable<ENRoulettes> closeRoulette(ENRoulettes roulettes)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                var parameters = new DynamicParameters();
                parameters.Add("@pIdRuleta", roulettes.IdRuleta);
                parameters.Add("@pValorGanador", roulettes.ValorGanador);
                var userReturn = connection.Query<ENRoulettes>("dbo.usp_RuletaPrincial_Cerrar",
                    parameters, commandType: System.Data.CommandType.StoredProcedure);
                return userReturn;
            }
        }
        public IEnumerable<ENRoulettes> listRoulette()
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                var parameters = new DynamicParameters();
                var userReturn = connection.Query<ENRoulettes>("dbo.usp_RuletaPrincial_Listado",
                    parameters, commandType: System.Data.CommandType.StoredProcedure);
                return userReturn;
            }
        }
    }
}
