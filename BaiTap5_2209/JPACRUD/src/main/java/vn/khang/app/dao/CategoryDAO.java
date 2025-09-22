package vn.khang.app.dao;

import java.util.List;
import jakarta.persistence.EntityManager;
import vn.khang.app.entity.Category;

public class CategoryDAO extends GenericDAO<Category, Long> {
  public CategoryDAO() { super(Category.class); }

  public List<Category> search(String keyword, int page, int size) {
    EntityManager em = JPAUtil.getEMF().createEntityManager();
    try {
      String kw = "%" + (keyword == null ? "" : keyword.toLowerCase()) + "%";
      return em.createQuery(
          "SELECT c FROM Category c " +
          "WHERE LOWER(c.name) LIKE :kw OR LOWER(c.description) LIKE :kw " +
          "ORDER BY c.id DESC", Category.class)
        .setParameter("kw", kw)
        .setFirstResult(page * size)
        .setMaxResults(size)
        .getResultList();
    } finally { em.close(); }
  }

  public long countSearch(String keyword) {
    EntityManager em = JPAUtil.getEMF().createEntityManager();
    try {
      String kw = "%" + (keyword == null ? "" : keyword.toLowerCase()) + "%";
      return em.createQuery(
        "SELECT COUNT(c) FROM Category c " +
        "WHERE LOWER(c.name) LIKE :kw OR LOWER(c.description) LIKE :kw", Long.class)
        .setParameter("kw", kw)
        .getSingleResult();
    } finally { em.close(); }
  }
}
