local mod = {}
local vector3 = {}
vector3.__index = vector3

-- locals

local floor = math.floor
local pi = math.pi
local mrandom = math.random
local sqrt = math.sqrt

local S = minetest and minetest.get_translator('vector3') or
              function(str) return str end

-- local funcs

-- local function isvector(v) return getmetatable(v) == vector3 end

local function isnumber(n) return type(n) == 'number' end

local function isnilornumber(n) return n == nil or type(n) == 'number' end

local function allnillornumber(...)
    local args = {...}
    for _, n in ipairs(args) do if not isnilornumber(n) then return false end end
    return true
end

local function isvector(v)
    return type(v) == 'table' and isnumber(v.x) and isnumber(v.y) and
               isnumber(v.z)
end
local function allvector(...)
    local args = {...}
    for _, v in ipairs(args) do if not isvector(v) then return false end end
    return true
end

local function sin(x)
    if x % math.pi == 0 then
        return 0
    else
        return math.sin(x)
    end
end

local function cos(x)
    if x % math.pi == math.pi / 2 then
        return 0
    else
        return math.cos(x)
    end
end

local function new(x, y, z)

    local v = {}

    if isvector(x) then
        v.x = x.x
        v.y = x.y
        v.z = x.z
    elseif allnillornumber(x, y, z) then
        v.x = x or 0
        v.y = y or 0
        v.z = z or 0
    else
        error(S('format error'))
    end

    return setmetatable(v, vector3)

end

local function fromSpherical(r, theta, phi)

    if allnillornumber(r, theta, phi) then
        --[[
            due to minetest system coordinate we need toadd pi/2 to phi
        ]] --
        local r = r or 1
        local theta = theta or pi / 2
        local phi = phi and (phi + pi / 2) or pi / 2

        local x = r * sin(phi) * sin(theta)
        local y = r * cos(theta)
        local z = -r * cos(phi) * sin(theta)

        return new(x, y, z)
    end

end

local function random(length)

    local length = isnumber(length) and length or 1
    local theta = mrandom() * pi
    local phi = mrandom() * 2 * pi

    return fromSpherical(length, theta, phi)

end

-- funcs

function vector3:clone() return new(self.x, self.y, self.z) end

function vector3:length()
    return sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
end

function vector3:norm()

    local l = self:length()
    if l == 0 then
        return new()
    else
        return self / l
    end

end

function vector3:floor() return new(floor(self.x), floor(self.y), floor(self.z)) end

function vector3:round()
    return new(floor(self.x + 0.5), floor(self.y + 0.5), floor(self.z + 0.5))
end

function vector3:apply(f)
    local x, y, z = f(self.x), f(self.y), f(self.z)
    if allnillornumber(x, y, z) then
        return new(x, y, z)
    else
        error(S('format error'))
    end
end

function vector3:set(x, y, z)
    if allnillornumber(x, y, z) then
        return new(x and x or self.x, y and y or self.y, z and z or self.z)
    else
        error(S('format error'))
    end
end

function vector3:offset(a, b, c)
    if allnillornumber(a, b, c) then
        return new(self.x + (a or 0), self.y + (b or 0), self.z + (c or 0))
    else
        error(S('format error'))
    end
end

function vector3:dot(b) return self.x * b.x + self.y * b.y + self.z * b.z end

function vector3:cross(b)
    return new(self.y * b.z - self.z * b.y, self.z * b.x - self.x * b.z,
               self.x * b.y - self.y * b.x)
end

function vector3:rotate_around(axis, angle)
    axis = axis:norm()
    return cos(angle) * self + (1 - cos(angle)) * (self:dot(axis)) * axis +
               sin(angle) * (self:cross(axis))
end

function vector3:dist(b)

    if isvector(b) then
        return sqrt((self.x - b.x) * (self.x - b.x) + (self.y - b.y) *
                        (self.y - b.y) + (self.z - b.z) * (self.z - b.z))
    else
        error(S('format error'))
    end
end

function vector3:scale(mag)
    if isnumber(mag) then
        local l = self:length()
        if l == 0 then
            return new()
        else
            return self * (mag / l)
        end
    else
        error(S('format error'))
    end
end

function vector3:limit(max)
    if isnumber(max) then
        local l = self:length()
        if l > max then
            return self:scale(max)
        else
            return self:clone()
        end
    else
        error(S('format error'))
    end
end

function vector3:unpack() return self.x, self.y, self.z end

-- meta

function vector3:__tostring()
    return string.format('(%.3g, %.3g, %.3g)', self.x, self.y, self.z)
end

function vector3.__concat(a, b)
    local s1 = isvector(a) and a:__tostring() or tostring(a)
    local s2 = isvector(b) and b:__tostring() or tostring(b)
    return s1 .. s2

end

function vector3:__unm() return new(-self.x, -self.y, -self.z) end

function vector3.__eq(a, b)
    if allvector(a, b) then
        return a.x == b.x and a.y == b.y and a.z == b.z
    else
        error(S('format error'))
    end
end

function vector3.__add(a, b)

    if isvector(a) then
        if isvector(b) then
            return new(a.x + b.x, a.y + b.y, a.z + b.z)
        elseif isnumber(b) then
            return new(a.x + b, a.y + b, a.z + b)
        end
    elseif isnumber(a) and isvector(b) then
        return new(a + b.x, a + b.y, a + b.z)
    else
        error(S('format error'))
    end

end

function vector3.__sub(a, b)

    if isvector(a) then
        if isvector(b) then
            return new(a.x - b.x, a.y - b.y, a.z - b.z)
        elseif isnumber(b) then
            return new(a.x - b, a.y - b, a.z - b)
        end
    elseif isnumber(a) and isvector(b) then
        return new(a - b.x, a - b.y, a - b.z)
    else
        error(S('format error'))
    end

end

function vector3.__mul(a, b)

    if isvector(a) then
        if isvector(b) then
            return new(a.x * b.x, a.y * b.y, a.z * b.z)
        elseif isnumber(b) then
            return new(a.x * b, a.y * b, a.z * b)
        end
    elseif isnumber(a) and isvector(b) then
        return new(a * b.x, a * b.y, a * b.z)
    else
        error(S('format error'))
    end

end

function vector3.__div(a, b)

    if isvector(a) then
        if isvector(b) then
            return new(a.x / b.x, a.y / b.y, a.z / b.z)
        elseif isnumber(b) then
            return new(a.x / b, a.y / b, a.z / b)
        end
    elseif isnumber(a) and isvector(b) then
        return new(a / b.x, a / b.y, a / b.z)
    else
        error(S('format error'))
    end

end

-- export

mod.fromSpherical = fromSpherical
mod.random = random

return setmetatable(mod, {__call = function(_, ...) return new(...) end})

