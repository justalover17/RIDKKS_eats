package com.coursework.controller;

import com.coursework.dao.CategoryDao;
import com.coursework.dao.CategoryDaoImpl;
import com.coursework.dao.FoodItemDao;
import com.coursework.dao.FoodItemDaoImpl;
import com.coursework.entity.Category;
import com.coursework.entity.FoodItem;
import com.coursework.entity.User;
import com.coursework.utils.ImageUtil;
import com.coursework.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/food")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class FoodServlet extends HttpServlet {

    private final FoodItemDao foodDao = new FoodItemDaoImpl();
    private final CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "view":
                viewFood(request, response);
                break;

            case "add":
                showAddForm(request, response);
                break;

            case "edit":
                showEditForm(request, response);
                break;

            case "delete":
                deleteFood(request, response);
                break;

            case "list":
            default:
                listFood(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("insert".equals(action)) {
            insertFood(request, response);
        } else if ("update".equals(action)) {
            updateFood(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/food");
        }
    }

    private void listFood(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String categoryParam = request.getParameter("category");
        String searchParam = request.getParameter("search");

        ArrayList<FoodItem> foods;

        if (searchParam != null && !searchParam.trim().isEmpty()) {
            foods = foodDao.searchFood(searchParam.trim());
        } else if (categoryParam != null && !categoryParam.trim().isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryParam);
                foods = foodDao.fetchFoodByCategory(categoryId);
            } catch (NumberFormatException e) {
                foods = foodDao.fetchAllFood();
            }
        } else {
            foods = foodDao.fetchAllFood();
        }

        request.setAttribute("foods", foods);

        request.getRequestDispatcher("/WEB-INF/views/food-list.jsp")
                .forward(request, response);
    }

    private void viewFood(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = parseInt(request.getParameter("id"), 0);

        if (id <= 0) {
            response.sendRedirect(request.getContextPath() + "/food");
            return;
        }

        FoodItem food = foodDao.findFoodById(id);
        request.setAttribute("food", food);

        request.getRequestDispatcher("/WEB-INF/views/food-view.jsp")
                .forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/food");
            return;
        }

        ArrayList<Category> categories = categoryDao.fetchAllCategories();
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("/WEB-INF/views/food-add.jsp")
                .forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/food");
            return;
        }

        int id = parseInt(request.getParameter("id"), 0);

        if (id <= 0) {
            response.sendRedirect(request.getContextPath() + "/food");
            return;
        }

        FoodItem food = foodDao.findFoodById(id);
        ArrayList<Category> categories = categoryDao.fetchAllCategories();

        request.setAttribute("food", food);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("/WEB-INF/views/food-edit.jsp")
                .forward(request, response);
    }

    private void insertFood(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/food");
            return;
        }

        String name = clean(request.getParameter("name"));
        String description = clean(request.getParameter("description"));
        double price = parseDouble(request.getParameter("price"), -1);
        int categoryId = parseInt(request.getParameter("categoryId"), 0);

        if (name.isEmpty() || price <= 0 || categoryId <= 0) {
            request.setAttribute("error", "Food name, valid price, and category are required.");
            request.setAttribute("categories", categoryDao.fetchAllCategories());
            request.getRequestDispatcher("/WEB-INF/views/food-add.jsp").forward(request, response);
            return;
        }

        Part imagePart = request.getPart("image");
        String imagePath = ImageUtil.uploadImage(imagePart);

        FoodItem food = new FoodItem(name, price, categoryId, description, imagePath);
        foodDao.insertFood(food);

        response.sendRedirect(request.getContextPath() + "/food");
    }

    private void updateFood(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/food");
            return;
        }

        int id = parseInt(request.getParameter("id"), 0);

        if (id <= 0) {
            response.sendRedirect(request.getContextPath() + "/food");
            return;
        }

        FoodItem existingFood = foodDao.findFoodById(id);

        if (existingFood == null) {
            response.sendRedirect(request.getContextPath() + "/food");
            return;
        }

        String name = clean(request.getParameter("name"));
        String description = clean(request.getParameter("description"));
        double price = parseDouble(request.getParameter("price"), -1);
        int categoryId = parseInt(request.getParameter("categoryId"), 0);

        if (name.isEmpty() || price <= 0 || categoryId <= 0) {
            request.setAttribute("error", "Food name, valid price, and category are required.");
            request.setAttribute("food", existingFood);
            request.setAttribute("categories", categoryDao.fetchAllCategories());
            request.getRequestDispatcher("/WEB-INF/views/food-edit.jsp").forward(request, response);
            return;
        }

        Part imagePart = request.getPart("image");
        String newImagePath = ImageUtil.uploadImage(imagePart);

        String finalImagePath;

        if (newImagePath != null) {
            ImageUtil.deleteImage(existingFood.getImagePath());
            finalImagePath = newImagePath;
        } else {
            finalImagePath = existingFood.getImagePath();
        }

        FoodItem food = new FoodItem(id, name, price, categoryId, description, finalImagePath, null, null);
        foodDao.updateFood(food);

        response.sendRedirect(request.getContextPath() + "/food");
    }

    private void deleteFood(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/food");
            return;
        }

        int id = parseInt(request.getParameter("id"), 0);

        if (id > 0) {
            FoodItem food = foodDao.findFoodById(id);

            if (food != null) {
                ImageUtil.deleteImage(food.getImagePath());
            }

            foodDao.deleteFood(id);
        }

        response.sendRedirect(request.getContextPath() + "/food");
    }

    private boolean isAdmin(HttpServletRequest request) {
        User user = SessionUtil.getUser(request);

        return user != null &&
                user.getRole() != null &&
                user.getRole().equalsIgnoreCase("admin");
    }

    private String clean(String value) {
        return value == null ? "" : value.trim();
    }

    private int parseInt(String value, int defaultValue) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return defaultValue;
        }
    }

    private double parseDouble(String value, double defaultValue) {
        try {
            return Double.parseDouble(value);
        } catch (Exception e) {
            return defaultValue;
        }
    }
}