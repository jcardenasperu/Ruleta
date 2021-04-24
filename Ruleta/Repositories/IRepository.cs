using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositories
{
    public interface IRepository<T> where T : class
    {
        int Insert(T entity);
        T GetById(int id);
        bool Update(T entity);
        bool Delete(T entity);
        IEnumerable<T> GetList();
    }
}
