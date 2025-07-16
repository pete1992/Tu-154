defineProperty("image")
defineProperty("window", { 1.0, 1.0 } )
defineProperty("scrollX", 0)
defineProperty("scrollY", 0)
defineProperty("angle", 0)
function draw(self)
    local sz = get(window)
    drawRotatedTexturePart(get(image), get(angle), 0, 0, 100, 100, 
        get(scrollX), get(scrollY), sz[1], sz[2]) 
end
