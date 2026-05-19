package com.coursework.controller;

import com.coursework.dao.UserDao;
import com.coursework.dao.UserDaoImpl;
import com.coursework.entity.User;
import com.coursework.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/user")
public class UserServlet extends HttpServlet {

    private final UserDao userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User currentUser = SessionUtil.getUser(request);

        if (currentUser == null || !"admin".equalsIgnoreCase(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "edit":
                showEditForm(request, response);
                break;

            case "delete":
                deleteUser(request, response, currentUser);
                break;

            case "list":
            default:
                listUsers(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User currentUser = SessionUtil.getUser(request);

        if (currentUser == null || !"admin".equalsIgnoreCase(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if ("update".equals(action)) {
            updateUser(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/user?action=list");
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<User> users = userDao.fetchAllUsers();
        request.setAttribute("users", users);

        request.getRequestDispatcher("/WEB-INF/views/user-list.jsp")
                .forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = parseInt(request.getParameter("id"), 0);

        if (id <= 0) {
            response.sendRedirect(request.getContextPath() + "/user?action=list");
            return;
        }

        User user = userDao.findUserById(id);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/user?action=list");
            return;
        }

        request.setAttribute("user", user);

        request.getRequestDispatcher("/WEB-INF/views/user-edit.jsp")
                .forward(request, response);
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = parseInt(request.getParameter("id"), 0);
        String name = clean(request.getParameter("name"));
        String email = clean(request.getParameter("email"));
        String phone = clean(request.getParameter("phone"));
        String role = clean(request.getParameter("role"));

        if (id <= 0 || name.isEmpty() || email.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user?action=list");
            return;
        }

        if (!"admin".equalsIgnoreCase(role) && !"customer".equalsIgnoreCase(role)) {
            role = "customer";
        }

        User user = new User(id, name, email, null, phone, role.toLowerCase(), null, null);

        userDao.updateUserWithoutPassword(user);

        response.sendRedirect(request.getContextPath() + "/user?action=list");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws IOException {

        int id = parseInt(request.getParameter("id"), 0);

        if (id > 0 && id != currentUser.getUserId()) {
            userDao.deleteUser(id);
        }

        response.sendRedirect(request.getContextPath() + "/user?action=list");
    }

    private int parseInt(String value, int defaultValue) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return defaultValue;
        }
    }

    private String clean(String value) {
        return value == null ? "" : value.trim();
    }
}