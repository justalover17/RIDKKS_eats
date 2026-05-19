package com.coursework.dao;

import com.coursework.entity.FoodItem;
import com.coursework.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;

public class FoodItemDaoImpl implements FoodItemDao {

    private FoodItem mapFood(ResultSet rs) throws SQLException {
        return new FoodItem(
                rs.getInt("food_id"),
                rs.getString("name"),
                rs.getDouble("price"),
                rs.getInt("category_id"),
                rs.getString("description"),
                rs.getString("image_path"),
                rs.getTimestamp("created_at"),
                rs.getTimestamp("updated_at")
        );
    }

    @Override
    public boolean insertFood(FoodItem food) {
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "INSERT INTO food_item (name, price, category_id, description, image_path) VALUES (?, ?, ?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, food.getName());
            ps.setDouble(2, food.getPrice());
            ps.setInt(3, food.getCategoryId());
            ps.setString(4, food.getDescription());
            ps.setString(5, food.getImagePath());

            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.out.println("Error inserting food: " + e.getMessage());
            return false;

        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public ArrayList<FoodItem> fetchAllFood() {
        ArrayList<FoodItem> list = new ArrayList<>();
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "SELECT * FROM food_item ORDER BY food_id ASC";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                list.add(mapFood(rs));
            }

        } catch (SQLException e) {
            System.out.println("Error fetching food: " + e.getMessage());

        } finally {
            DatabaseConnection.closeConnection(conn);
        }

        return list;
    }

    @Override
    public ArrayList<FoodItem> fetchFoodByCategory(int categoryId) {
        ArrayList<FoodItem> list = new ArrayList<>();
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "SELECT * FROM food_item WHERE category_id = ? ORDER BY food_id ASC";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapFood(rs));
            }

        } catch (SQLException e) {
            System.out.println("Error fetching food by category: " + e.getMessage());

        } finally {
            DatabaseConnection.closeConnection(conn);
        }

        return list;
    }

    @Override
    public ArrayList<FoodItem> searchFood(String query) {
        ArrayList<FoodItem> list = new ArrayList<>();
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "SELECT * FROM food_item WHERE name LIKE ? OR description LIKE ? ORDER BY food_id ASC";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapFood(rs));
            }

        } catch (SQLException e) {
            System.out.println("Error searching food: " + e.getMessage());

        } finally {
            DatabaseConnection.closeConnection(conn);
        }

        return list;
    }

    @Override
    public FoodItem findFoodById(int id) {
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "SELECT * FROM food_item WHERE food_id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapFood(rs);
            }

        } catch (SQLException e) {
            System.out.println("Error finding food: " + e.getMessage());

        } finally {
            DatabaseConnection.closeConnection(conn);
        }

        return null;
    }

    @Override
    public boolean updateFood(FoodItem food) {
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "UPDATE food_item SET name = ?, price = ?, category_id = ?, description = ?, image_path = ? WHERE food_id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, food.getName());
            ps.setDouble(2, food.getPrice());
            ps.setInt(3, food.getCategoryId());
            ps.setString(4, food.getDescription());
            ps.setString(5, food.getImagePath());
            ps.setInt(6, food.getFoodId());

            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.out.println("Error updating food: " + e.getMessage());
            return false;

        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public boolean deleteFood(int id) {
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);

            // Remove food from carts first
            String deleteCartDetails = "DELETE FROM cart_details WHERE food_id = ?";
            PreparedStatement cartPs = conn.prepareStatement(deleteCartDetails);
            cartPs.setInt(1, id);
            cartPs.executeUpdate();

            // Remove food from order details also, because foreign key can block delete
            String deleteOrderDetails = "DELETE FROM order_details WHERE food_id = ?";
            PreparedStatement orderPs = conn.prepareStatement(deleteOrderDetails);
            orderPs.setInt(1, id);
            orderPs.executeUpdate();

            // Now delete actual food item
            String deleteFood = "DELETE FROM food_item WHERE food_id = ?";
            PreparedStatement foodPs = conn.prepareStatement(deleteFood);
            foodPs.setInt(1, id);

            int rows = foodPs.executeUpdate();

            conn.commit();
            return rows > 0;

        } catch (SQLException e) {
            System.out.println("Error deleting food: " + e.getMessage());

            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackError) {
                System.out.println("Rollback error: " + rollbackError.getMessage());
            }

            return false;

        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                }
            } catch (SQLException e) {
                System.out.println("Auto commit reset error: " + e.getMessage());
            }

            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public int countFoodItems() {
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "SELECT COUNT(*) AS total FROM food_item";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("total");
            }

        } catch (SQLException e) {
            System.out.println("Error counting food items: " + e.getMessage());

        } finally {
            DatabaseConnection.closeConnection(conn);
        }

        return 0;
    }

    @Override
    public ArrayList<FoodItem> fetchRecentFoodItems(int limit) {
        ArrayList<FoodItem> list = new ArrayList<>();
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "SELECT * FROM food_item ORDER BY food_id DESC LIMIT ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapFood(rs));
            }

        } catch (SQLException e) {
            System.out.println("Error fetching recent food items: " + e.getMessage());

        } finally {
            DatabaseConnection.closeConnection(conn);
        }

        return list;
    }
}