require 'pry'

def consolidate_cart(cart)
  result = {}
  cart.each do |item|
    itemName = item.keys.first
    if result[itemName]
      result[itemName][:count] += 1
    else
      result[itemName] = item.values.first
      result[itemName][:count] = 1
    end
  end
  result
end

def apply_coupons(cart, coupons)
  # cart is hash
  #coupons is array of hashes
  #must return hash
  coupons.each do |coupon|
    item = coupon[:item]
    if cart[item] && cart[item][:count] >= coupon[:num]
      if !cart["#{item} W/COUPON"]
        cart["#{item} W/COUPON"] = {
          price: (coupon[:cost] / coupon[:num].to_f),
          clearance: cart[item][:clearance],
          count: coupon[:num]
        }
      else
        cart["#{item} W/COUPON"][:count] += coupon[:num]
      end
      cart[item][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, item_hash|
    if item_hash[:clearance]
      item_hash[:price] = (item_hash[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  clearanced_cart = apply_clearance(couponed_cart)

  total = 0.0
  clearanced_cart.values.each do |item|
    total += item[:price] * item[:count]
  end
  total > 100.0 ? (total * 0.9) : total
end
