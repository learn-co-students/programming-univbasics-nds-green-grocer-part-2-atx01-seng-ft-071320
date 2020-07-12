require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  cart.each do |foods|
    coupon_item = find_item_by_name_in_collection(foods[:item], coupons)
    if coupon_item   
      coupons.each do |coupon_hash|
        if foods[:item] == coupon_hash[:item] && foods[:count] >= coupon_hash[:num]
          applied_coupon = {
            item: "#{foods[:item]} W/COUPON",
            price: (coupon_hash[:cost] / coupon_hash[:num]),
            clearance: foods[:clearance],
            count: coupon_hash[:num]
          }
           cart.push(applied_coupon)
           foods[:count] -= coupon_hash[:num]
          end 
      end
    end 
  end 
  #binding.pry 
  return cart 
end

def apply_clearance(cart)
  cart.each do |items|
    if items[:clearance]
      items[:price] = (items[:price] * 0.8).round(2)
    end 
  end 
  cart  
end

def checkout(cart, coupons)
  total = 0 
  cons_cart = consolidate_cart(cart)
  coups_applied = apply_coupons(cons_cart, coupons)
  all_discounts = apply_clearance(coups_applied)
  all_discounts.each do |foods|
    total += foods[:price]*foods[:count] 
  end
  if total > 100
    total *= 0.9
  end 
  return total 
  #binding.pry 
end
