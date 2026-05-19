package com.coursework.controller;

import com.coursework.dao.CategoryDao;
import com.coursework.dao.CategoryDaoImpl;
import com.coursework.dao.FoodItemDao;
import com.coursework.dao.FoodItemDaoImpl;
import com.coursework.dao.OrdersDao;
import com.coursework.dao.OrdersDaoImpl;

import com.coursework.entity.FoodItem;
import com.coursework.entity.Orders;
import com.coursework.entity.User;
import com.coursework.entity.WeeklyData;

import com.coursework.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final FoodItemDao foodDao = new FoodItemDaoImpl();
    private final CategoryDao categoryDao = new CategoryDaoImpl();
    private final OrdersDao ordersDao = new OrdersDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = SessionUtil.getUser(request);

        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int totalFoodItems = foodDao.countFoodItems();
        int totalCategories = categoryDao.countCategories();
        int totalOrders = ordersDao.countTotalOrders();
        int ordersToday = ordersDao.countOrdersToday();
        double totalRevenue = ordersDao.calculateTotalRevenue();

        ArrayList<FoodItem> recentFoods = foodDao.fetchRecentFoodItems(5);
        ArrayList<Orders> recentOrders = ordersDao.fetchRecentOrders(5);

        ArrayList<WeeklyData> weeklyData = ordersDao.fetchWeeklyOrderCounts();

        ArrayList<String> dates = new ArrayList<>();
        ArrayList<Integer> counts = new ArrayList<>();

        for (WeeklyData wd : weeklyData) {
            dates.add(wd.getDate());
            counts.add(wd.getCount());
        }

        request.setAttribute("totalFoodItems", totalFoodItems);
        request.setAttribute("totalCategories", totalCategories);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("ordersToday", ordersToday);
        request.setAttribute("totalRevenue", totalRevenue);

        request.setAttribute("recentFoods", recentFoods);
        request.setAttribute("recentOrders", recentOrders);

        request.setAttribute("dates", dates);
        request.setAttribute("counts", counts);

        request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp")
                .forward(request, response);
    }
}