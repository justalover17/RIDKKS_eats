package com.coursework.utils;

import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;

public class ImageUtil {

    private static final String UPLOAD_FOLDER = "ridkks-eats-uploads";

    public static String uploadImage(Part imagePart) {
        if (imagePart == null) {
            return null;
        }

        String fileName = imagePart.getSubmittedFileName();

        if (fileName == null || fileName.trim().isEmpty()) {
            return null;
        }

        int dotIndex = fileName.lastIndexOf(".");

        if (dotIndex == -1) {
            return null;
        }

        String extension = fileName.substring(dotIndex).toLowerCase();

        if (!extension.equals(".jpg") &&
                !extension.equals(".jpeg") &&
                !extension.equals(".png") &&
                !extension.equals(".webp")) {
            return null;
        }

        String cleanFileName = fileName.replaceAll("[^a-zA-Z0-9._-]", "_");
        String uniqueName = LocalDateTime.now()
                .toString()
                .replace(":", "-")
                .replace(".", "-") + "_" + cleanFileName;

        String uploadPath = System.getProperty("user.home") + File.separator + UPLOAD_FOLDER;
        File uploadDir = new File(uploadPath);

        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        try {
            imagePart.write(uploadPath + File.separator + uniqueName);
            return uniqueName;
        } catch (IOException e) {
            System.out.println("Error uploading image: " + e.getMessage());
            return null;
        }
    }

    public static void deleteImage(String imagePath) {
        if (imagePath == null || imagePath.trim().isEmpty()) {
            return;
        }

        String uploadPath = System.getProperty("user.home") + File.separator + UPLOAD_FOLDER;
        File file = new File(uploadPath, imagePath);

        try {
            if (!file.getCanonicalPath().startsWith(new File(uploadPath).getCanonicalPath())) {
                return;
            }

            if (file.exists() && file.isFile()) {
                file.delete();
            }

        } catch (IOException e) {
            System.out.println("Error deleting image: " + e.getMessage());
        }
    }

    public static String getUploadPath() {
        return System.getProperty("user.home") + File.separator + UPLOAD_FOLDER;
    }
}