function permgen(a, n)
  if n == 0 then
    -- printResult(a)
    -- 改造为 yield
    coroutine.yield(a)
  else
    for i=1,n do
      -- 交换位置
      a[n], a[i] = a[i], a[n]
      permgen(a, n - 1)
      -- 恢复原数组
      a[n], a[i] = a[i], a[n]
    end
  end
end

function printResult(a)
  for i,v in ipairs(a) do
    io.write(v, " ")
  end
  io.write("\n")
end
-- 未使用协同作用的调用方式
-- permgen ({1,2,3,4}, 4)

-- 使用协同作用的调用方式
-- 添加一个迭代工厂

function perm(a)
  local n = #a
  local co = coroutine.create(function ()
    permgen(a, n)
  end)
  return function ()
    local code, res = coroutine.resume(co)
    return res
  end
end

for p in perm{"a", "b", "c"} do
  printResult(p)
end
