package vn.dao.implement;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import vn.configs.JPAConfigs;
import vn.dao.ICategoryDao;
import vn.entity.Category;

public class CategoryDaoImpl implements ICategoryDao {

    @Override
    public void insert(Category category) {
        EntityManager enma = JPAConfigs.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(category);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(Category category) {
        EntityManager enma = JPAConfigs.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(category);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void delete(int id) throws Exception {
        EntityManager enma = JPAConfigs.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Category category = enma.find(Category.class, id);
            if (category != null) {
                enma.remove(category);
            } else {
                throw new Exception("Category not found");
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public Category findById(int id) {
        EntityManager enma = JPAConfigs.getEntityManager();
        Category category = enma.find(Category.class, id);
        enma.close();
        return category;
    }

    @Override
    public List<Category> findAll() {
        EntityManager enma = JPAConfigs.getEntityManager();
        TypedQuery<Category> query = enma.createQuery("SELECT c FROM Category c", Category.class);
        List<Category> categories = query.getResultList();
        enma.close();
        return categories;
    }

    @Override
    public List<Category> findByName(String name) {
        EntityManager enma = JPAConfigs.getEntityManager();
        String jpql = "SELECT c FROM Category c WHERE c.name like :name";
        TypedQuery<Category> query = enma.createQuery(jpql, Category.class);
        query.setParameter("name", "%" + name + "%");
        List<Category> categories = query.getResultList();
        enma.close();
        return categories;
    }

    @Override
    public List<Category> findAll(int page, int pageSize) {
        EntityManager enma = JPAConfigs.getEntityManager();
        TypedQuery<Category> query = enma.createQuery("SELECT c FROM Category c", Category.class);
        query.setFirstResult(page * pageSize);
        query.setMaxResults(pageSize);
        List<Category> categories = query.getResultList();
        enma.close();
        return categories;
    }

    @Override
    public int count() {
        EntityManager enma = JPAConfigs.getEntityManager();
        String jpql = "SELECT count(c) FROM Category c";
        Query query = enma.createQuery(jpql);
        Long count = (Long) query.getSingleResult();
        enma.close();
        return count.intValue();
    }
}
