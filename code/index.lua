-- 函数
-- 记忆函数
function room1()
  local move = io.read();
  print("[msg]:进入 1 号房间")
  if move == "s" then
    return room3();
  elseif move == "e" then
    return room2();
  else
    print("[no.1]:无效的移动")
    return room1()
  end
end

function room2()
  local move = io.read();
  print("[msg]:进入 2 号房间")
  if move == "s" then
    return room4();
  elseif move == "w" then
    return room1();
  else
    print("[no.2]:无效的移动")
    return room2()
  end
end

function room3()
  local move = io.read();
  print("[msg]:进入 3 号房间")
  if move == "n" then
    return room1();
  elseif move == "e" then
    return room4();
  else
    print("[no.3]:无效的移动")
    return room3()
  end
end

function room4()
  print("[no.4]:到达终点")
end

room1()