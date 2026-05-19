package com.coursework.controller;

import com.coursework.dao.OrdersDao;
import com.coursework.dao.OrdersDaoImpl;
import com.coursework.dao.OrderDetailsDao;
import com.coursework.dao.OrderDetailsDaoImpl;
import com.coursework.dao.FoodItemDao;
import com.coursework.dao.FoodItemDaoImpl;

import com.coursework.entity.Orders;
import com.coursework.entity.OrderDetails;
import com.coursework.entity.FoodItem;
import com.coursework.entity.User;

import com.coursework.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    private final OrdersDao orderDao = new OrdersDaoImpl();
    private final OrderDetailsDao orderDetailsDao = new OrderDetailsDaoImpl();
    private final FoodItemDao foodDao = new FoodItemDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "history";
        }

        switch (action) {
            case "checkout":
                response.sendRedirect(request.getContextPath() + "/checkout");
                break;

            case "details":
                orderDetails(request, response);
                break;

            case "history":
            default:
                orderHistory(request, response);
                break;
        }
    }

    private void orderHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = SessionUtil.getUser(request);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        ArrayList<Orders> orders;

        boolean isAdmin = user.getRole() != null && user.getRole().equalsIgnoreCase("admin");

        if (isAdmin) {
            orders = orderDao.fetchAllOrders();
        } else {
            orders = orderDao.getOrdersByUserId(user.getUserId());
        }

        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/WEB-INF/views/order-history.jsp")
                .forward(request, response);
    }

    private void orderDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = SessionUtil.getUser(request);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int orderId = parseInt(request.getParameter("orderId"), 0);

        if (orderId <= 0) {
            response.sendRedirect(request.getContextPath() + "/order?action=history");
            return;
        }

        Orders order = orderDao.findOrderById(orderId);

        if (order == null) {
            response.sendRedirect(request.getContextPath() + "/order?action=history");
            return;
        }

        boolean isAdmin = user.getRole() != null && user.getRole().equalsIgnoreCase("admin");

        if (!isAdmin && order.getUserId() != user.getUserId()) {
            response.sendRedirect(request.getContextPath() + "/order?action=history");
            return;
        }

        ArrayList<OrderDetails> items = orderDetailsDao.getOrderItems(orderId);
        Map<Integer, FoodItem> foodMap = new HashMap<>();

        double total = 0;

        for (OrderDetails item : items) {
            total += item.getSubtotal();

            FoodItem food = foodDao.findFoodById(item.getFoodId());

            if (food != null) {
                foodMap.put(item.getFoodId(), food);
            }
        }

        request.setAttribute("order", order);
        request.setAttribute("items", items);
        request.setAttribute("foodMap", foodMap);
        request.setAttribute("total", total);

        request.getRequestDispatcher("/WEB-INF/views/order-details.jsp")
                .forward(request, response);
    }

    private int parseInt(String value, int defaultValue) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return defaultValue;
        }
    }
}