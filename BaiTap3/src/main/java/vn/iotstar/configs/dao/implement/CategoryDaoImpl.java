package vn.iotstar.configs.dao.implement;

import java.sql.*;
import java.util.*;

import vn.iotstar.configs.DBConnect;
import vn.iotstar.configs.dao.ICategoryDao;
import vn.iotstar.configs.model.CategoryModel;

public class CategoryDaoImpl extends DBConnect implements ICategoryDao {

    @Override
    public void insert(CategoryModel category) {
        String sql = "INSERT INTO Category (cate_name, icons) VALUES (?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setString(2, category.getIcon());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public void edit(CategoryModel category) {
        String sql = "UPDATE Category SET cate_name = ?, icons = ? WHERE cate_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setString(2, category.getIcon());
            ps.setInt(3, category.getId());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM Category WHERE cate_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public CategoryModel get(int id) {
        String sql = "SELECT * FROM Category WHERE cate_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new CategoryModel(
                        rs.getInt("cate_id"),
                        rs.getString("cate_name"),
                        rs.getString("icons")
                );
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public List<CategoryModel> getAll() {
        List<CategoryModel> list = new ArrayList<>();
        String sql = "SELECT * FROM Category";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new CategoryModel(
                        rs.getInt("cate_id"),
                        rs.getString("cate_name"),
                        rs.getString("icons")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

	@Override
	public List<CategoryModel> findAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public CategoryModel findById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void update(CategoryModel category) {
		// TODO Auto-generated method stub
		
	}
}
