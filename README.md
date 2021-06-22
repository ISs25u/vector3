vector3
=========================

![License](https://img.shields.io/badge/License-GPLv3-blue.svg)

**3D Vector library with meta functions**

**License:** GPLv3   

## Usage

1. Make your mod depends on `vector3` ;
2. Create vectors with `vector3(x, y, z)` ;
3. See available method below

## Constructors

#### vector3(x, y, z)
Creates a new vector with components `x`, `y` and `z`. Components defaults to zero.

*Example:*
```lua
v0 = vector3()
v1 = vector3(1,2,3)
```

#### vector3.fromSpherical(r, theta, phi)
Creates a new vector from spherical coordinates. `theta` is the polar angle (from the upwards `y` axis) and `phi` the azimut (counting clockwise around `y`, starting from `x`).

*Example:*
```lua
v = vector3.fromSpherical(10, math.pi / 2, math.pi)
```

#### vector3.random(length)
Creates a vector with a random direction and magnitude of `length` (defaults to 1).

*Example:*
```lua
v = vector3.random()
```


## Meta functions

#### print
Allows to print a vector.

*Example:*
```lua
v1 = vector3(4, 5, 6)
print(v1)
```

#### concatenation
Allows to create strings from vector concatenation.

*Example:*
```lua
v1 = vector3(1, 2, 3)
v2 = vector3(4, 5, 6)
v3 = vector3(7, 8, 9)
print(v1 .. v2 .. v3)
```

#### negative
Return the negative vector.

*Example:*
```lua
v1 = vector3(1, 2, 3)
print(-a)
```

#### equality
Return wether `a` and `b` components are equals

*Example:*
```lua
v1 = vector3(1, 2, 3)
v2 = vector3(1, 2, 3)
if a == b then print('a and b are equals') end
```

#### addition
Return the sum of `a` and `b` component wise. If `a` or `b` is a number then it adds the number to each component of the vector.

*Example:*
```lua
v1 = vector3(1, 2, 3)
v2 = vector3(3, 2, 1)
print(v1 + v2)
print(v1 + 10)
```

#### substraction
Return the difference of `a` and `b` component wise. If `a` or `b` is a number then it substracts the number to each component of the vector.

*Example:*
```lua
v1 = vector3(1, 2, 3)
v2 = vector3(1, 1, 1)
print(v1 - v2)
print(v1 - 1)
```

#### multiplication
Return the product of `a` and `b` component wise. If `a` or `b` is a number then it multiplies each component by this number.

*Example:*
```lua
v1 = vector3(1, 2, 3)
v2 = vector3(1, 2, 3)
print(v1 * v2)
print(v1 * 10)
```

#### division
Return the division of `a` and `b` component wise. If `a` or `b` is a number then it divides each component by this number.

*Example:*
```lua
v1 = vector3(10, 20, 30)
v2 = vector3(1, 2, 3)
print(v1 / v2)
print(v1 / 10)
```

## Functions

All functions except `set` create and returns __new vectors__ so that the original vector is not modified!

*Notation* `vector3.function_name.(self, params)` *is equivalent to* `v:function_name(params)`

#### vector3.set(self, x, y, z)
Sets the `x`,`y` and `z` components of the vector and return it. If a parameter is nil then the corresponding coponent is unchanged.

*Example:*
```lua
v = vector3(1, 2, 3)
v:set(4, nil, 7)
```

#### vector3.clone(self)
Return a new vector which is a copy of the initial vector.

*Example:*
```lua
v = vector3(1, 2, 3)
v2 = v:clone()
```

#### vector3.length(self)
Returns the magnitude of the vector.

*Example:*
```lua
v = vector3(1, 2, 3)
print(v:length())
```

#### vector3.norm(self)
Return the corresponding normalized vector (with magnitude one).

*Example:*
```lua
v = vector3(1, 2, 3)
print(v:norm():length() == 1)
```

#### vector3.scale(self, mag)
Return a new vector which is `self` scaled to magnitude `mag`

*Example:*
```lua
v1 = vector3(1, 2, 3)
print(v1:scale(10):length())
```

#### vector3.limit(max)
Returns a new vector wich is `self` scaled to magnitude `max` if its magnitude if greater than `max`.

*Example:*
```lua
v1 = vector3(10, 20, 30):limit(5)
v2 = vector3(1, 2, 3):limit(5)
print(v1:length())
print(v2:length())
```

#### vector3.floor(self)
Return a new vector with the components floored.

*Example:*
```lua
v = vector3(1.3, 2.2, 3.1)
print(v:floor())
```

#### vector3.round(self)
Return a new vector with the components rounded to the closest integer.

*Example:*
```lua
v = vector3(1.1, 2.4, 3.5)
print(v:round())
```

#### vector3.offset(a, b, c)
Return a new vector with offsets `x`, `y`, `z` by `a`, `b` and `c`.

*Example:*
```lua
v = vector3(1, 1, 1)
print(v.offset(-1, 3, 2))
```

#### vector3.apply(self, f)
Return a new vector with the function `f`applied to its components.

*Example:*
```lua
v = vector3(1, 2, 3)
print(v:apply(function(x) return x * x end))
```

#### vector3.dist(self, b)
Returns the distance between `self` and `b` (as if they were points).

*Example:*
```lua
v1 = vector3(3, 3, 3)
v2 = vector3(1, 1, 1)
print(v1:dist(v2))
```

#### vector3.dot(self, b)
Returns the dot product of `self` and `b`.

*Example:*
```lua
v1 = vector3(1, 3, 1)
v2 = vector3(-1, 1, 2)
print(v1:dot(v2))
```

#### vector3.cross(self, b)
Returns a vector which is the cross product of `self` and `b`.

*Example:*
```lua
v1 = vector3(1, 3, 1)
v2 = vector3(-1, 1, 2)
print(v1:cross(v2))
```

#### vector3.rotate_around(self, axis, angle)
Returns a new vector which is `self` rotated around `axis` with ``angle.

Returns the dot product of `self` and `b`.

*Example:*
```lua
v1 = vector3(-1, 1, 0)
axis = vector3(0, 1, 0)
print(v1:rotate_around(axis, math.pi))
```

#### vector3.unpack(self)
Returns the unpacked components of `self`

*Example:*
```lua
v1 = vector3(4, 5, 6)
x, y, z = v1:unpack()
print(x)
print(y)
print(z)
```
