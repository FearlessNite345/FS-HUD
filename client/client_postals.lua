local postals = {}

function GetClosestPostal()
    local playerPos = GetEntityCoords(PlayerPedId())

    local closestPostal = nil
    local closestDistance = math.huge

    for _, postal in ipairs(postals) do
        local distance = #(playerPos - vector3(postal.x, postal.y, 0))
        if distance < closestDistance then
            closestPostal = postal
            closestDistance = distance
        end
    end

    if closestPostal ~= nil then
        return closestPostal.code
    else
        return ''
    end
end

function LoadPostals()
    local postalsJSON = LoadResourceFile(GetCurrentResourceName(), 'config/postals.json')
    postals = json.decode(postalsJSON)
end
