package com.coursework.dao;

import com.coursework.entity.FoodItem;
import java.util.ArrayList;

public interface FoodItemDao {
    boolean insertFood(FoodItem food);
    ArrayList<FoodItem> fetchAllFood();
    ArrayList<FoodItem> fetchFoodByCategory(int categoryId);
    ArrayList<FoodItem> searchFood(String query);
    FoodItem findFoodById(int id);
    boolean updateFood(FoodItem food);
    boolean deleteFood(int id);
}