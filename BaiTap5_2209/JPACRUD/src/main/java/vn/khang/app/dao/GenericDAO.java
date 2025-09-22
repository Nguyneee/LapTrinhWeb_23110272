package vn.khang.app.dao;

import java.util.List;
import java.util.function.Consumer;
import java.util.function.Function;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class GenericDAO<T, K> {

  private final Class<T> clazz;

  public GenericDAO(Class<T> clazz) { this.clazz = clazz; }

  public T findById(K id) {
    EntityManager em = JPAUtil.getEMF().createEntityManager();
    try { return em.find(clazz, id); }
    finally { em.close(); }
  }

  public List<T> findAll() {
    EntityManager em = JPAUtil.getEMF().createEntityManager();
    try {
      return em.createQuery("SELECT e FROM " + clazz.getSimpleName() + " e", clazz)
               .getResultList();
    } finally { em.close(); }
  }

  public void persist(T entity) { tx(em -> em.persist(entity)); }

  public T merge(T entity) { return txRet(em -> em.merge(entity)); }

  public void remove(K id) {
    tx(em -> {
      T e = em.find(clazz, id);
      if (e != null) em.remove(e);
    });
  }

  private void tx(Consumer<EntityManager> body) {
    EntityManager em = JPAUtil.getEMF().createEntityManager();
    EntityTransaction tx = em.getTransaction();
    try {
      tx.begin();
      body.accept(em);
      tx.commit();
    } catch (RuntimeException ex) {
      if (tx.isActive()) tx.rollback();
      throw ex;
    } finally { em.close(); }
  }

  private <R> R txRet(Function<EntityManager,R> body) {
    EntityManager em = JPAUtil.getEMF().createEntityManager();
    EntityTransaction tx = em.getTransaction();
    try {
      tx.begin();
      R r = body.apply(em);
      tx.commit();
      return r;
    } catch (RuntimeException ex) {
      if (tx.isActive()) tx.rollback();
      throw ex;
    } finally { em.close(); }
  }
}
