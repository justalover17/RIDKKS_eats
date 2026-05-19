package com.coursework.controller;

import com.coursework.utils.ImageUtil;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;

@WebServlet("/uploads/*")
public class ImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String fileName = request.getPathInfo();

        if (fileName == null || fileName.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        fileName = fileName.substring(1);

        String uploadPath = ImageUtil.getUploadPath();
        File file = new File(uploadPath, fileName);

        if (!file.exists() || !file.isFile()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        if (!file.getCanonicalPath().startsWith(new File(uploadPath).getCanonicalPath())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String contentType = Files.probeContentType(file.toPath());

        if (contentType != null) {
            response.setContentType(contentType);
        }

        response.setContentLengthLong(file.length());

        try (OutputStream out = response.getOutputStream()) {
            Files.copy(file.toPath(), out);
        }
    }
}