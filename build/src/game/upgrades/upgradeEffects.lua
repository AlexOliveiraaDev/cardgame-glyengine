-- Lua Library inline imports
local __TS__StringSplit
do
    local sub = string.sub
    local find = string.find
    function __TS__StringSplit(source, separator, limit)
        if limit == nil then
            limit = 4294967295
        end
        if limit == 0 then
            return {}
        end
        local result = {}
        local resultIndex = 1
        if separator == nil or separator == "" then
            for i = 1, #source do
                result[resultIndex] = sub(source, i, i)
                resultIndex = resultIndex + 1
            end
        else
            local currentPos = 1
            while resultIndex <= limit do
                local startPos, endPos = find(source, separator, currentPos, true)
                if not startPos then
                    break
                end
                result[resultIndex] = sub(source, currentPos, startPos - 1)
                resultIndex = resultIndex + 1
                currentPos = endPos + 1
            end
            if resultIndex <= limit then
                result[resultIndex] = sub(source, currentPos)
            end
        end
        return result
    end
end
-- End of Lua Library inline imports
local ____exports = {}
function ____exports.applyComboNaipes(cardHistory, value)
    local cardType = __TS__StringSplit(cardHistory[1].id, "_")[1]
    local quant = 0
    do
        local i = 0
        while i < #cardHistory do
            local card = cardHistory[i + 1]
            if __TS__StringSplit(card.id, "_")[1] == cardType then
                quant = quant + 1
            end
            if i >= 3 then
                break
            end
            i = i + 1
        end
    end
    if quant >= 3 then
        return value * 3
    end
end
function ____exports.applyCartaMarcada()
end
return ____exports
