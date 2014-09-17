require 'csv'
require 'time'

# This file is to require all of our dependencies (each of the classes we make)
require_relative 'far_mar/market'
require_relative 'far_mar/vendor'
require_relative 'far_mar/product'
require_relative 'far_mar/sale'

l = FarMar::Product.find_by_name_term("beef")
repeats = {}
l.each do |v|
  if !repeats.keys.include?(v.name)
    repeats[v.name] = 1
  else
    repeats[v.name] = "REPEAT!!!!"
  end
end

if repeats.values.include?("REPEAT!!!!")
  puts "THERE BE REPEATS!"
else
  puts "it's all good"
end

print repeats.keys.sort
