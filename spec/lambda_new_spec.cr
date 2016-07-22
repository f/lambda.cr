require "./spec_helper"

λ def add(x, y) x + y end
λ def remove(x, y) x - y end
lambda def multiply(x, y) x * y end
lambda def divide(x, y) x / y end

lambda def otherwise(x) !x end

λ def world(x)
  x + "world"
end

λ def add(x, y, z)
  x + y + z
end

lambda def plus(x : Int32, y : Int32)
  x + y
end

lambda def plus(x : String, y : String)
  x + " and " + y
end

describe Lambda do
  it "works" do
    x = "hello".world
    y = world("hello")
    x.should eq(y)

    true.otherwise.should eq(false)
    true.otherwise.otherwise.should eq(true)

    (otherwise otherwise true).should eq(true)
  end

  it "works with types" do
    x = plus 2, 2
    y = 2.plus 2
    x.should eq(4)
    x.should eq(y)

    x = plus "fatih", "akin"
    y = "fatih".plus "akin"

    x.should eq("fatih and akin")
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
