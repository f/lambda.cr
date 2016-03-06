require "./spec_helper"

udef_class world, String do
  this + "world"
end

udef_struct add, Int32 do |x, y|
  this + x + y
end

udef_struct add, Float64 do |x| this + x end
udef_struct remove, Float64 do |x| this - x end
udef_struct multiply, Float64 do |x| this * x end
udef_struct divide, Float64 do |x| this / x end

describe Ufcs do
  it "works" do
    x = "hello".world
    y = world("hello")
    x.should eq(y)
  end

  it "works with multiple params" do
    x = 2.add(3, 4)
    y = add(2, 3, 4)
    x.should eq(9)
    x.should eq(y)
  end

  it "chains" do
    x = 2.0.add(3).multiply(6).divide(2).remove(3).add(5).divide(5)
    x.should eq(3.4)
  end
end
