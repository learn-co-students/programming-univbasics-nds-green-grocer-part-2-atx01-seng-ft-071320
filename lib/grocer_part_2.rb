require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  
  coupons.each do |coupon|
    item = find_item_by_name_in_collection(coupon[:item], cart)
    
    couponed_item_name = coupon[:item] + " W/COUPON"
    couponed_item_cost = coupon[:cost]/coupon[:num]
    couponed_item_clearance = item[:clearance]
    couponed_item_count = coupon[:num]
    
    if item != nil
      if item[:count] >= coupon[:num]
        item[:count] -= coupon[:num]
        cart << {:item => couponed_item_name, :price => couponed_item_cost, :clearance => couponed_item_clearance, :count => couponed_item_count}
      end
    end
  end
 cart
end

def apply_clearance(cart)
  cart.each do |item|
    if item[:clearance] == true
      item[:price] = item[:price]*0.8
    end
  end
end

def checkout(cart, coupons)
  
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  clearanced_cart = apply_clearance(couponed_cart)
  
  total_price = 0 
  
  clearanced_cart.each do |item|
    total_item_cost = item[:price]*item[:count]
    total_price += total_item_cost
  end
  
  if total_price > 100
    total_price = total_price*0.9
  end
  
  total_price.round(2)
  
end

