package vn.khang.app.dao;

import java.util.List;
import jakarta.persistence.EntityManager;
import vn.khang.app.entity.User;

public class UserDAO extends GenericDAO<User, Long> {
  public UserDAO() { super(User.class); }

  public User findByUsername(String username) {
    EntityManager em = JPAUtil.getEMF().createEntityManager();
    try {
      List<User> list = em.createQuery("SELECT u FROM User u WHERE u.username = :u", User.class)
        .setParameter("u", username).getResultList();
      return list.isEmpty() ? null : list.get(0);
    } finally { em.close(); }
  }

  public List<User> search(String keyword, int page, int size) {
    EntityManager em = JPAUtil.getEMF().createEntityManager();
    try {
      String kw = "%" + (keyword == null ? "" : keyword.toLowerCase()) + "%";
      return em.createQuery(
        "SELECT u FROM User u WHERE " +
        "LOWER(u.username) LIKE :kw OR LOWER(u.email) LIKE :kw " +
        "ORDER BY u.id DESC", User.class)
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
        "SELECT COUNT(u) FROM User u WHERE LOWER(u.username) LIKE :kw OR LOWER(u.email) LIKE :kw",
        Long.class).setParameter("kw", kw).getSingleResult();
    } finally { em.close(); }
  }
}
