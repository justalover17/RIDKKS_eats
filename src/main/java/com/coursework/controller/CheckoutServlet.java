package com.coursework.controller;

import com.coursework.entity.User;
import com.coursework.utils.SessionUtil;
import com.coursework.dao.CartDao;
import com.coursework.dao.CartDaoImpl;
import com.coursework.dao.CartDetailsDao;
import com.coursework.dao.CartDetailsDaoImpl;
import com.coursework.dao.FoodItemDao;
import com.coursework.dao.FoodItemDaoImpl;
import com.coursework.dao.OrdersDao;
import com.coursework.dao.OrdersDaoImpl;
import com.coursework.dao.OrderDetailsDao;
import com.coursework.dao.OrderDetailsDaoImpl;
import com.coursework.entity.Cart;
import com.coursework.entity.CartDetails;
import com.coursework.entity.FoodItem;
import com.coursework.entity.Orders;
import com.coursework.entity.OrderDetails;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private final CartDao cartDao = new CartDaoImpl();
    private final CartDetailsDao cartDetailsDao = new CartDetailsDaoImpl();
    private final FoodItemDao foodDao = new FoodItemDaoImpl();
    private final OrdersDao ordersDao = new OrdersDaoImpl();
    private final OrderDetailsDao orderDetailsDao = new OrderDetailsDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = SessionUtil.getUser(request);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if ("success".equals(request.getParameter("status"))) {
            request.getRequestDispatcher("/WEB-INF/views/checkout.jsp")
                    .forward(request, response);
            return;
        }

        Cart cart = cartDao.getCartByUserId(user.getUserId());

        if (cart == null) {
            response.sendRedirect(request.getContextPath() + "/food");
            return;
        }

        ArrayList<CartDetails> items = cartDetailsDao.getCartItems(cart.getCartId());

        if (items == null || items.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/food");
            return;
        }

        Map<Integer, FoodItem> foodMap = buildFoodMap(items);
        double total = calculateCartTotal(items);

        request.setAttribute("cartItems", items);
        request.setAttribute("foodMap", foodMap);
        request.setAttribute("total", total);

        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = SessionUtil.getUser(request);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Cart cart = cartDao.getCartByUserId(user.getUserId());

        if (cart == null) {
            response.sendRedirect(request.getContextPath() + "/cart?action=view");
            return;
        }

        ArrayList<CartDetails> items = cartDetailsDao.getCartItems(cart.getCartId());

        if (items == null || items.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart?action=view");
            return;
        }

        double total = calculateCartTotal(items);

        if (total <= 0) {
            request.setAttribute("error", "Order could not be placed because the cart total is invalid.");
            request.setAttribute("cartItems", items);
            request.setAttribute("foodMap", buildFoodMap(items));
            request.setAttribute("total", total);

            request.getRequestDispatcher("/WEB-INF/views/checkout.jsp")
                    .forward(request, response);
            return;
        }

        Orders order = new Orders(0, user.getUserId(), total, "Pending");
        int orderId = ordersDao.placeOrderAndGetId(order);

        if (orderId <= 0) {
            request.setAttribute("error", "Order could not be placed. Please try again.");
            request.setAttribute("cartItems", items);
            request.setAttribute("foodMap", buildFoodMap(items));
            request.setAttribute("total", total);

            request.getRequestDispatcher("/WEB-INF/views/checkout.jsp")
                    .forward(request, response);
            return;
        }

        for (CartDetails item : items) {
            FoodItem food = foodDao.findFoodById(item.getFoodId());

            if (food != null) {
                double subtotal = food.getPrice() * item.getQuantity();
                OrderDetails detail = new OrderDetails(0, orderId, item.getFoodId(), item.getQuantity(), subtotal);
                orderDetailsDao.addOrderItem(detail);
            }
        }

        for (CartDetails item : items) {
            cartDetailsDao.removeItemFromCart(item.getCartDetailId(), cart.getCartId());
        }

        request.getSession().setAttribute("orderSuccess", true);
        response.sendRedirect(request.getContextPath() + "/checkout?status=success");
    }

    private Map<Integer, FoodItem> buildFoodMap(ArrayList<CartDetails> items) {
        Map<Integer, FoodItem> foodMap = new HashMap<>();

        for (CartDetails item : items) {
            FoodItem food = foodDao.findFoodById(item.getFoodId());

            if (food != null) {
                foodMap.put(item.getFoodId(), food);
            }
        }

        return foodMap;
    }

    private double calculateCartTotal(ArrayList<CartDetails> items) {
        double total = 0;

        for (CartDetails item : items) {
            FoodItem food = foodDao.findFoodById(item.getFoodId());

            if (food != null) {
                total += food.getPrice() * item.getQuantity();
            }
        }

        return total;
    }
}