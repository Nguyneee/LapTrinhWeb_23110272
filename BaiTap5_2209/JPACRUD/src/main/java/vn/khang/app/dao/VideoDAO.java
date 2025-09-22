package vn.khang.app.dao;

import java.util.List;
import jakarta.persistence.EntityManager;
import vn.khang.app.entity.Video;

public class VideoDAO extends GenericDAO<Video, Long> {
  public VideoDAO() { super(Video.class); }

  public List<Video> search(String keyword, Long categoryId, int page, int size) {
    EntityManager em = JPAUtil.getEMF().createEntityManager();
    try {
      String kw = "%" + (keyword == null ? "" : keyword.toLowerCase()) + "%";
      String jpql = "SELECT v FROM Video v WHERE " +
          "(LOWER(v.title) LIKE :kw OR LOWER(v.description) LIKE :kw) " +
          (categoryId != null ? "AND v.category.id = :cid " : "") +
          "ORDER BY v.id DESC";
      var q = em.createQuery(jpql, Video.class)
          .setParameter("kw", kw)
          .setFirstResult(page * size)
          .setMaxResults(size);
      if (categoryId != null) q.setParameter("cid", categoryId);
      return q.getResultList();
    } finally { em.close(); }
  }

  public long countSearch(String keyword, Long categoryId) {
    EntityManager em = JPAUtil.getEMF().createEntityManager();
    try {
      String kw = "%" + (keyword == null ? "" : keyword.toLowerCase()) + "%";
      String jpql = "SELECT COUNT(v) FROM Video v WHERE " +
          "(LOWER(v.title) LIKE :kw OR LOWER(v.description) LIKE :kw) " +
          (categoryId != null ? "AND v.category.id = :cid " : "");
      var q = em.createQuery(jpql, Long.class).setParameter("kw", kw);
      if (categoryId != null) q.setParameter("cid", categoryId);
      return q.getSingleResult();
    } finally { em.close(); }
  }
}
