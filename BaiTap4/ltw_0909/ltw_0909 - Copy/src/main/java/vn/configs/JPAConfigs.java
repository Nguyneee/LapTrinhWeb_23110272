package vn.configs;

import jakarta.persistence.EntityManager;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.persistence.PersistenceContext;
import vn.entity.Category;

@PersistenceContext
public class JPAConfigs {

	public static EntityManager getEntityManager() {

		EntityManagerFactory factory = Persistence.createEntityManagerFactory("dataSource");

		return factory.createEntityManager();

	}

	public static void main(String[] args) {

		EntityManager enma = JPAConfigs.getEntityManager();
		EntityTransaction trans = enma.getTransaction();
		Category cate = new Category();
		cate.setName("Iphone");
		cate.setImages("abc.jpg");
		try {
			trans.begin();
			enma.persist(cate);
			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
			trans.rollback();
			throw e;
		} finally {
			enma.close();
		}
	}
}
