package com.coursework.dao;

import com.coursework.entity.Orders;
import com.coursework.entity.WeeklyData;
import com.coursework.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class OrdersDaoImpl implements OrdersDao {

    @Override
    public boolean placeOrder(Orders order) {
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "INSERT INTO orders (user_id, total_amount, status, order_date) VALUES (?, ?, ?, CURDATE())";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, order.getUserId());
            ps.setDouble(2, order.getTotalAmount());
            ps.setString(3, order.getStatus());

            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.out.println("Error placing order: " + e.getMessage());
            return false;

        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public int placeOrderAndGetId(Orders order) {
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "INSERT INTO orders (user_id, total_amount, status, order_date) VALUES (?, ?, ?, CURDATE())";

            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getUserId());
            ps.setDouble(2, order.getTotalAmount());
            ps.setString(3, order.getStatus());

            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                ResultSet rs = ps.getGeneratedKeys();

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            System.out.println("Error placing order and getting ID: " + e.getMessage());

        } finally {
            DatabaseConnection.closeConnection(conn);
        }

        return 0;
    }

    @Override
    public ArrayList<Orders> fetchAllOrders() {
        ArrayList<Orders> list = new ArrayList<>();
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "SELECT * FROM orders ORDER BY order_id DESC";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Orders order = new Orders(
                        rs.getInt("order_id"),
                        rs.getInt("user_id"),
                        rs.getDouble("total_amount"),
                        rs.getString("status")
                );

                order.setCreatedAt(rs.getTimestamp("order_date"));
                list.add(order);
            }

        } catch (SQLException e) {
            System.out.println("Error fetching orders: " + e.getMessage());

        } finally {
            DatabaseConnection.closeConnection(conn);
        }

        return list;
    }

    @Override
    public ArrayList<Orders> getOrdersByUserId(int userId) {
        ArrayList<Orders> list = new ArrayList<>();
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_id DESC";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Orders order = new Orders(
                        rs.getInt("order_id"),
                        rs.getInt("user_id"),
                        rs.getDouble("total_amount"),
                        rs.getString("status")
                );

                order.setCreatedAt(rs.getTimestamp("order_date"));
                list.add(order);
            }

        } catch (SQLException e) {
            System.out.println("Error getting user orders: " + e.getMessage());

        } finally {
            DatabaseConnection.closeConnection(conn);
        }

        return list;
    }

    @Override
    public Orders findOrderById(int id) {
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "SELECT * FROM orders WHERE order_id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Orders order = new Orders(
                        rs.getInt("order_id"),
                        rs.getInt("user_id"),
                        rs.getDouble("total_amount"),
                        rs.getString("status")
                );

                order.setCreatedAt(rs.getTimestamp("order_date"));
                return order;
            }

        } catch (SQLException e) {
            System.out.println("Error finding order: " + e.getMessage());

        } finally {
            DatabaseConnection.closeConnection(conn);
        }

        return null;
    }

    @Override
    public boolean updateOrderStatus(int orderId, String status) {
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "UPDATE orders SET status = ? WHERE order_id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderId);

            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.out.println("Error updating order status: " + e.getMessage());
            return false;

        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public boolean deleteOrder(int id) {
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "DELETE FROM orders WHERE order_id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.out.println("Error deleting order: " + e.getMessage());
            return false;

        } finally {
            DatabaseConnection.closeConnection(conn);
        }
    }

    @Override
    public int countTotalOrders() {
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "SELECT COUNT(*) AS total FROM orders";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("total");
            }

        } catch (SQLException e) {
            System.out.println("Error counting total orders: " + e.getMessage());

        } finally {
            DatabaseConnection.closeConnection(conn);
        }

        return 0;
    }

    @Override
    public int countOrdersToday() {
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "SELECT COUNT(*) AS total FROM orders WHERE order_date = CURDATE()";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("total");
            }

        } catch (SQLException e) {
            System.out.println("Error counting today's orders: " + e.getMessage());

        } finally {
            DatabaseConnection.closeConnection(conn);
        }

        return 0;
    }

    @Override
    public double calculateTotalRevenue() {
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "SELECT COALESCE(SUM(total_amount), 0) AS revenue FROM orders";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getDouble("revenue");
            }

        } catch (SQLException e) {
            System.out.println("Error calculating revenue: " + e.getMessage());

        } finally {
            DatabaseConnection.closeConnection(conn);
        }

        return 0;
    }

    @Override
    public ArrayList<Orders> fetchRecentOrders(int limit) {
        ArrayList<Orders> list = new ArrayList<>();
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "SELECT * FROM orders ORDER BY order_id DESC LIMIT ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Orders order = new Orders(
                        rs.getInt("order_id"),
                        rs.getInt("user_id"),
                        rs.getDouble("total_amount"),
                        rs.getString("status")
                );

                order.setCreatedAt(rs.getTimestamp("order_date"));
                list.add(order);
            }

        } catch (SQLException e) {
            System.out.println("Error fetching recent orders: " + e.getMessage());

        } finally {
            DatabaseConnection.closeConnection(conn);
        }

        return list;
    }

    @Override
    public ArrayList<WeeklyData> fetchWeeklyOrderCounts() {
        ArrayList<WeeklyData> list = new ArrayList<>();
        Connection conn = null;

        try {
            conn = DatabaseConnection.getConnection();

            String sql = "SELECT order_date, COUNT(*) AS order_count " +
                    "FROM orders " +
                    "WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 6 DAY) " +
                    "GROUP BY order_date " +
                    "ORDER BY order_date ASC";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                WeeklyData data = new WeeklyData(
                        rs.getString("order_date"),
                        rs.getInt("order_count")
                );

                list.add(data);
            }

        } catch (SQLException e) {
            System.out.println("Error fetching weekly order counts: " + e.getMessage());

        } finally {
            DatabaseConnection.closeConnection(conn);
        }

        return list;
    }
}