-- coroutine 协同函数

co = coroutine.create( function ()
  return 9, 7
end)

print(coroutine.resume(co)) -- true 9 7

-- 数据由yield传给resume
co = coroutine.create( function (a, b) 
  coroutine.yield( a + b, a - b)
end)
print(coroutine.resume(co, 20, 10)) -- true 30 10

-- 管道
function receive (prod)
  local status, value = coroutine.resume(prod)
  return value
end

function send(x)
  coroutine.yield(x)
end

function producer()
  return coroutine.create( function ()
    while true do
      local x = io.read()
      send(x)
    end
  end)
end

function filter(prod)
  return coroutine.create( function ()
    local line = 1
    while true do
      local x = receive(prod)
      x = string.format( "%5d %s", line, x )
      send(x)
      line = line + 1
    end
  end)
end

function consumer(prod)
  while true do
    local x = receive(prod)
    io.write(x, "\n")
  end
end

local run = false

if run then
  p = producer()
  f = filter(p)
  consumer(f)
end
