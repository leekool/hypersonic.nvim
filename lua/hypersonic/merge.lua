--[[

FIXME
    -> insert_exlp, if it ends with or still insert, everytime

    -> ab|x
        => ab|x Match either
            => 1) "ab"
            => 2) "x"

        {
            "ab|x",
            "Match either",
            {
                "ab",
                "x"
            }
        }

        +--------------------------+
        | "ab|x"                   |
        |    Match either          |
        |       1) "ab"            |
        |       2) "x"             |
        +--------------------------+

-- ]]
local E = require('explain')
local U = require('utils')
local S = require('split')
local T = require('tables')
local M = {}

---@param tbl table
---@param merged table
---@return table
M.merge = function(tbl, merged)
    local temp = { '', '', {} }

    -- add title
    merged = { tbl[1] }

    for idx = 2, #tbl do
        local v = tbl[idx]
        -- local is_temp_normal = U.starts_with(temp[2], 'Match ') and U.ends_with(temp[2], tmep[1])
        local is_temp_normal = type(v[1]) ~= "table"

        if is_temp_normal then
            local is_char_escaped = U.starts_with(v[1], '\\')
            local is_char_normal = U.starts_with(v[2], 'Match ' .. v[1])

            if temp[3][1] == nil then
                if is_char_escaped then
                    local removed_temp = string.gsub(temp[2], 'Match ', '')
                    local removed_v = string.gsub(v[2], 'Match ', '')

                    table.insert(temp[3], removed_temp)
                    table.insert(temp[3], removed_v)

                    temp[2] = 'Match'
                end

                if is_char_normal then
                    temp[2] = temp[2] .. v[1]
                end


                if v[2] == 'or' then
                    local removed_temp = string.gsub(temp[2], 'Match ', '')

                    table.insert(temp[3], removed_temp)
                    table.insert(temp[3], '')

                    temp[2] = 'Match either'
                end
            end

            if temp[3][1] ~= nil then
                -- TODO
            end
        end
        temp[1] = temp[1] .. v[1]
    end

    table.insert(merged, temp)

    U.print_table(merged, 0)
    return merged
end

-- local idx = 10
local idx = 8
local split_tbl = S.split(T.test_inputs[idx])
local expl_tbl = E.explain(split_tbl, {})

M.merge(expl_tbl, {})
return M
