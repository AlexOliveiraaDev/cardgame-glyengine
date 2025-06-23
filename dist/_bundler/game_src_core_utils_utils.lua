local ____exports = {}
local dt
local time = 0
function ____exports.delayTick(delta)
    dt = delta / 1000
end
function ____exports.wait(waitTime)
    if time <= waitTime then
        time = time + dt
    else
        time = 0
        return
    end
end
return ____exports
