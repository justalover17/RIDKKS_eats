package com.coursework.dao;

import com.coursework.entity.Orders;
import com.coursework.entity.WeeklyData;

import java.util.ArrayList;

public interface OrdersDao {

    boolean placeOrder(Orders order);

    int placeOrderAndGetId(Orders order);

    ArrayList<Orders> fetchAllOrders();

    ArrayList<Orders> getOrdersByUserId(int userId);

    Orders findOrderById(int id);

    boolean updateOrderStatus(int orderId, String status);

    boolean deleteOrder(int id);

    int countTotalOrders();

    int countOrdersToday();

    double calculateTotalRevenue();

    ArrayList<Orders> fetchRecentOrders(int limit);

    ArrayList<WeeklyData> fetchWeeklyOrderCounts();
}