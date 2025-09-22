package vn.khang.app.dao;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {
  private static final EntityManagerFactory emf = 
      Persistence.createEntityManagerFactory("VideoAppPU");

  public static EntityManagerFactory getEMF() { return emf; }
}
