require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  grocery_item = {}
  coupons.each do |coupon|
    new_item = find_item_by_name_in_collection(coupon[:item], cart)
    grocery_item[:item] = "#{new_item[:item]} W/COUPON" 
    price = coupon[:cost]/ coupon[:num]
    grocery_item[:price] = price 
    grocery_item[:clearance] = new_item[:clearance]
    if new_item[:count] >= coupon[:num]
      grocery_item[:count] = coupon[:num]
      cart.push(grocery_item)
    end 
    grocery_item = {}
      cart.each do |hash|
        if hash[:item] == coupon[:item] && hash[:count] >= coupon[:num]
          hash[:count] = hash[:count] - coupon[:num]
        end 
      end 
  end
  cart
end


def apply_clearance(cart)
  cart.each do |item|
    if item[:clearance] == true 
      item[:price] = item[:price] * 0.8 
    end 
  end 
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  new_cart = apply_coupons(new_cart, coupons)
  apply_clearance(new_cart)
  total = 0.00
  new_cart.each do |item|
    total = total + (item[:price] * item[:count])
  end 
  if total > 100
    total *= 0.9
  end 
  total.round(2)
end 
  
