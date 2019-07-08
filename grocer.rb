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
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
