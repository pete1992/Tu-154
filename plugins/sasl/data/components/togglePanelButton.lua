defineProperty("panel")
defineProperty("image")
components = {
    button {
        image = image;
        onMouseDown = function()
            local p = get(panel)
            set(p.visible, not get(p.visible))
            if get(p.visible) then
                movePanelToTop(p)
            end
            return true
        end;
    }
}
