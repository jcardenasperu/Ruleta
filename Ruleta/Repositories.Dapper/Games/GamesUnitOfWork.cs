using Repositories.Games;
using UnitOfWork;

namespace Repositories.Dapper.Games
{
    public class GamesUnitOfWork : IUnitOfWork
    {
        public GamesUnitOfWork(string connectionString)
        {
            Roulette = new RouletteRepository(connectionString);
        }

        public IRouletteRepository Roulette
        {
            get;
            private set;
        }
    }
}
