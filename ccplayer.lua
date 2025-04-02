term.clear()
term.setCursorPos(2,2)
term.blit("[X]","8e8","fff")
term.setCursorPos(2,4)
term.blit("[O]","8e8","fff")
term.setCursorPos(1,6)
local aud = io.read()
local looped = false

local function throbber()
  local chars = {"|", "/", "-", "\\"}
  local c_idx = 0
  while true do
    sleep(0.25)
    term.clear()
    term.setCursorPos(3, 2)
    term.blit(chars[c_idx + 1], "d", "f")
    c_idx = (c_idx + 1) % 4
    if looped == false then
      term.setCursorPos(2,4)
      term.blit("[O]","8e8","fff")
    elseif looped == true then
      term.setCursorPos(2,4)
      term.blit("[O]","8d8","fff")
    end
  end
end

local function playaud()
  shell.run("speaker play "..aud)
  if looped == true then
    repeat
      shell.run("speaker play "..aud)
    until looped == false
  end
end

local function detect()
  while true do
    sleep(0.005)
    local event, button, x, y = os.pullEvent("mouse_click")
    if x == 3 and y == 4 then
      if looped == false then
        looped = true
        term.setCursorPos(3,4)
        term.blit("O","d","f")
      elseif looped == true then
        looped = false
        term.setCursorPos(3,4)
        term.blit("O","e","f")
      end
    end
  end
end

parallel.waitForAny(detect,playaud,throbber)
