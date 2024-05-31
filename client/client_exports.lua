exports('getAOP', function()
    return AOP
end)

exports('getPeacetime', function()
    return Peacetime
end)

exports('showHud', function()
    HudVisible = true
end)

exports('hideHud', function()
    HudVisible = false
end)

exports('isHudHidden', function()
    return not HudVisible
end)
