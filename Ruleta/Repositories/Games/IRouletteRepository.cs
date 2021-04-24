using Models;
using System.Collections.Generic;

namespace Repositories.Games
{
    public  interface IRouletteRepository : IRepository<ENRoulettes>
    {
        void openRoulette(ENRoulettes roulettes, ref string message);
        void createRoulette(ref string message);
        void participanteValidateCredit(ENParticipates participates, ref string message);
        void betRouletteByParticipate(ENRoulettes roulettes, ref string message);
        IEnumerable<ENRoulettes> closeRoulette(ENRoulettes roulettes);
        IEnumerable<ENRoulettes> listRoulette();
    }
}
