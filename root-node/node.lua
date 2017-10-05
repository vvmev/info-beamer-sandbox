gl.setup(1920, 1080)

font = resource.load_font("silkscreen.ttf")

function node.render()
  gl.clear(0, 1, 0, 1) -- green
  font:write(120, 320, "Hello World bla", 100, 1,1,1,1)
end
