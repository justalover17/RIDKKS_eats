package com.coursework.entity;

import java.sql.Timestamp;

public class FoodItem {

    private int foodId;
    private String name;
    private double price;
    private int categoryId;
    private String description;
    private String imagePath;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public FoodItem(String name, double price, int categoryId) {
        this.name = name;
        this.price = price;
        this.categoryId = categoryId;
    }

    public FoodItem(String name, double price, int categoryId, String description, String imagePath) {
        this.name = name;
        this.price = price;
        this.categoryId = categoryId;
        this.description = description;
        this.imagePath = imagePath;
    }

    public FoodItem(int foodId, String name, double price, int categoryId, String description,
                    String imagePath, Timestamp createdAt, Timestamp updatedAt) {
        this.foodId = foodId;
        this.name = name;
        this.price = price;
        this.categoryId = categoryId;
        this.description = description;
        this.imagePath = imagePath;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public FoodItem(int foodId, String name, double price, int categoryId, String description,
                    Timestamp createdAt, Timestamp updatedAt) {
        this.foodId = foodId;
        this.name = name;
        this.price = price;
        this.categoryId = categoryId;
        this.description = description;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getFoodId() {
        return foodId;
    }

    public void setFoodId(int foodId) {
        this.foodId = foodId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
}