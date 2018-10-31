-- for 循环

-- 数值for循环
for i=1,10 do
  print(i)
end

-- 范型for循环
days = {
  "Sunday", "Monday", "Tuesday", 
  "Wednesday",     "Thursday", "Friday",
  "Saturday"
}

-- revDays = {
--   ["Sunday"] = 1,
--   ["Monday"] = 2,
--   ["Tuesday"] = 3,
--   ["Wednesday"] = 4,
--   ["Thursday"] = 5,
--   ["Friday"] = 6,
--   ["Saturday"] = 7
-- }

revDays = {}
for k,v in pairs(days) do
  revDays[v] = k
end
x = "Tuesday"
print(revDays[x])