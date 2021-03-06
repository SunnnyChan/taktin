--[[
Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved

@File    : ReqParamsJudge.lua
@Author  : sunnnychan@gmail.com
@Date    : 2016/06/12
@Version : 1.0.0
@Brief   : 
]]--
local tonumber = tonumber
local setmetatable = setmetatable
local type = type
local Method = require('models.service.rule.JudgeMethods') 

local ReqParamsJudge = {}

function ReqParamsJudge:new(inputData, ruleType, ruleContent)
    local instance = {}
    instance.strReMatch = 8
    instance.inputData = inputData
    instance.ruleType = tonumber(ruleType)
    instance.ruleContent = ruleContent
    setmetatable(instance, {__index = self}) 
    return instance
end

--[[
    Req Params 维度的判断，首先要从Post数据中取出某个数据的值，作为判定的输入
]]--
function ReqParamsJudge:judge()
    if self.ruleType == self.strReMatch then 
        local pattern, model = self.ruleContent['re_pattern'], ''
        if (self.ruleContent['re_model']) then model = self.ruleContent['re_model'] end
        return Method.checkStrReMatch(self.inputData, pattern, model)
    else
        BDLOG.log_fatal('unsupported rule type by Uri judge. [rule type] : %s', self.ruleType)
        return false
    end
end

return ReqParamsJudge

-- vim: ts=4 sw=4 sts=4 tw=100 ft=lua 
