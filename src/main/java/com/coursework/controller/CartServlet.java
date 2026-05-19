package com.coursework.controller;

import com.coursework.dao.CartDao;
import com.coursework.dao.CartDaoImpl;
import com.coursework.dao.CartDetailsDao;
import com.coursework.dao.CartDetailsDaoImpl;
import com.coursework.dao.FoodItemDao;
import com.coursework.dao.FoodItemDaoImpl;
import com.coursework.entity.Cart;
import com.coursework.entity.CartDetails;
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

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final CartDao cartDao = new CartDaoImpl();
    private final CartDetailsDao cartDetailsDao = new CartDetailsDaoImpl();
    private final FoodItemDao foodDao = new FoodItemDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || "view".equals(action)) {
            viewCart(request, response);
            return;
        }

        // Cart changes should happen through POST.
        response.sendRedirect(request.getContextPath() + "/cart?action=view");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "view";
        }

        switch (action) {
            case "add":
                addToCart(request, response);
                break;

            case "remove":
                removeItem(request, response);
                break;

            case "update":
                updateQuantity(request, response);
                break;

            default:
                viewCart(request, response);
                break;
        }
    }

    private void viewCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = SessionUtil.getUser(request);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Cart cart = cartDao.getCartByUserId(user.getUserId());

        if (cart != null) {
            ArrayList<CartDetails> items = cartDetailsDao.getCartItems(cart.getCartId());

            double total = 0;
            Map<Integer, FoodItem> foodMap = new HashMap<>();

            for (CartDetails item : items) {
                FoodItem food = foodDao.findFoodById(item.getFoodId());

                if (food != null) {
                    total += food.getPrice() * item.getQuantity();
                    foodMap.put(item.getFoodId(), food);
                }
            }

            request.setAttribute("cartItems", items);
            request.setAttribute("foodMap", foodMap);
            request.setAttribute("total", total);
        }

        request.getRequestDispatcher("/WEB-INF/views/cart-view.jsp")
                .forward(request, response);
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        User user = SessionUtil.getUser(request);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int foodId = parseInt(request.getParameter("foodId"), 0);
        int quantity = parseInt(request.getParameter("quantity"), 1);

        if (foodId <= 0) {
            response.sendRedirect(request.getContextPath() + "/food");
            return;
        }

        if (quantity < 1) {
            quantity = 1;
        }

        Cart cart = cartDao.getCartByUserId(user.getUserId());

        if (cart == null) {
            Cart newCart = new Cart(user.getUserId());
            cartDao.createCart(newCart);
            cart = cartDao.getCartByUserId(user.getUserId());
        }

        if (cart != null) {
            CartDetails cartItem = new CartDetails(cart.getCartId(), foodId, quantity);
            cartDetailsDao.addToCart(cartItem);
        }

        response.sendRedirect(request.getContextPath() + "/cart?action=view");
    }

    private void removeItem(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        User user = SessionUtil.getUser(request);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Cart cart = cartDao.getCartByUserId(user.getUserId());
        int cartDetailId = parseInt(request.getParameter("cartDetailId"), 0);

        if (cart != null && cartDetailId > 0) {
            cartDetailsDao.removeItemFromCart(cartDetailId, cart.getCartId());
        }

        response.sendRedirect(request.getContextPath() + "/cart?action=view");
    }

    private void updateQuantity(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        User user = SessionUtil.getUser(request);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Cart cart = cartDao.getCartByUserId(user.getUserId());
        int cartDetailId = parseInt(request.getParameter("cartDetailId"), 0);
        int quantity = parseInt(request.getParameter("quantity"), 1);

        if (quantity < 1) {
            quantity = 1;
        }

        if (quantity > 99) {
            quantity = 99;
        }

        if (cart != null && cartDetailId > 0) {
            cartDetailsDao.updateQuantityForCart(cartDetailId, cart.getCartId(), quantity);
        }

        response.sendRedirect(request.getContextPath() + "/cart?action=view");
    }

    private int parseInt(String value, int defaultValue) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return defaultValue;
        }
    }
}