# λ.cr

Lambda makes your Crystal functions [uniformed][1].

> ⚠️
> **It's an experiment and we do *not* recommend using it.**
> It monkey patches `Object` so may cause problems using it. But it's a good example what you can do with macros.
> ⚠️

```crystal
# Lambda your expression.
λ def add(x, y)
  x + y
end

# Use it like a method or a function
puts 2.add 3
puts add 2, 3
```

Or more expressive example:

```crystal
# just define a lambda
lambda def not(x) !x end

# ... and use as you wish
true.not #=> false
true.not.not #=> true
false.not #=> true

not false #=> true
not not true #=> true
not true #=> false
```

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  lambda:
    github: f/lambda.cr
```

## Overview

A free function can be called with a syntax that looks as if the function were a member function of its first parameter type.

Idea is simple, result is awesome.
```crystal
# With lambda, you can call this function ...
my_function first_param, second_param, other_param

# ... like this.
first_param.my_function x, y, z
```

## Usage

```crystal
require "lambda"
```

Just use `λ` to make the function uniform.

```crystal
λ def add(x, y)
  x + y
end

result = add(2, 3) #=> 5
result = 2.add(3) #=> 5
```

## Chaining

Since you patch the struct or class you can chain easily.

```crystal
result = add(2, 3).add(4).add(5) #=> 2 + 3 + 4 + 5 = 14
```

## Types and Lambda Overloading

You can define type restrictions using the usual syntax.

```crystal
λ def plus(x : Int32, y : Int32)
  x + y
end

λ def plus(first : String, second : String)
  first + " and " + second
end

2.plus 2 #=> 4
"fatih".plus "akin" #=> "fatih and akin"

plus 2, 2 #=> 4
plus "fatih", "akin" #=> "fatih and akin"
```

## Block syntax

You can also define lambdas using blocks.

```crystal
λ add do |x, y|
  x + y
end
puts 2.add 3 #=> 5
puts add 2, 3 #=> 5
```

You can define types in parameters using `param_as_Type` pattern.

```crystal
λ plus do |x_as_Int32, y_as_Int32|
  x + y
end

λ plus do |first_as_String, second_as_String|
  first + " and " + second
end

2.plus 2 #=> 4
"fatih".plus "akin" #=> "fatih and akin"

plus 2, 2 #=> 4
plus "fatih", "akin" #=> "fatih and akin"
```

## Examples

```crystal
λ add {|x, y| x + y}
λ remove {|x| x - y}
λ multiply {|x, y| x * y}
λ divide {|x| x / y}

2.add(3).multiply(6).divide(2).remove(3).add(5).divide(5) #=> 3,  It's ((((2 + 3) * 6) / 2) - 3 + 5) / 5
```

## WTF is `λ`?!

It's the [lambda](https://en.wikipedia.org/wiki/Lambda) character. If you don't want to use it, you can simply use `lambda` alias.

```crystal
lambda add do |x, y|
  x + y
end

result = add(2, 3) #=> 5
result = 2.add(3) #=> 5
```

## Contributing

1. Fork it ( https://github.com/f/ufcs.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [[f]](https://github.com/f) Fatih Kadir Akın - creator, maintainer

[1]: http://dlang.org/function.html#pseudo-member
