-- 表的的构造

days = {"Sunday", "Monday", "Tuesday", "Wednesday",     "Thursday", "Friday", "Saturday"}
print(days[4])

polyline = {
  color = "blue",
  thickness = 2,
  npoints = 4,
  {
    x = 0, y = 0,
  },
  {
    x = 10, y = 0,
  },
  {
    x = -10, y = 10,
  },
};

print(polyline.color)
print(polyline[2].x)