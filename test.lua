function math.hypot(x, y)
        local t
        x = math.abs(x)
        y = math.abs(y)
        t = math.min(x, y)
        x = math.max(x, y)
        if x == 0 then return 0 end
        t = t / x
        return x * math.sqrt(1 + t * t)
end

function mag1(a,b,c) return math.sqrt(a*a + b*b + c*c) end
function mag2(a,b,c) return math.hypot(a, math.hypot(b,c)) end

N = 1e5

t1 = os.time()
for i = 1,N do
  h = mag1(1,3,5)
  k = mag1(1,-3,5)
  l = mag1(1,0,5)
end
t2 = os.time()

t3 = os.time()
for i = 1,N do
  h = mag2(1,3,5)
  k = mag2(1,-3,5)
  l = mag2(1,0,5)
end
t4 = os.time()

T1 = t2 - t1
T2 = t4 - t3

print(T1)
print(T2)

--------------------------------------------------------------------------------

for i = 1, 1000 do
  a = math.random(-10,10) 
  b = math.random(-10,10)
  c = math.random(-10,10)
  m1 = mag1(a,b,c)
  m2 = mag2(a,b,c)
  d = math.abs(m1-m2)
  if d ~= 0 then
    print(math.abs(m1-m2))
  end
end
