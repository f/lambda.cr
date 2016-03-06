# UFCS.cr
DLang's [Uniform Function Call Syntax (UFCS)][1] port to Crystal Language

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  ufcs:
    github: f/ufcs.cr
```

## Overview

A free function can be called with a syntax that looks as if the function were a member function of its first parameter type.

Idea is simple, result is awesome.
```crystal
# With UFCS, you can call this function ...
my_function first_param, second_param, other_param

# ... like this.
first_param.my_function x, y, z
```

## Usage

```crystal
require "ufcs"
```

Just use `udef_struct` or `udef_class` to make the thing uniform.

```crystal
udef_struct add, Int32 do |x|
  this + x
end

result = add(2, 3) #=> 5
result = 2.add(3) #=> 5
```

## Chaining

Since you patch the struct or class you can chain easily.

```crystal
result = add(2, 3).add(4).add(5) #=> 2 + 3 + 4 + 5 = 14
```

## Examples

```crystal
udef_struct add, Int32 {|x| this + x}
udef_struct remove, Int32 {|x| this - x}
udef_struct multiply, Int32 {|x| this * x}
udef_struct divide, Int32 {|x| this / x}

2.add(3).multiply(6).divide(2).remove(3).add(5).divide(5) #=> 3,  It's ((((2 + 3) * 6) / 2) - 3 + 5) / 5
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
