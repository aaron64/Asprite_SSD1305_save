local sprite = app.activeSprite
local filename = sprite.filename .. ".hxe"

-- Check constrains
if sprite == nil then
  app.alert("No Sprite...")
  return
end
if sprite.colorMode ~= ColorMode.GRAY then
  app.alert("Sprite needs to be grayscale")
  return
end

local dlg =
    Dialog()
    dlg:file{ id="filename",
        label="File",
        title="Export SSD1305 Hex",
        open=false,
        save=true,
        filetypes={"hex"}}
    :button{ id="ok", text="&OK", focus=true }
    :button{ id="cancel", text="&Cancel" }
dlg:show()
local data = dlg.data
if not data.ok then return end

filename = data.filename
file = io.open(filename, "wb")
if not file then
    app.alert("Failed to open the file to export.")
    return
end

width = sprite.width
height = sprite.height

-- image data
local fsprite = Sprite(sprite)
local fcel = sprite.cels[1]
local fimage = fcel.image
fsprite:flatten()

file:write(string.char(width))
file:write(string.char(height))

local zeroPadding = width-((width/8)*8)
local bytes = width/8;
for y = 0, fsprite.height - 1 do
    for b = 0, bytes - 1 do
        local byte = 0
        for x = 0, 7 do
            local px = app.pixelColor.grayaV(fimage:getPixel(x + b * 8, y))
            if px > 1 then
                px = 1
            else
                px = 0
            end
            
            byte = byte | (px << x)
            px = 0
        end
        file:write(string.char(byte))
    end
end
file:close()

app.alert("SSD1305 file saved as " .. filename)