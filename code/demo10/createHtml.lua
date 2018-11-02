-- 定义一个辅助函数用来格式化文本的输出
function fwrite(fmt, ... )
  local arg = { ... }
  return io.write(string.format(fmt, table.unpack(arg)))
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

-- b. 写出工程所有的相关信息
function entry1(o)
  N = N + 1
  local title = o.title or o.org or 'org'
  fwrite('<hr>\n<h3>\n')
  local href = ''
  if o.url then
    href = string.format( ' href= "%s"', o.url )
  end
  fwrite('<a name="%d" %s>%s</a>', N, href, title)
  if o.title and o.org then
    fwrite('\n<small><em>%s</em></small>', o.org)
  end
  fwrite('\n<h3>\n')
  if o.description then
    fwrite('%s', string.gsub(o.description,'\n\n\n*', '<p>\n'))
    fwrite('<p>\n')
  end
  if o.email then
    fwrite('contack: <a href="mailto:%s">%s</a>\n', o.email, o.contact or o.email)
  elseif o.contact then
    fwrite('contack: %s\n', o.contact)
  end
end

-- 结尾函数
function END()
  fwrite('</body></html>\n')
end
