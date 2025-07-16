defineProperty("lightOn")
defineProperty("lightOff")
defineProperty("state")
components = {
    textureLit {
        image = lightOn,
        visible = function() return toboolean(get(state)); end;
    };
    textureLit {
        image = lightOff,
        visible = function() return not toboolean(get(state)); end,
    };
}
