
-- 定义一个辅助函数用来格式化文本的输出
function fwrite(fmt, ... )
  return io.write(string.format(fmt, unpack(arg)))
end

-- 定义一个BEGIN函数用来写html页面的头部
function BEGIN()
  io.write([[
    <html>
    <head>
      <title>Lua page</title>
    </head>
    <body background="#8bc34a">
      Here are brief descriptions of some projects around the
      world that use <a href="home.html">Lua</a>
  ]])
end

-- 定义entry函数

-- a. 将每个工程以列表方式写出

function entry0(o)
  N = N + 1
  local title = o.title or '(no title)'
  fwrite('<li><a href="#%d">%s</a>\n', N, title)
end
