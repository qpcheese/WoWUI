local MAJ, REV, _GG, _, T = 1, 34, _G, ...
if T.SkipLocalActionBook then return end
if T.TenEnv then T.TenEnv() end
local RW, EV, AB, KR = {}, T.Evie, T.ActionBook:compatible(2,36), T.ActionBook:compatible("Kindred", 1,22)
assert(EV and AB and KR and 1, "Incompatible library bundle")
local COMPAT = select(4,GetBuildInfo())
local MODERN, PYROLYSIS = COMPAT > 10e4, COMPAT >= 11e4

local function assert(condition, err, ...)
	return condition or error(tostring(err):format(...), 3)((0)[0])
end
local safequote do
	local r = {u="\\117", ["{"]="\\123", ["}"]="\\125"}
	function safequote(s)
		return (("%q"):format(s):gsub("[{}u]", r))
	end
end
local forall do
	local function r(n, f, a, ...)
		if n > 0 then
			return f(a), r(n-1, f, ...)
		end
	end
	function forall(f, ...)
		return r(select("#", ...), f, ...)
	end
end
local rtnext = rtable.next

local Spell_CheckCastable = {}

local namedMacros, namedMacroText, namedMacroTextOwnerPriority, coreNamedMacroText = {}, {}, {}
local coreExecCleanup = {}
local core, coreEnv = CreateFrame("Frame", nil, nil, "SecureHandlerBaseTemplate") do
	local bni = 1
	for i=1,9 do
		local bn repeat
			bn, bni = "RW!" .. bni, bni + 1
		until GetClickFrame(bn) == nil
		local bw = CreateFrame("Button", bn, core, "SecureActionButtonTemplate")
		bw:SetAttribute("pressAndHoldAction", 1)
		core:WrapScript(bw, "OnClick",
		[=[-- Rewire:OnClick_Pre 
			if ns == 0 then return false end
			idle[self], numIdle, numActive, ns = nil, numIdle - 1, numActive + 1, ns - 1
			self:SetAttribute("macrotext", owner:RunAttribute("RunMacro", nil))
			return nil, 1
		]=], [=[-- Rewire:OnClick_Post 
			idle[self], numIdle, numActive = 1, numIdle + 1, numActive - 1
			if ns == 0 and #execQueue > 0 then
				owner:CallMethod("throw", "Rewire executor pool exhausted; spilling queue (n=" .. #execQueue .. ").")
				wipe(execQueue)
				overfull, mutedAbove, modLock = false, -1, mutedAbove >= 0 and owner:CallMethod("setMute", false), nil
			end
		]=])
	end
	core:SetFrameRef("Kindred", KR:seclib())
	core:SetFrameRef("ActionBook", AB:seclib())
	core:SetAttribute("execPending", 0)
	if PYROLYSIS then
		local toAlphabetString do
			local a = {}
			for c in ("焼払解次善策氷雨"):gmatch("%S[\128-\191]*") do
				a[#a+1] = c
			end
			function toAlphabetString(v)
				local s, n, r = "", #a repeat
					r = v % n
					s, v = s .. a[1+r], (v-r) / n
				until v < 1
				return s
			end
		end
		local slashKey, slashCommand do
			local sb, si = "REWIRE_ICE_", 1
			repeat
				slashKey, si = sb .. si .. "X", si + 1
			until SlashCmdList[slashKey] == nil
			local slash = {}
			for k, v in pairs(_GG) do
				if type(k) == "string" and k:match("^SLASH_") then
					slash[v] = k
				end
			end
			si = 0 repeat
				slashCommand, si = "/" .. toAlphabetString(si), si + 1
			until slash[slashCommand] == nil
		end
		_GG["SLASH_" .. slashKey .. "1"] = slashCommand
		local si, psabName = 0 repeat
			psabName, si = toAlphabetString(si), si + 1
		until GetClickFrame(psabName) == nil
		local psab = CreateFrame("Button", psabName, nil, "SecureActionButtonTemplate")
		psab:SetAttribute("pressAndHoldAction", 1)
		core:WrapScript(psab, "OnClick", [=[-- Rewire:PSAB_OnClick_PreWrap 
			local idx, sqi = PY and PY.pendingResolve and (PY.runSIndex or 1)
			if not (idx and (PY.nextSIndex or 0) > idx) then return false end
			PY.runSIndex, sqi = idx + 1, PY.qS[idx]
			self:SetAttribute("type", "spell")
			self:SetAttribute("typerelease", "spell")
			self:SetAttribute("spell", sqi[2])
			self:SetAttribute("unit", sqi[3])
		]=])
		core:SetAttribute("PY", true)
		core:SetAttribute("PYs", "/click " .. psabName)
		core:SetAttribute("PYi", slashCommand)
		core:SetAttribute("OnNotifyPostUse", [=[-- Rewire:OnNotifyPostUse 
			if PY and PY.pendingResolve and PY.pendingResolve == ... then
				PY.pendingResolve = nil
				owner:CallMethod("quietCleanup")
			end
		]=])
		core:Execute([=[-- Rewire_PyrolysisInit 
			PY, PYtokens = newtable(), newtable()
			PY.qI, PY.qS, PY.id = newtable(), newtable(), 2^16 + math.random(2^16)
			PY.execI, PY.execS = self:GetAttribute("PYi"), self:GetAttribute("PYs")
			PY.execIL, PY.execSL = #PY.execI:gsub("[\128-\191]+", ""), #PY.execS:gsub("[\128-\191]+", "")
			PYtokens.nounshift, PYtokens.unshift_restore = newtable("#nounshift"), newtable("#nounshift-restore")
			PYtokens.unmute, PYtokens.mute = newtable("#mute"), newtable("#unmute")
			self:SetAttribute("PYs", nil)
			self:SetAttribute("PYi", nil)
			PY_EnqRun = [==[-- Rewire_PY_EnqRun 
				local mt, tok = ...
				mt = mt or PYtokens[tok]
				if not (mt and PY.nextOIndex) then return false end
				local oi, ii, ei, lim, sz = PY.nextOIndex, PY.nextIIndex, PY.execI, PY.cFree
				sz = PY.execIL + (oi > 1 and 1 or 0)
				if oi > 1 and ii > 1 and PY[oi-1] == ei then
					ii = ii - 1
				else
					PY[oi], PY.nextOIndex, PY.cFree = ei, lim >= sz and oi + 1 or oi, lim - sz
				end
				PY.qI[ii], PY.qI[ii+1], PY.nextIIndex = mt, 0, ii + 2
				return true
			]==]
		]=])
		function core:quietCleanup()
			for i=1, #coreExecCleanup do
				securecall(coreExecCleanup[i])
			end
		end
		do -- SlashCmdList[slashKey](msg, box)
			coreEnv = GetManagedEnvironment(core)
			local runHandlers = {
				[coreEnv.PYtokens.unshift_restore] = function() core:manageUnshift(true) end,
				[coreEnv.PYtokens.nounshift] = function() core:manageUnshift(false) end,
				[coreEnv.PYtokens.mute] = function() core:setMute(true) end,
				[coreEnv.PYtokens.unmute] = function() core:setMute(false) end,
			}
			local pyRunID, pyRunIIndex = nil, 0
			SlashCmdList[slashKey] = function(_msg, box)
				local sPY = coreEnv.PY
				if not sPY.pendingResolve then return end
				local runID, nii, qI, rt, h = sPY.id, sPY.nextIIndex, sPY.qI
				if runID ~= pyRunID then
					pyRunIIndex, pyRunID = 1, runID
				end
				while pyRunIIndex < nii do
					rt, pyRunIIndex = qI[pyRunIIndex], pyRunIIndex + 1
					h = runHandlers[rt]
					if rt == 0 then
						break
					elseif h then
						securecall(h)
					elseif rt then
						for l in rt:gmatch("[^\r\n]+") do
							if l:byte(1) ~= 35 then -- not #
								box:SetText(l)
								securecall(ChatEdit_SendText, box, false)
							end
						end
					end
				end
			end
		end
	end
	core:Execute([=[-- Rewire_Init 
		KR, AB = self:GetFrameRef("Kindred"), self:GetFrameRef("ActionBook")
		execQueue, mutedAbove, QUEUE_LIMIT, overfull = newtable(), -1, 20000, false
		idle, cache, numIdle, numActive, ns, modLock = newtable(), newtable(), 0, 0, 0
		macros, namedMacroText, commandInfo, commandHandler, commandAlias = newtable(), newtable(), newtable(), newtable(), newtable()
		MACRO_TOKEN, NIL, metaCommands, transferTokens = newtable(nil, nil, nil, "MACRO_TOKEN"), newtable(), newtable(), newtable()
		metaCommands.mute, metaCommands.unmute, metaCommands.mutenext, metaCommands.parse, metaCommands.nounshift = 1, 1, 1, 1, 1
		castEscapes, castAliases = newtable(), newtable()
		reVars, soLiteralToEscapeSeq, soEscapeSeqToLiteral, soEscapePattern = newtable(), newtable(), newtable(), ""
		reMacroExt, reMacroExtOwner = newtable(), newtable()
		for c, e in KR:GetAttribute('SecureOptionEscapes'):gmatch("([^ ])(\\.)") do
			soLiteralToEscapeSeq[c], soEscapeSeqToLiteral[e], soEscapePattern = e, c, soEscapePattern .. c
		end
		soEscapePattern = "[" .. soEscapePattern:gsub("[%%[%]%.%-+*?()]", "%%%0") .. "]"

		for _, k in pairs(self:GetChildList(newtable())) do
			idle[k], numIdle = 1, numIdle + 1
			k:SetAttribute("type", "macro")
		end
		RW_ReleaseTransferToken = [==[-- RW_ReleaseTransferToken 
			local m = transferTokens[#transferTokens]
			if m[3] ~= NIL then
				modLock, m[3] = m[3], NIL
			end
			reVars.args, m[5] = m[5]
		]==]
		RW_ReleaseExecQueue = [==[-- RW_ReleaseExecQueue 
			local onlyTopMacro, r, m = ..., nil
			for i=#execQueue, 1, -1 do
				r, execQueue[i] = execQueue[i]
				m = r and r[4]
				if m == "TRANSFER_TOKEN" then
					transferTokens[#transferTokens+1] = r
					self:Run(RW_ReleaseTransferToken)
				elseif m == "UNSHIFT_RESTORE" then
					if PY and PY.nextOIndex then
						owner:Run(PY_EnqRun, nil, "unshift_restore")
					else
						self:CallMethod("manageUnshift", true)
					end
				elseif onlyTopMacro and r == MACRO_TOKEN then
					break
				end
			end
			if mutedAbove > #execQueue then
				if PY and PY.nextOIndex then
					owner:Run(PY_EnqRun, nil, "unmute")
				else
					self:CallMethod("setMute", false)
				end
				mutedAbove = - 1
			end
			self:SetAttribute("execPending", #execQueue)
		]==]
	]=])
	coreEnv = GetManagedEnvironment(core)
	coreNamedMacroText = coreEnv.namedMacroText
	local cf = CreateFrame("Frame", nil, core, "SecureFrameTemplate")
	SecureHandlerWrapScript(cf, "OnAttributeChanged", core, [[-- Rewire_TickOAC 
		if value ~= nil then
			return self:SetAttribute(name, nil)
		elseif name == "tick" then
			if #execQueue > 0 then
				owner:Run(RW_ReleaseExecQueue, false)
			end
			if PY and PY.pendingResolve then
				PY.pendingResolve, PY.nextOIndex = nil
			end
			mutedAbove = -1
		end
	]])
	RegisterAttributeDriver(cf, "tick", "1")
end
core:SetAttribute("ResolveOptionsClauseValue", [==[-- Rewire:ResolveOptionsClauseValue 
	local esc, v, resolveUnit, resolveVars, escapeMode = nil, ...
	esc = escapeMode ~= 2 and escapeMode ~= 3 and 1 or 0
	if v and resolveVars then
		local endP, esc, vn, cl, sp = 1 repeat
			sp, vn, cl, endP = endP, v:match("^%s*%%([a-zA-Z\128-\255][a-zA-Z0-9_\128-\255]*)(%S?)%s*()", endP)
			if not vn or cl ~= ":" and endP <= #v then
				v = sp == 1 and v or v:sub(sp)
				break
			elseif (reVars[vn] or "") ~= "" then
				esc, v = 0, reVars[vn]
				break
			elseif endP > #v then
				v = cl == ":" and "" or nil
				break
			end
		until nil
	end
	if resolveUnit then
		v = v and KR:RunAttribute("ResolveUnitAlias", v)
	elseif (v or "") == "" or esc == (escapeMode and escapeMode % 2 or 0) then
		-- It's fine as is
	elseif esc == 0 then
		v = rtgsub(v, soEscapePattern, soLiteralToEscapeSeq)
	else
		v = rtgsub(v, "\\.", soEscapeSeqToLiteral)
	end
	return v
]==])
core:SetAttribute("RunSlashCmd", [=[-- Rewire:Internal_RunSlashCmd 
	local slash, v, target, exArg = ...
	if not v then
	elseif slash == "/cast" or slash == "/use" then
		local vl = v:lower()
		local ac, av = 0, castAliases[vl]
		while av and ac < 10 do
			ac, v, vl = ac + 1, av, av:lower()
		end
		local oid = v and castEscapes[vl]
		local sid = v and not oid and v:match("^%s*spell:(%d+)%s*$")
		if oid then
			return AB:RunAttribute("UseAction", oid, target)
		elseif sid and PY and PY.nextOIndex then
			local si, oi, lim, sz = PY.nextSIndex, PY.nextOIndex, PY.cFree
			sz = PY.execSL + (oi > 1 and 1 or 0)
			PY.qS[si], PY.nextSIndex = newtable("CAST", tonumber(sid), target), si + 1
			PY[oi], PY.nextOIndex, PY.cFree = PY.execS, lim >= sz and oi + 1 or oi, PY.cFree - sz
		elseif sid then
			return AB:RunAttribute("CastSpellByID", tonumber(sid), target)
		elseif v then
			if exArg == "opt-into-cr-fallback" and (tonumber(v) or v:match("^%s*[Ii][Tt][Ee][Mm]:%d")) then
				slash = "/castrandom"
			end
			return (target and (slash .. " [@" .. target .. "] ") or (slash .. " ")) .. v
		end
	elseif slash == "/stopmacro" then
		owner:Run(RW_ReleaseExecQueue, true)
	elseif slash == "#mutenext" or slash == "#mute" then
		local breakOnCommand = slash == "#mutenext"
		for i=#execQueue,1,-1 do
			local m = execQueue[i]
			if m == MACRO_TOKEN or (breakOnCommand and m[4] == nil) then
				if i > 1 then i = i - 1 end
				if mutedAbove < 0 or i < mutedAbove then
					if mutedAbove >= 0 then
					elseif PY and PY.nextOIndex then
						owner:Run(PY_EnqRun, nil, "mute")
					else
						self:CallMethod("setMute", true)
					end
					mutedAbove = i
				end
				return
			end
		end
	elseif slash == "#unmute" and mutedAbove > -1 then
		for i=#execQueue,mutedAbove+1,-1 do
			if m == MACRO_TOKEN then
				return
			end
		end
		if PY and PY.nextOIndex then
			owner:Run(PY_EnqRun, nil, "unmute")
		else
			self:CallMethod("setMute", false)
		end
		mutedAbove = -1
	elseif slash == "#nounshift" then
		local breakOnCommand = v:lower() == "next"
		for i=#execQueue,1,-1 do
			local m = execQueue[i]
			if m == MACRO_TOKEN or (breakOnCommand and m[4] == nil) or i == 1 then
				table.insert(execQueue, i, newtable(nil, nil, nil, "UNSHIFT_RESTORE"))
				break
			end
		end
		if PY and PY.nextOIndex then
			owner:Run(PY_EnqRun, nil, "nounshift")
		else
			self:CallMethod("manageUnshift", false)
		end
	elseif slash == "#parse" then
		local m = execQueue[#execQueue]
		if m and m[2] and m[3] then
			execQueue[#execQueue] = nil
			local parsed = KR:RunAttribute("EvaluateCmdOptions", m[3], modLock, nil)
			parsed = parsed and self:RunAttribute("ResolveOptionsClauseValue", parsed, false, true)
			if parsed then
				return m[2] .. " " .. parsed
			end
		end
	elseif slash == "/runmacro" then
		if macros[v] then
			return macros[v]:RunAttribute("RunNamedMacro", v)
		elseif namedMacroText[v] then
			return self:RunAttribute("RunMacro", namedMacroText[v])
		end
		print(('|cffffff00Macro %q is unknown.'):format(v))
	elseif slash == "/varset" then
		local vname, vnEnd = v:match("^%s*([a-zA-Z\128-\255][a-zA-Z0-9_\128-\255]*)()")
		if not vname then return end
		local val = v:match("^%s+(.-)%s*$", vnEnd)
		val = val and self:RunAttribute("ResolveOptionsClauseValue", val, false, true, 2)
		reVars[vname] = val
	elseif slash then
		return (target and (slash .. " [@" .. target .. "] ") or (slash .. " ")) .. v
	end
]=])
core:SetAttribute("RunMacro", [=[-- Rewire:RunMacro 
	local m, macrotext, _transferButtonState, applyModLock, argVal = cache[...], ...
	if macrotext and PY and PY.pendingResolve then
		owner:CallMethod("NotNowError")
		return ""
	elseif macrotext and not m then
		m = newtable()
		for line in macrotext:gmatch("%S[^\n\r]*") do
			local slash, args = line:match("^(%S+)%s*(.-)%s*$")
			slash = slash:lower()
			local meta = slash:match("^#(.*)")
			if meta == nil or metaCommands[meta] then
				m[#m+1] = newtable(line, slash, args, meta, slash:match("^(/!)%S"))
			end
		end
		cache[macrotext] = m
	end

	if m and #m > 0 and not overfull then
		if #execQueue > QUEUE_LIMIT then
			overfull = true, owner:CallMethod("throw", "Rewire execution queue overfull; ignoring subsequent commands.")
		else
			local ni = #execQueue+1
			local nbs = nil
			local nml = (applyModLock == true and KR:GetAttribute("cndLock") or type(applyModLock) == "string" and applyModLock) or nil
			nml = nml and nml ~= modLock and nml
			local nt = #transferTokens
			local tt = nt > 0 and transferTokens[nt] or newtable(nil, nil, NIL, "TRANSFER_TOKEN")
			execQueue[ni], ni, transferTokens[nt] = tt, ni + 1
			modLock, tt[3], tt[5] = nml or modLock, modLock, reVars.args
			execQueue[ni], ni, reVars.args = MACRO_TOKEN, ni + 1, argVal
			for i=#m, 1, -1 do
				execQueue[ni], ni = m[i], ni + 1
			end
		end
	end

	local nextLine, pyTop
	if PY and not PY.nextOIndex then
		pyTop, PY.nextOIndex, PY.nextIIndex, PY.nextSIndex, PY.id = 1, 1, 1, 1, (PY.id or 0) % 2^30 + 1
		PY.cFree, PY.runSIndex = 255, nil
	end
	repeat
		if ns < #execQueue and numIdle > 0 and not PY then
			local m = "\n/click " .. next(idle):GetName() .. " x 1"
			local n = math.min(math.floor(1000/#m), math.ceil(#execQueue*1.25 + numActive*1.3^numActive))
			ns = ns + n
			self:SetAttribute("execPending", #execQueue)
			return m:rep(n)
		end
		local i, m, t, k, v, ct = #execQueue
		repeat
			m, i, execQueue[i] = execQueue[i], i-1
		until i < 1 or m ~= MACRO_TOKEN
		if mutedAbove > 0 and mutedAbove > i then
			owner:RunAttribute("RunSlashCmd", "#unmute")
		end
		self:SetAttribute("execPending", #execQueue)
		if not m then
			overfull, nextLine = false, ""
			break
		end
		k, v = commandAlias[m[2]] or m[2], m[3]
		local meta = m[4]
		local isMacroExt = m[5] and commandInfo[k] == nil
		ct = commandInfo[k] or isMacroExt and 1 or 0
		if isMacroExt and not reMacroExt[k] then
			v = nil -- do not emit undeclared/inactive macro extensions
		elseif ct % 2 > 0 and v ~= "" then
			local skipChunks = nil
			v, t = KR:RunAttribute("EvaluateCmdOptions", v, modLock, skipChunks)
			v = v and self:RunAttribute("ResolveOptionsClauseValue", v, ct % 32 >= 16, true)
			nextLine = v and (m[2] .. (t and " [@" .. t .. "] " or " ") .. v) or nil
		elseif meta == "TRANSFER_TOKEN" then
			transferTokens[#transferTokens+1], nextLine = m
			self:Run(RW_ReleaseTransferToken)
		elseif meta == "UNSHIFT_RESTORE" then
			self:CallMethod("manageUnshift", true)
		else
			nextLine = m[1]
		end
		if commandHandler[k] then
			nextLine = commandHandler[k]:RunAttribute("RunSlashCmd", m[2], v, t)
		elseif isMacroExt and v then
			nextLine = self:RunAttribute("RunMacro", reMacroExt[k], nil, nil, v)
		end
		if PY and (nextLine or "") ~= "" then
			local ck = (commandHandler[k] or isMacroExt) and nextLine:match("^(%S+)[^\n]*$")
			if ct == 0 or ck and (commandInfo[ck:lower()] or 0) == 0 then
				nextLine = "", self:Run(PY_EnqRun, nextLine)
			else
				local oi, lim, sz = PY.nextOIndex, PY.cFree
				sz = #nextLine:gsub("[\128-\191]+", "") + (oi > 1 and 1 or 0)
				PY[oi], PY.nextOIndex, PY.cFree, nextLine = nextLine, lim >= sz and oi + 1 or oi, lim - sz, ""
			end
		end
	until (nextLine or "") ~= "" or #execQueue == 0 or (PY and PY.cFree < 0)
	if pyTop then
		owner:Run(RW_ReleaseExecQueue)
		local m, n = PY[1], PY.nextOIndex - 1
		for i=2, n do
			m = m .. "\n" .. PY[i]
		end
		if PY.cFree < 0 then
			owner:CallMethod("LongMacroError")
		end
		PY.pendingResolve, PY.runSIndex, PY.nextOIndex, PY.cFree = n > 0 and PY.id or nil, nil
		return n > 0 and m or "", PY.pendingResolve
	end
	return nextLine or ""
]=])
core:SetAttribute("SetNamedMacroHandler", [=[-- Rewire:SetNamedMacroHandler 
	local handlerFrame, name, skipNotifyAB = self:GetFrameRef("SetNamedMacroHandler-handlerFrame"), ...
	local om, nm = macros[name], handlerFrame or (namedMacroText[name] and false)
	if type(name) == "string" and om ~= nm then
		macros[name] = nm
		self:CallMethod("clearNamedMacroHinter", name, skipNotifyAB or (om == nil) == (nm == nil))
	end
	self:SetAttribute("frameref-SetNamedMacroHandler-handlerFrame", nil)
]=])
core:SetAttribute("SetMacroExtensionCommand", [=[-- Rewire:SetMacroExtensionCommand 
	local cname, remacrotext, owner = ...
	cname = type(cname) == "string" and cname:lower()
	if not (cname or ""):match("^%S+$") or remacrotext ~= nil and type(remacrotext) ~= "string" or type(owner) ~= "string" then
		return self:CallMethod("throw", 'Syntax: SetMacroExtensionCommand("commandName", "remacrotext" or nil)')
	elseif remacrotext == nil and reMacroExtOwner[cname] ~= owner then
		return
	end
	reMacroExt["/!" .. cname], reMacroExtOwner[cname] = remacrotext ~= "" and remacrotext or nil, remacrotext and owner
]=])
core.LongMacroError = GenerateClosure(error, "blz: truncated very long macro", 2)
core.NotNowError = GenerateClosure(error, "blz: cannot run more macro commands now", 2)
function core:throw(err)
	return error(err, 2)
end
function core:clearNamedMacroHinter(name, skipNotifyAB)
	namedMacros[name] = nil
	if skipNotifyAB ~= true then
		AB:NotifyObservers("macro")
	end
end
do -- core:setMute(mute)
	local f, oSFX, oES, oUEM = CreateFrame("Frame")
	local muteArmed, muteReqState, muteCount = false, false, 0
	function core:setMute(mute)
		local arm, disarm = mute and not muteArmed, muteCount == 0 and not mute
		if arm then
			oSFX, oES = GetCVar("Sound_EnableSFX"), GetCVar("Sound_EnableErrorSpeech")
			oUEM = UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
		elseif oUEM and disarm then
			UIErrorsFrame:RegisterEvent("UI_ERROR_MESSAGE")
		end
		if arm or disarm then
			SetCVar("Sound_EnableSFX", mute and 0 or oSFX)
			SetCVar("Sound_EnableErrorSpeech", mute and 0 or oES)
		elseif muteArmed and not mute then
			SetCVar("Sound_EnableSFX", oSFX)
			SetCVar("Sound_EnableErrorSpeech", oES)
		end
		muteReqState, muteArmed = mute, arm or muteArmed and not disarm
		f:SetShown(muteArmed)
	end
	if MODERN then
		f:SetScript("OnEvent", function(_, e, u)
			if e == "UI_ERROR_MESSAGE" then
				if muteCount == 1 then
					muteCount = 0
					core:setMute(false)
				elseif muteCount > 0 then
					muteCount = muteCount - 1
				end
			elseif e == "UNIT_SPELLCAST_FAILED" and muteReqState and u == "player" then
				muteCount = muteCount + 1
			end
		end)
		f:RegisterEvent("UI_ERROR_MESSAGE")
		f:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", "player")
	end
	f:SetScript("OnUpdate", function()
		local ost = muteReqState
		muteCount = 0
		core:setMute(false)
		if ost then
			error("Muted state persisted after macro execution")
		end
	end)
	coreExecCleanup[#coreExecCleanup+1] = function()
		if muteArmed then
			muteCount = 0
			core:setMute(false)
		end
	end
	f:Hide()
end
do -- core:manageUnshift(isRestore)
	local isModified, origValue, modDepth = false, nil, 0
	local cleanupArmed, COMBATLOCKED_UNSHIFT = false, MODERN
	local function cleanup()
		if COMBATLOCKED_UNSHIFT and InCombatLockdown() then
			EV.PLAYER_REGEN_ENABLED = cleanup
			return
		end
		cleanupArmed = false
		if isModified then
			SetCVar("autoUnshift", origValue)
			isModified, modDepth = false, 0
			securecall(error, "RW unshift cleanup panic")
		end
		return "remove"
	end
	function core:manageUnshift(isRestore)
		if COMBATLOCKED_UNSHIFT and InCombatLockdown() then
		elseif isRestore then
			if modDepth > 0 then
				modDepth = modDepth - 1
				if modDepth <= 0 then
					SetCVar("autoUnshift", origValue)
					isModified = false
				end
			end
		else
			if not isModified then
				origValue = GetCVar("autoUnshift")
				SetCVar("autoUnshift", 0)
			end
			isModified, modDepth = true, modDepth > 0 and modDepth + 1 or 1
			if not cleanupArmed then
				EV.After(0, cleanup)
				cleanupArmed = true
			end
		end
	end
	coreExecCleanup[#coreExecCleanup+1] = function()
		if cleanupArmed and isModified and not (COMBATLOCKED_UNSHIFT and InCombatLockdown()) then
			modDepth = 1
			core:manageUnshift(true)
		end
	end
end

local function setCommandType(slash, ctype, handler)
	if handler ~= nil then core:SetFrameRef('hand', handler) end
	core:Execute(("commandInfo[%s], commandHandler[%1$s] = %d, %s"):format(safequote(slash), ctype, handler and "self:GetFrameRef('hand')" or "nil"))
end
local function getAliases(p, i)
	local v = _G[p .. i]
	if v then
		return v, getAliases(p, i+1)
	end
end

local setCommandHinter, getMacroHint, getCommandHint, getCommandHintRaw, getSpeculationID, metaFilters, metaFilterTypes, reVarsSP, resolveOptionsClauseValue do
	local hintFunc, pri, cache, ht, ht2, cDepth = {}, {}, {}, {}, {}, 0
	local DEPTH_LIMIT, UNKNOWN_PRIORITY, nInf = 20, -2^52, -math.huge
	local speculationID, nextSpeculationID, SPECULATION_ID_WRAP = nil, 221125, 2^53
	local store do
		local function write(t, n, i, a,b,c,d, ...)
			if n > 0 then
				t[i], t[i+1], t[i+2], t[i+3] = a,b,c,d
				return write(t, n-4, i+4, ...)
			end
		end
		function store(ok, ...)
			if ok then
				local n = select("#", ...)
				write(ht2, n+1, 0, n, ...)
			end
			return ok
		end
	end
	metaFilters, metaFilterTypes = {}, {} do
		local function fillToSize(sz, stopFillAt)
			if ht[0] < sz then
				for i=ht[0]+1,stopFillAt do
					ht[i] = nil
				end
				ht[0] = sz
			end
			return true
		end
		local function setIcon(icon, isAtlas, _si)
			ht[3], _si = icon, 2
			if isAtlas == true or isAtlas == false then
				local st = ht[0] >= 2 and ht[2]
				st = st and type(st) == "number" and st or 0
				if isAtlas ~= (st % 524288 >= 262144) then
					ht[2], _si = isAtlas and (st + 262144) or (st - 262144), 1
				end
			end
			return fillToSize(3, _si)
		end
		function metaFilterTypes:replaceIcon(...)
			local doReplace, icon, isAtlas = self(...)
			if doReplace then
				return setIcon(icon, isAtlas)
			end
		end
		function metaFilterTypes:replaceIconB(...)
			local doReplace, usable, icon, isAtlas = self(ht[3], ...)
			if doReplace then
				if usable == true or usable == false or ht[0] == 0 or ht[1] == nil then
					ht[0], ht[1] = ht[0] > 1 and ht[0] or 1, usable ~= false
				end
				return setIcon(icon, isAtlas)
			end
		end
		function metaFilterTypes:replaceTooltip(...)
			local doReplace, tipFunc, tipArg = self(...)
			if doReplace then
				ht[8], ht[9] = tipFunc, tipArg
				return fillToSize(9, 7)
			end
		end
		function metaFilterTypes:replaceCooldown(...)
			local doReplace, cdLeft, cdLength = self(...)
			if doReplace then
				ht[6], ht[7] = cdLeft, cdLength
				return fillToSize(7, 5)
			end
		end
		function metaFilterTypes:replaceCount(...)
			local doReplace, count = self(...)
			if doReplace then
				ht[5] = count
				return fillToSize(5, 4)
			end
		end
		function metaFilterTypes:replaceLabel(...)
			local doReplace, stext = self(...)
			if doReplace then
				ht[11] = stext
				return fillToSize(11, 10)
			end
		end
		function metaFilterTypes:macroFallback(...)
			local doReplace, usable, icon, label = self(...)
			if doReplace then
				local d, hl = false, ht[0]
				if label and (hl < 11 or ht[11] == nil) then
					ht[11], d = label, d or fillToSize(11, 10)
				end
				if label and (hl < 4 or ht[4] == nil) then
					ht[4], d = label, d or fillToSize(4, 3)
				end
				if icon and (doReplace == 2 or hl < 3 or not ht[3]) then
					ht[3], d = icon, d or fillToSize(3, 2)
				end
				if usable == true and (ht[1] == nil or hl < 1) then
					ht[1], ht[2], d = true, 0, d or fillToSize(2,0)
				end
				return d
			end
		end
		function metaFilterTypes:replaceHint(...)
			if store(self(...)) then
				ht, ht2 = ht2, ht
				return true
			end
		end
	end
	function getCommandHintRaw(hslash, ...)
		local hf = hintFunc[hslash]
		if not hf then return false end
		return hf(...)
	end
	local function clearDepth(...)
		cDepth, speculationID = 0, nil
		return ...
	end
	local function prepCall(...)
		if cDepth ~= 0 then error("invalid state") end
		cDepth, speculationID, nextSpeculationID = 1, nextSpeculationID, nextSpeculationID ~= SPECULATION_ID_WRAP and nextSpeculationID + 1 or -nextSpeculationID
		return clearDepth(securecall(...))
	end
	reVarsSP = {} do
		local specVarVal, specVarID = {}, {}
		local function vp__index(_, k)
			if speculationID and specVarID[k] == speculationID then
				return specVarVal[k]
			end
			return coreEnv.reVars[k]
		end
		local function vp__newindex(_, k, v)
			specVarVal[k], specVarID[k] = v ~= nil and tostring(v) or v, speculationID
		end
		setmetatable(reVarsSP, {__index=vp__index, __newindex=vp__newindex})
	end
	do -- resolveOptionsClauseValue(v, resolveUnits, resolveVars)
		local env = setmetatable({rtgsub = string.rtgsub, reVars = reVarsSP, KR = {RunAttribute=function(_, a, ...)
			if a == "ResolveUnitAlias" then
				return KR:ResolveUnitAlias(...)
			end
			assert(false, 'Unexpected Shadow-KR:RunAttribute %q', tostring(a))
		end}}, {__index=coreEnv})
		resolveOptionsClauseValue = assert(loadstring(("-- shadowRW:ResolveOptionsClauseValue \nreturn function(...)\n%s\nend"):format(core:GetAttribute("ResolveOptionsClauseValue"))))()
		setfenv(resolveOptionsClauseValue, env)
	end
	function getCommandHint(minPriority, slash, args, modState, otarget, msg, priBias)
		-- Two ways to get here:
		-- 1. RW:GetCommandAction calls with minPriority/priBias = nil, but supplies otarget/msg
		-- 2. getMacroHint calls supplying minPriority and priBias, but otarget/msg == nil
		slash = coreEnv.commandAlias[slash] or slash
		local hf, pri, args2, target = hintFunc[slash], pri[slash]
		local reText = hf == nil and coreEnv.reMacroExt[slash]
		if hf and pri > (minPriority or nInf) - (priBias or 0) or reText then
			if cDepth == 0 then
				return prepCall(getCommandHint, minPriority, slash, args, modState, otarget, msg, priBias)
			elseif cDepth > DEPTH_LIMIT then
				return false
			elseif hf and otarget ~= nil then
				args, args2, target = nil, args, otarget
			else
				local ctype = (coreEnv.commandInfo[slash] or reText and 1 or 0)
				if ctype % 2 == 0 then -- no secure option evaluation (ignoring #parse)
				elseif args == "" then
					args2, args = ""
				else
					args, args2, target = nil, KR:EvaluateCmdOptions(args, modState, nil, speculationID)
					args2 = args2 and resolveOptionsClauseValue(args2, ctype % 32 >= 16, true)
					if not args2 then return end -- no option clause applies, command not executed
				end
				if reText then
					local res = store(getMacroHint(reText, modState, minPriority, args2))
					if minPriority then
						return res, res or nInf
					end
					return res, unpack(ht2, 1, res and ht2[0] or 0)
				end
			end
			cDepth = cDepth + 1
			local res = store(securecall(hf, slash, args, args2, target, modState, minPriority, msg, speculationID))
			cDepth = cDepth - 1
			if res == "stop" then
				return res, pri
			elseif minPriority then
				return res, (res ~= true and res or pri) + (priBias or 0)
			elseif res then
				return res, unpack(ht2, 1, ht2[0])
			end
		elseif not pri then
			return false
		end
	end
	function getMacroHint(macrotext, modState, minPriority, argsVar)
		if not macrotext then return end
		if cDepth == 0 then
			return prepCall(getMacroHint, macrotext, modState, minPriority)
		end
		local m, lowPri = cache[macrotext], minPriority or nInf
		if not m then
			m = {}
			for line in macrotext:gmatch("%S[^\n\r]*") do
				local slash, args = line:match("^(%S+)%s*(.-)%s*$")
				slash = slash:lower()
				local meta, meta4 = slash:match("^#((.?.?.?.?).*)")
				if meta4 == "show" and args ~= "" then
					m[-1], m[0] = "/use", args
				elseif meta == nil or meta == "skip" or meta == "important" then
					m[#m+1], m[#m+2] = slash, args
				else
					if m.metaKeys == nil then
						m.metaKeys, m.metaArgs = {}, {}
					end
					local idx = #m.metaKeys+1
					m.metaKeys[idx], m.metaArgs[idx] = meta, args
				end
			end
			cache[macrotext] = m
		end

		local bestPri, bias, oldArgsVar, haveUnknown = lowPri, m[-1] and 1000 or 0, reVarsSP.args
		reVarsSP.args = argsVar
		for i=m[-1] and -1 or 1, #m, 2 do
			local cmd, args = m[i], m[i+1]
			if cmd == "#skip" or cmd == "#important" then
				local v = args == "" or KR:EvaluateCmdOptions(args, modState)
				if v ~= nil then
					v = tonumber(v)
					bias = cmd == "#skip" and (v and -v or nInf) or (v or 1000)
				end
			else
				local res, pri = getCommandHint(bestPri, cmd, args, modState, nil, nil, bias)
				if res == "stop" then
					break
				elseif res and pri > bestPri then
					bestPri, ht, ht2 = pri, ht2, ht
				elseif res == false and i > 0 then
					haveUnknown = true
				end
				bias = 0
			end
		end
		local mk, mv = m.metaKeys
		if (bestPri <= lowPri) and (haveUnknown or mk) then
			store(true, nil, 0, nil, "", 0, 0, 0)
			ht, ht2 = ht2, ht
		end
		for i=1,mk and #mk or 0 do
			local k = mk[i]
			local fi = metaFilters[k]
			if fi then
				mv = mv or m.metaArgs
				local filterRun, parseConditional, filterFunc, filterType = fi[1], fi[2], fi[3], fi[4]
				local v, vt = mv[i], nil
				local ic = filterType == "replaceIconB" and ht[0] >= 3 and ht[3]
				if filterType == "replaceIconB" and ic and ic ~= 134400 and (type(ic) ~= "string" or GetFileIDFromPath(ic) ~= 134400) then
					v = nil
				elseif parseConditional then
					v, vt = KR:EvaluateCmdOptions(v, modState)
					v = v and resolveOptionsClauseValue(v, false, true)
				end
				if v and securecall(filterRun, filterFunc, k, v, vt) then
					haveUnknown = true
				end
			end
		end
		reVarsSP.args = oldArgsVar

		if bestPri > lowPri or haveUnknown then
			if minPriority then
				if haveUnknown and bestPri == nInf then
					bestPri = UNKNOWN_PRIORITY - cDepth
				end
				return bestPri > lowPri and bestPri or false, unpack(ht, 1, ht[0])
			else
				return unpack(ht, 1, ht[0])
			end
		end
	end
	function setCommandHinter(slash, priority, hint)
		hintFunc[slash], pri[slash] = hint, hint and priority
	end
	function getSpeculationID()
		return speculationID
	end
end

local function init()
	for k, v in pairs(_GG) do
		local k = type(k) == "string" and k:match("^SLASH_(.*)1$")
		if k and IsSecureCmd(v) then
			RW:ImportSlashCmd(k, true, false)
		end
	end
	for k in ("DISMOUNT LEAVEVEHICLE SET_TITLE USE_TALENT_SPEC TARGET_MARKER"):gmatch("%S+") do
		RW:ImportSlashCmd(k, true, false)
	end
	for k in ("STARTATTACK TARGET TARGET_EXACT ASSIST FOCUS MAINTANKON MAINTANKOFF MAINASSISTON MAINASSISTOFF PET_ATTACK"):gmatch("%S+") do
		local cmd = _G["SLASH_" .. k .. "1"]
		if cmd and IsSecureCmd(cmd) then
			setCommandType(cmd, 1+2+16)
		end
	end
	for m in ("#mute #unmute #mutenext #parse #nounshift"):gmatch("%S+") do
		RW:RegisterCommand(m, true, false, core)
	end
	RW:RegisterCommand("/stopmacro", true, false, core)
	RW:RegisterCommand("/varset", true, true, core)
	RW:SetCommandHint("/varset", math.huge, function(_, _, v)
		if not v then return end
		local vname, vnEnd = v:match("^%s*([a-zA-Z\128-\255][a-zA-Z0-9_\128-\255]*)()")
		if not vname then return end
		local val = v:match("^%s+(.-)%s*$", vnEnd)
		val = val and resolveOptionsClauseValue(val, false, true, 2)
		RW:SetSpeculativeMacroVarValue(vname, val)
	end)
	RW:AddCommandAliases("/stopmacro", getAliases("SLASH_STOPMACRO", 1))
	RW:SetCommandHint("/stopmacro", math.huge, function(_, _, clause)
		return clause and "stop" or nil
	end)
	RW:SetCommandHint(SLASH_CLICK1, math.huge, function(...)
		local _, _, clause = ...
		local name = clause and clause:match("%S+")
		return getCommandHintRaw(name and ("/click " .. name), ...)
	end)
	setCommandType("/use", 1+2, core)
	setCommandType("/cast", 1+2, core)
	RW:AddCommandAliases("/cast", getAliases("SLASH_CAST", 1))
	RW:AddCommandAliases("/use", getAliases("SLASH_USE", 1))
	setCommandType(SLASH_USERANDOM1, 1+2+4)
	RW:AddCommandAliases(SLASH_USERANDOM1, getAliases("SLASH_CASTRANDOM", 1))
	setCommandType(SLASH_CASTSEQUENCE1, 1+2+4+8)
	RW:RegisterCommand("/runmacro", true, true, core)
	RW:SetCommandHint("/runmacro", math.huge, function(_slash, _, n, _t, ...)
		local f = namedMacros[n]
		if f then
			return f(n, nil, ...)
		end
		local mt = coreNamedMacroText[n]
		if mt then
			local cndState, minPriority = ...
			return getMacroHint(mt, cndState, minPriority)
		end
	end)

	local iconAtlasCache = {}
	local iconReplCache = setmetatable({}, {__index=function(t,k)
		if not k then return end
		local v, c, f, a = (tonumber(k))
		if not v then
			if k:match("[/\\]") then
				v = k
			elseif k ~= "" then
				c = "Interface\\Icons\\" .. k
				f = GetFileIDFromPath(c)
				v = f and (f > 0 and f or c) or C_Texture.GetAtlasInfo(k) and k or false
				a = v and not f
			end
		end
		t[k], iconAtlasCache[k] = v ~= 0 and v, a or v and false
		return v
	end})
	local function iconBC(_oico, meta, value, _target)
		return true, meta == "iconb" and nil, iconReplCache[value], iconAtlasCache[value]
	end
	RW:SetMetaHintFilter("icon", "replaceIcon", true, function(_meta, value, _target)
		return true, iconReplCache[value], iconAtlasCache[value]
	end)
	RW:SetMetaHintFilter("iconb", "replaceIconB", true, iconBC)
	RW:SetMetaHintFilter("iconc", "replaceIconB", true, iconBC)
	RW:SetMetaHintFilter("count", "replaceCount", true, function(_meta, value, _target)
		local c = value == "none" and 0 or (value and C_Item.GetItemCount(value))
		return not not c, c
	end)
	RW:SetMetaHintFilter("label", "replaceLabel", true, function(_meta, value, _target)
		return not not value, value or ""
	end)
end
local caEscapeCache, caAliasCache, caIsOptional, cuHints, caFlush = {}, {}, {}, {} do
	setmetatable(caEscapeCache, {__index=function(t, k)
		if k then
			local v = coreEnv.castEscapes[k:lower()] or false
			t[k] = v
			return v
		end
	end})
	setmetatable(caAliasCache, {__index=function(t, k)
		if k then
			local at = coreEnv.castAliases
			local v = at[k:lower()]
			repeat
				local vl = v and v:lower()
				v = at[vl] or v
			until not at[vl]
			t[k] = v
			return v
		end
	end})
	function caFlush()
		wipe(caEscapeCache)
		wipe(caAliasCache)
	end
	local function mixHint(slash, _, clause, target, ...)
		clause = caAliasCache[clause] or clause
		local ca = caEscapeCache[clause]
		if ca then
			return true, AB:GetSlotInfo(ca)
		else
			local hint = cuHints[slash]
			if hint then
				return hint(slash, _, clause, target, ...)
			end
		end
	end
	setCommandHinter("/use", 100, mixHint)
	setCommandHinter("/cast", 100, mixHint)
end
local function nextReVar(_, k)
	return rtnext(coreEnv.reVars, k)
end

function RW:compatible(cmaj, crev)
	local acceptable = (cmaj == MAJ and crev <= REV)
	if acceptable and init then
		init()
		init = nil
	end
	return acceptable and RW or nil, MAJ, REV
end
function RW:seclib()
	return core
end
function RW:RegisterCommand(slash, isConditional, allowVars, handlerFrame)
	assert(type(slash) == "string" and (handlerFrame == nil or type(handlerFrame) == "table" and type(handlerFrame.GetAttribute) == "function"),
		'Syntax: Rewire:RegisterCommand("/slash", parseConditional, allowVars[, handlerFrame])')
	assert(handlerFrame == nil or handlerFrame:GetAttribute("RunSlashCmd"), 'Handler frame must have "RunSlashCmd" attribute set.')
	assert(not InCombatLockdown(), 'Combat lockdown in effect')
	local ct = (isConditional and 1 or 0) + (allowVars and 2 or 0)
	setCommandType(slash, ct, handlerFrame)
end
function RW:AddCommandAliases(primary, ...)
	assert(type(primary) == "string", 'Syntax: Rewire:AddCommandAliases("/slash", ["/alias1", "/alias2", ...])')
	assert(not InCombatLockdown(), 'Combat lockdown in effect')
	local n, s = select("#", ...), "-- Rewire_AddCommandAliases\nlocal a, p = commandAlias, %s\n"
	s = s .. ("a[%s], "):rep(n-1) .. "a[%s] = " .. ("p, "):rep(n-1) .. "p\n"
	core:Execute(s:format(forall(safequote, primary, ...)))
end
function RW:GetCommandInfo(slash)
	assert(type(slash) == "string", 'Syntax: isConditional, allowVars, isCommaListArg, isSequenceListArg, resolveUnitTargets = Rewire:GetCommandInfo("/slash")')
	local ct = coreEnv.commandInfo[slash]
	if ct then
		return ct % 2 >= 1, ct % 4 >= 2, ct % 8 >= 4, ct % 16 >= 8, ct % 32 >= 16
	end
end
function RW:ImportSlashCmd(key, isConditional, allowVars, priority, hint)
	assert(type(key) == "string" and (hint == nil or type(hint) == "function" and type(priority) == "number"), 'Syntax: Rewire:ImportSlashCmd("KEY", parseConditional, allowVars[, hintPriority, hintFunc])')
	assert(not InCombatLockdown(), 'Combat lockdown in effect')
	local primary = _G["SLASH_" .. key .. "1"]
	RW:RegisterCommand(primary, isConditional, allowVars)
	if _G["SLASH_" .. key .. "2"] then
		RW:AddCommandAliases(getAliases("SLASH_" .. key, 1))
	end
	if primary and hint then
		self:SetCommandHint(primary, priority, hint)
	end
end
function RW:SetCommandHint(slash, priority, hint)
	assert(type(slash) == "string" and (hint == nil or type(hint) == "function" and type(priority) == "number"), 'Syntax: Rewire:SetCommandHint("/slash", priority, hintFunc)')
	if slash ~= "/use" and slash ~= "/cast" then
		setCommandHinter(slash, priority, hint)
	else
		cuHints[slash] = hint
	end
end
function RW:SetClickHint(buttonName, priority, hint)
	assert(type(buttonName) == "string" and (hint == nil or type(hint) == "function" and type(priority) == "number"), 'Syntax: Rewire:SetClickHint("buttonName", priority, hintFunc)')
	setCommandHinter("/click " .. buttonName, priority, hint)
end
function RW:SetMetaHintFilter(meta, filterType, isConditional, hint)
	assert(type(meta) == "string" and type(isConditional) == "boolean" and type(hint) == "function", 'Syntax: Rewire:SetMetaHintFilter("meta", "filterType", isConditional, hintFunc)')
	local filterRun = assert(metaFilterTypes[filterType], 'Unsupported meta hint filter type')
	metaFilters[meta:lower()] = {filterRun, isConditional, hint, filterType}
end
function RW:SetNamedMacroHandler(name, handlerFrame, hintFunc, skipNotifyAB)
	assert(type(name) == "string" and type(handlerFrame) == "table" and type(handlerFrame.GetAttribute) == "function" and (hintFunc == nil or type(hintFunc) == "function"),
		'Syntax: Rewire:SetNamedMacroHandler(name, handlerFrame, hintFunc?, skipNotifyAB?)')
	assert(handlerFrame:GetAttribute("RunNamedMacro"), 'Handler frame must have "RunNamedMacro" attribute set.')
	if handlerFrame ~= GetFrameHandleFrame(coreEnv.macros[name]) then
		assert(not InCombatLockdown(), 'Combat lockdown in effect')
		core:SetFrameRef("SetNamedMacroHandler-handlerFrame", handlerFrame)
		core:Execute(('self:RunAttribute("SetNamedMacroHandler", %s, %s)'):format(safequote(name), skipNotifyAB == true and 'true' or 'nil'))
	end
	namedMacros[name] = hintFunc
end
function RW:ClearNamedMacroHandler(name, handlerFrame, skipNotifyAB)
	assert(type(handlerFrame) == "table" and type(name) == "string", 'Syntax: Rewire:ClearNamedMacroHandler("name", handlerFrame)')
	if GetFrameHandleFrame(coreEnv.macros[name]) == handlerFrame then
		assert(not InCombatLockdown(), 'Combat lockdown in effect')
		core:Execute(('macros[%s] = %s'):format(safequote(name), coreNamedMacroText[name] and 'false' or 'nil'))
		core:clearNamedMacroHinter(name, skipNotifyAB)
	end
end
function RW:GetNamedMacros()
	return rtable.pairs(coreEnv.macros)
end
function RW:IsNamedMacroKnown(name)
	return coreEnv.macros[name] ~= nil
end
function RW:RegisterNamedMacroTextOwner(owner, priority)
	assert(owner ~= nil and type(priority) == "number", 'Syntax: ownerToken = Rewire:RegisterNamedMacroTextOwner(owner, priority)')
	assert(namedMacroTextOwnerPriority[owner] == nil, 'Duplicate registration')
	namedMacroTextOwnerPriority[owner] = priority
	return owner
end
function RW:SetNamedMacroText(name, text, ownerToken, skipNotifyAB)
	assert(type(name) == "string" and (not text or type(text) == "string"),
		'Syntax: Rewire:SetNamedMacroText("name", "text", ownerToken, priority?, skipNotifyAB?)')
	assert(not InCombatLockdown(), 'Combat lockdown in effect')
	assert(namedMacroTextOwnerPriority[ownerToken], 'ownerToken is not registered')
	local a = namedMacroText[name]
	local et = a and a[ownerToken]
	if not (text or et) or et == text then
		return
	else
		a = a or {}
		namedMacroText[name], a[ownerToken] = a, text or nil
	end
	local nv, k, p = nil, next(a)
	if k == nil then
		namedMacroText[name] = nil
	else
		nv, p = p, namedMacroTextOwnerPriority[k]
		for co, text in next, a, k do
			local cp = namedMacroTextOwnerPriority[co]
			if cp > p then
				nv, p = text, cp
			end
		end
	end
	if nv ~= coreNamedMacroText[name] then
		core:Execute(('local n, t = %s, %s; namedMacroText[n], macros[n] = t, macros[n] or (t and false)'):format(safequote(name), nv and safequote(nv) or 'nil'))
		if skipNotifyAB then
			return true
		elseif AB then
			AB:NotifyObservers("macro")
		end
	end
end
function RW:GetMacroAction(macrotext, cndState, minPriority)
	return getMacroHint(macrotext, cndState, minPriority)
end
function RW:GetNamedMacroAction(name, cndState, minPriority)
	local hf = namedMacros[name]
	if hf then
		return hf(name, nil, cndState, minPriority)
	end
	local mt = coreNamedMacroText[name]
	if mt then
		return getMacroHint(mt, cndState, minPriority)
	end
end
function RW:GetCommandAction(slash, args, target, modState, msg)
	return getCommandHint(nil, slash, args, modState, target, msg)
end
function RW:SetCastEscapeAction(castArg, action, isOptional)
	assert(type(castArg) == "string" and (type(action) == "number" and action % 1 == 0 or action == nil) and (type(isOptional) == "boolean" or isOptional == nil),
		'Syntax: Rewire:SetCastEscapeAction("castAction", abActionID or nil[, isOptional])')
	assert(not InCombatLockdown(), 'Combat lockdown in effect')
	local lowArg = castArg:lower()
	core:Execute(([[local n = %s; castEscapes[n], castAliases[n] = %s, nil]]):format(safequote(lowArg), action or "nil"))
	caIsOptional[lowArg] = action and isOptional or nil
	caFlush()
end
function RW:GetCastEscapeAction(castArg)
	return caEscapeCache[castArg]
end
function RW:SetCastAlias(castArg, aliasTo, isOptional)
	assert(type(castArg) == "string" and (aliasTo == nil or type(aliasTo) == "string") and (isOptional == true or not isOptional),
		'Syntax: Rewire:SetCastAlias("castAction", "aliasTo" or nil[, isOptional])')
	assert(not InCombatLockdown(), 'Combat lockdown in effect')
	local lowArg = castArg:lower()
	if aliasTo == castArg or aliasTo and strcmputf8i(aliasTo, castArg) == 0 then
		aliasTo = nil
	elseif aliasTo then
		local al, at = aliasTo:lower(), coreEnv.castAliases
		while al ~= lowArg and al and at[al] do
			al = at[al]:lower()
		end
		assert(al ~= lowArg, 'Aliasing %q creates an alias cycle.', aliasTo)
	end
	core:Execute(([[local n = %s; castAliases[n], castEscapes[n] = %s, nil]]):format(safequote(lowArg), aliasTo and safequote(aliasTo) or "nil"))
	caIsOptional[lowArg] = aliasTo and isOptional or nil
	caFlush()
end
function RW:GetCastAlias(castArg)
	return caAliasCache[castArg]
end
function RW:IsCastEscape(castArg, excludeOptional)
	local lowArg = type(castArg) == "string" and castArg:lower() or nil
	if excludeOptional and caIsOptional[lowArg] then
		return false
	end
	return (caEscapeCache[lowArg] or caAliasCache[lowArg]) ~= nil
end
function RW:IsSpellCastable(id, castContext, laxRank)
	local ccf, cc, re, defer = Spell_CheckCastable[id]
	if ccf then
		cc, re, defer = ccf(id, castContext, laxRank)
	end

	local name, _, name2, sid2 = (cc == nil or defer) and GetSpellInfo(id), nil
	if name and (caEscapeCache[name] or caAliasCache[name]) then
		local disallowRewireEscapes = castContext == true or castContext and type(castContext) == "number" and castContext % 2 < 1
		if disallowRewireEscapes ~= true or (disallowRewireEscapes == true and not caIsOptional[name:lower()]) then
			return disallowRewireEscapes ~= true, "rewire-escape"
		end
	end
	if cc ~= nil then
		return cc, re
	elseif not name then
		return false, "unknown-sid"
	end

	name2, _, _, _, _, _, sid2 = GetSpellInfo(name, laxRank ~= "lax-rank" and GetSpellSubtext(id) or nil)
	if MODERN and sid2 and IsPassiveSpell(sid2) then
		return false, "passive-override"
	elseif name2 then
		return true, "double-gsi"
	end
	return false
end
function RW:SetSpellCastableChecker(id, callback)
	assert(type(id) == "number" and (callback == nil or type(callback) == "function"),
		'Syntax: Rewire:SetSpellCastableChecker(spellID, callback or nil)')
	Spell_CheckCastable[id] = callback
end
function RW:SetMacroExtensionCommand(name, remacrotext, owner)
	assert(type(name) == "string" and (remacrotext == nil or type(remacrotext) == "string") and type(owner) == "string",
		'Syntax: Rewire:SetMacroExtensionCommand("commandName", "remacrotext" or nil, "owner")')
	assert(not InCombatLockdown(), 'Combat lockdown in effect')
	core:SetAttribute('arg-cname', name)
	core:SetAttribute('arg-rtext', remacrotext)
	core:SetAttribute('arg-owner', owner)
	core:Execute([[-- RW-SetMacroExtensionCommand 
		self:RunAttribute("SetMacroExtensionCommand", self:GetAttribute('arg-cname'), self:GetAttribute('arg-rtext'), self:GetAttribute('arg-owner'))
	]])
end
function RW:GetMacroExtensionCommand(name, checkOwner)
	assert(type(name) == "string", 'Syntax: Rewire:GetMacroExtensionCommand("commandName"[, "checkOwner"])')
	name = name:lower()
	return coreEnv.reMacroExt["/!" .. name], coreEnv.reMacroExtOwner[name] == checkOwner
end
function RW:SetSpeculativeMacroVarValue(vname, value)
	assert(type(vname) == "string", 'Syntax: Rewire:SetSpeculativeMacroVarValue("vname", "value" or nil)')
	reVarsSP[vname] = value
end
function RW:SetMacroVarValue(vname, value)
	assert(type(vname) == "string" and (value == nil or type(value) == "string"), 'Syntax: Rewire:SetMacroVarValue("vname", "value" or nil)')
	assert(not InCombatLockdown(), 'Combat lockdown in effect')
	core:SetAttribute('arg-vname', vname)
	core:SetAttribute('arg-value', value)
	core:Execute([[-- RW-SetMacroVarValue 
		reVars[self:GetAttribute("arg-vname")] = self:GetAttribute("arg-value")
	]])
end
function RW:ResolveOptionsClauseValue(value, resolveUnit, resolveVars, escapeMode)
	assert((value == nil or type(value) == "string") and (escapeMode == nil or type(escapeMode) == "number"),
		'Syntax: Rewire:ResolveOptionsChaluseValue("value", resolveUnit, resolveVars[, escapeMode])')
	return resolveOptionsClauseValue(value, resolveUnit, resolveVars, escapeMode)
end
RW.GetSpeculationID = getSpeculationID

-- HIDDEN, UNSUPPORTED METHODS: May vanish at any time.
local hum = {}
setmetatable(RW, {__index=hum})
hum.HUM = hum
function hum:AllMacroVars()
	return nextReVar
end
function hum:IsPyrolysisActive()
	return not not PYROLYSIS
end

AB:RegisterModule("Rewire", {compatible=RW.compatible})