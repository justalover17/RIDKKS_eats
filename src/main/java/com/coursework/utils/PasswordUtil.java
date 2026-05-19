package com.coursework.utils;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    public static String hashPassword(String password) {
        if (password == null) {
            password = "";
        }

        return BCrypt.hashpw(password, BCrypt.gensalt());
    }

    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }

        if (!isBCryptHash(hashedPassword)) {
            return false;
        }

        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    public static boolean isBCryptHash(String hashedPassword) {
        return hashedPassword != null &&
                (hashedPassword.startsWith("$2a$") ||
                        hashedPassword.startsWith("$2b$") ||
                        hashedPassword.startsWith("$2y$"));
    }
}