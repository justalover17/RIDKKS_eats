package com.coursework.controller;

import com.coursework.entity.User;
import com.coursework.utils.SessionUtil;
import com.coursework.dao.CartDao;
import com.coursework.dao.CartDaoImpl;
import com.coursework.dao.CartDetailsDao;
import com.coursework.dao.CartDetailsDaoImpl;
import com.coursework.dao.FoodItemDao;
import com.coursework.dao.FoodItemDaoImpl;
import com.coursework.entity.Cart;
import com.coursework.entity.CartDetails;
import com.coursework.entity.FoodItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private final CartDao cartDao = new CartDaoImpl();
    private final CartDetailsDao cartDetailsDao = new CartDetailsDaoImpl();
    private final FoodItemDao foodDao = new FoodItemDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Must be logged in
        User user = SessionUtil.getUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get cart
        Cart cart = cartDao.getCartByUserId(user.getUserId());

        // If cart empty → back to food list
        if (cart == null) {
            response.sendRedirect(request.getContextPath() + "/food");
            return;
        }

        ArrayList<CartDetails> items = cartDetailsDao.getCartItems(cart.getCartId());

        if (items == null || items.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/food");
            return;
        }

        // Calculate total and attach food details
        double total = 0;
        for (CartDetails item : items) {
            FoodItem food = foodDao.findFoodById(item.getFoodId());
            if (food != null) {
                total += food.getPrice() * item.getQuantity();
            }
        }

        request.setAttribute("cartItems", items);
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

        // TODO: Save order to your orders table here using OrderDao

        // Clear cart after order placed
        Cart cart = cartDao.getCartByUserId(user.getUserId());
        if (cart != null) {
            ArrayList<CartDetails> items = cartDetailsDao.getCartItems(cart.getCartId());
            for (CartDetails item : items) {
                cartDetailsDao.removeItem(item.getCartDetailId());
            }
        }

        // Set success flag and redirect
        request.getSession().setAttribute("orderSuccess", true);
        response.sendRedirect(request.getContextPath() + "/checkout?status=success");
    }
}
