size = {30, 120}
defineProperty("value", {0}) 
defineProperty("minimum", 0) 
defineProperty("maximum", 1) 
defineProperty("lever_count", 1)  
defineProperty("back_img") 
defineProperty("lever_img") 
local Min = get(minimum)
local Max = get(maximum)
local Range = Max - Min  
local Count = get(lever_count)
local mouse_stat = false
local was_click = false  
local v = get(value)
local inverse = false
inverse = Max < Min
components = {
    free_texture {
        image = get(lever_img),
        position_x = 0,
        position_y = function()
             local a = (get(v[1]) - Min) * 90 / Range
             if a > 90 then a = 90 end
             if a < 0 then a = 0 end
             return a - 10   
        end,
        width = 30,
        height = 30, 
    },
    clickable {
       position = { 5, 0, 20, 100 },
       cursor = { 
            x = 0, 
            y = 0, 
            width = 16, 
            height = 16, 
            shape = loadImage("clickable.png")
        },  
        onMouseClick = function(comp, x, y, button)
           mouse_stat = true
           if y < 0 then y = 0 elseif y > 100 then y = 100 end
		   local val = y / 100 * Range + Min
		   if mouse_stat and not was_click then 
              for i = 1, Count, 1 do  
                  set(v[i], val)
              end
           end
           was_click = true  
           return true
        end,
        onMouseUp = function(comp, x, y, button)
           mouse_stat = false
           was_click = false
           return true
        end,
        onMouseMove = function(comp, x, y, button) 
           if y < 0 then y = 0 elseif y > 100 then y = 100 end
		   local val = y / 100 * Range + Min
		   if mouse_stat then 
              for i = 1, Count, 1 do  
                  set(v[i], val)
              end
           end
           return true 
        end,
    },
}
