defineProperty("btnOn")
defineProperty("btnOff")
defineProperty("state")
components = {
    texture {
        image = btnOn,
        visible = function() return get(state); end,
    };
    texture {
        image = btnOff,
        visible = function() return not get(state); end,
    };
    clickable {
        cursor = {
            x = 8,
            y = 26,
            width = 16,
            height = 16,
            shape = loadImage("clickable.png"),
        },
    };
}
