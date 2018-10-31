-- 函数
-- 排序函数

-- 打印日志
function logger(arr)
  for k,v in pairs(arr) do
    print(k,v)
  end
end

names = {"Peter", "Paul", "Mary"}
grades = {Mary = 10, Paul = 7, Peter = 8}
table.sort(names, function (n1, n2)
  return grades[n1] > grades[n2]
end)

num = {12, 34, 5, 6, 23, 2}
table.sort(num, function ( a, b )
  return (a < b)
end )

logger(names);
print('-----------------------------------------')
logger(num);