-- 下载文件
local socket = require("socket")

-- 下载单个文件
function downloadOneThread()
  local host = "www.w3.org"
  local file = "/TR/2018/SPSD-html32-20180315/"
  local count = 0
  c = assert(socket.connect(host, 80))
  c:send("GET " .. file .. " HTTP/1.0\r\n\r\n")
  l, e = c:receive()
  while not e do
    count = count + string.len(l)
    io.write('\r', l) -- 打印获取到的文件内容
    io.write('\r', count) -- 打印获取到的文件大小
    l, e = c:receive()
  end
  print(e) -- 打印结束日志
  c:close()
end

-- 下载多个文件
function dowload(host, file)
  local count = 0 -- 计算下载的字节数
  local c = assert(socket.connect(host, 80))
  c:send("GET " .. file .. " HTTP/1.0\r\n\r\n")
  while true do
    local s, status = c:receive()
    if type(s) == "string" then
      count = count + string.len(s)
    end
    if status == "closed" then
      break
    end
  end
  c:close()
  -- io.write('\r', count)
  print(file, count)
end

function receive(connection)
  -- 调用函数timeout(0)使得对连接的任何操作都不会阻塞
  connection:timeout(0)
  local s, status = connection:receive(2^10)
  if status == "timeout" then
    coroutine.yield(connection)
  end
  return s, status
end

-- 线程保存函数
threads = {}
function get( host, file )
  -- 创建协同
  local co = coroutine.create( function ()
    dowload(host, file)
  end)
  -- 插入到列表中
  table.insert( threads, co )
end

-- 代码中table中为分配器保存了所有活动的线程
-- 分配器
-- 逐个调用每一个线程。并且从线程列表中移除已经完成任务的线程。当没有线程可以运行时退出循环。

function dispatcher()
  while true do
    local n = #threads
    if n == 0 then break end
    local connections = {} 
    for i = 1,n do
      local status, res = coroutine.resume(threads[i])
      if not res then
        table.remove( threads, i )
        break
      else
        table.insert( connections, res )
      end
    end
    if #connections == n then
      socket.select(connections)
    end
  end
end

-- 调用多线程函数
function downloadMoreThreads()
  local host = "www.w3c.org"
  get(host, "/TR/1999/REC-html401-19991224/html40.txt")
  get(host, "/TR/2002/REC-xhtml1-20020801/xhtml1.pdf")
  get(host, "/TR/2018/SPSD-html32-20180315/")
  get(host, "/TR/2000/REC-DOM-Level-2-Core-20001113/DOM2-Core.txt")
  dispatcher()
end

-- 运行单线程下载
-- downloadOneThread()

-- 运行多线程下载
downloadMoreThreads()
