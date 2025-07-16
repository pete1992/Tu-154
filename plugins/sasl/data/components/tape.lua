defineProperty("image")
defineProperty("window", { 1.0, 1.0 } )
defineProperty("scrollX", 0)
defineProperty("scrollY", 0)
function draw(self)
    local sz = get(window)
    drawTexturePart(get(image), 0, 0, 100, 100, 
        get(scrollX), get(scrollY), sz[1], sz[2]) 
end
