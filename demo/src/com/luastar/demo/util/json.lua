--[[
	接口输出通用json格式
--]]
local _M = {}

function _M.success(data, needFormat)
	local body = data or {}
	local rs = {
		head = {
			status = 1,
			msg = "ok.",
			request_id = ngx.ctx.request_id,
			timestamp = ngx.time()
		},
		body = body
	}
	if needFormat then
		return string.gsub(cjson.encode(rs), "{}", "[]")
	end
	return cjson.encode(rs)
end

function _M.illegal_argument(msg)
	local rs = {
		head = {
			status = 2,
			msg = msg or "参数错误。",
			request_id = ngx.ctx.request_id,
			timestamp = ngx.time()
		}
	}
	return cjson.encode(rs)
end

function _M.exp(msg)
	local rs = {
		head = {
			status = 3,
			msg = msg or "系统异常。",
			request_id = ngx.ctx.request_id,
			timestamp = ngx.time()
		}
	}
	return cjson.encode(rs)
end

function _M.fail(msg)
	local rs = {
		head = {
			status = 4,
			msg = msg or "处理失败。",
			request_id = ngx.ctx.request_id,
			timestamp = ngx.time()
		}
	}
	return cjson.encode(rs)
end

function _M.illegal_token(msg)
	local rs = {
		head = {
			status = 5,
			msg = msg or "登录超时。",
			request_id = ngx.ctx.request_id,
			timestamp = ngx.time()
		}
	}
	return cjson.encode(rs)
end

function _M.jsonp(callback, json)
	if _.isEmpty(callback) then
		return json
	end
	return table.concat({ callback, "(", json, ")" }, "")
end

return _M


