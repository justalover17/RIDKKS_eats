package com.coursework.dao;

import com.coursework.entity.CartDetails;
import java.util.ArrayList;

public interface CartDetailsDao {
    boolean addToCart(CartDetails cartDetails);
    ArrayList<CartDetails> getCartItems(int cartId);
    boolean updateQuantity(CartDetails cartDetails);
    boolean updateQuantityForCart(int cartDetailId, int cartId, int quantity);
    boolean removeItem(int cartDetailId);
    boolean removeItemFromCart(int cartDetailId, int cartId);
}