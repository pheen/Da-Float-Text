-----------------------------------------------------------------------------------------------
-- Client Lua Script for DaFloatText
-- Copyright (c) NCsoft. All rights reserved
-----------------------------------------------------------------------------------------------
 
require "Window"
require "GameLib"
require "CombatFloater"

-----------------------------------------------------------------------------------------------
-- DaFloatText Module Definition
-----------------------------------------------------------------------------------------------
local DaFloatText = {} 
 
-----------------------------------------------------------------------------------------------
-- Constants
-----------------------------------------------------------------------------------------------
-- e.g. local kiExampleVariableMax = 999
 
-----------------------------------------------------------------------------------------------
-- Initialization
-----------------------------------------------------------------------------------------------
function DaFloatText:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self 

    -- initialize variables here

    return o
end

function DaFloatText:Init()
	local bHasConfigureFunction = false
	local strConfigureButtonText = ""
	local tDependencies = {
		-- "UnitOrPackageName",
	}
    Apollo.RegisterAddon(self, bHasConfigureFunction, strConfigureButtonText, tDependencies)
end
 

-----------------------------------------------------------------------------------------------
-- DaFloatText OnLoad
-----------------------------------------------------------------------------------------------
function DaFloatText:OnLoad()
    -- load our form file
	self.xmlDoc = XmlDoc.CreateFromFile("DaFloatText.xml")
	self.xmlDoc:RegisterCallback("OnDocLoaded", self)
end

-----------------------------------------------------------------------------------------------
-- DaFloatText OnDocLoaded
-----------------------------------------------------------------------------------------------
function DaFloatText:OnDocLoaded()

	if self.xmlDoc ~= nil and self.xmlDoc:IsLoaded() then
	    self.wndMain = Apollo.LoadForm(self.xmlDoc, "DaFloatTextForm", nil, self)
		if self.wndMain == nil then
			Apollo.AddAddonErrorText(self, "Could not load the main window for some reason.")
			return
		end
		
	    self.wndMain:Show(false, true)

		-- if the xmlDoc is no longer needed, you should set it to nil
		-- self.xmlDoc = nil
		
		-- Register handlers for events, slash commands and timer, etc.
		-- e.g. Apollo.RegisterEventHandler("KeyDown", "OnKeyDown", self)
		Apollo.RegisterSlashCommand("dft", "OnDaFloatTextOn", self)


		-- Do additional Addon initialization here
		Apollo.RegisterEventHandler("DamageOrHealingDone", "OnDamageOrHealing", self)
	end
end

-----------------------------------------------------------------------------------------------
-- DaFloatText Functions
-----------------------------------------------------------------------------------------------
-- Define general functions here

-- on SlashCommand "/dft"
function DaFloatText:OnDaFloatTextOn()
	self.wndMain:Invoke() -- show the window
end

function DaFloatText:GetDefaultTextOption()
	local tTextOption = {
		strFontFace 				= "CRB_FloaterLarge",
		fDuration 					= 2,
		fScale 						= 0.9,
		fExpand 					= 1,
		fVibrate 					= 0,
		fSpinAroundRadius 			= 0,
		fFadeInDuration 			= 0,
		fFadeOutDuration 			= 0,
		fVelocityDirection 			= 0,
		fVelocityMagnitude 			= 0,
		fAccelDirection 			= 0,
		fAccelMagnitude 			= 0,
		fEndHoldDuration 			= 0,
		-- eLocation 					= CombatFloater.CodeEnumFloaterLocation.Top,
		eLocation                   = 0,
		fOffsetDirection 			= 90,
		fOffset 					= 4.0,
		eCollisionMode 				= CombatFloater.CodeEnumFloaterCollisionMode.Vertical,
		fExpandCollisionBoxWidth 	= 1,
		fExpandCollisionBoxHeight 	= 1,
		iUseDigitSpriteSet 			= nil,
		bUseScreenPos 				= false,
		bShowOnTop 					= false,
		fRotation 					= 0,
		fDelay 						= 0,
		nDigitSpriteSpacing 		= 0,
	}

	return tTextOption
end

function DaFloatText:OnDamageOrHealing( unitCaster, unitTarget, eDamageType, nDamage, nShieldDamaged, nAbsorptionAmount, bCritical )
	local tTextOption = self:GetDefaultTextOption()
	
	if nDamage == 0 then
		return
	end
	
	if eDamageType == GameLib.CodeEnumDamageType.Heal or eDamageType == GameLib.CodeEnumDamageType.HealShields then
		tTextOption.fScale = 1.7
		tTextOption.fDuration = 2
		tTextOption.eCollisionMode = CombatFloater.CodeEnumFloaterCollisionMode.Vertical
		tTextOption.eLocation = CombatFloater.CodeEnumFloaterLocation.Back
		tTextOption.fOffset = 4 -- GOTCHA: Different
		tTextOption.fOffsetDirection = 90
		tTextOption.strFontFace = "CRB_FloaterSmall"
		tTextOption.arFrames = {
	        [1] = { fTime = 0.0, fAlpha = 0.0, fVelocityDirection = 180, fVelocityMagnitude = 1, nColor = 0x4DDB1D, },
	        [2] = { fTime = 0.5, fAlpha = 1.0, fVelocityDirection = 180, fVelocityMagnitude = 5, nColor = 0x4DDB1D, },
	        [3] = { fTime = 1.0, fAlpha = 0.0, fVelocityDirection = 180, nColor = 0x4DDB1D, },
	    }
	elseif eDamageType == GameLib.CodeEnumDamageType.Physical or eDamageType == GameLib.CodeEnumDamageType.Magic or eDamageType == GameLib.CodeEnumDamageType.Fall  or eDamageType == GameLib.CodeEnumDamageType.Tech then
		if GameLib.IsControlledUnit(unitCaster) then
			tTextOption.fScale = 1.7
			tTextOption.fDuration = 2
			tTextOption.eCollisionMode = CombatFloater.CodeEnumFloaterCollisionMode.Vertical
			tTextOption.eLocation = CombatFloater.CodeEnumFloaterLocation.Back
			tTextOption.fOffset = 4 -- GOTCHA: Different
			tTextOption.fOffsetDirection = 90
			tTextOption.strFontFace = "CRB_FloaterSmall"
			tTextOption.arFrames = {
		        [1] = { fTime = 0.0, fAlpha = 0.0, fVelocityDirection = 180, fVelocityMagnitude = 1, nColor = 0xFFFFFF, },
		        [2] = { fTime = 0.5, fAlpha = 1.0, fVelocityDirection = 180, fVelocityMagnitude = 5, nColor = 0xFFFFFF, },
		        [3] = { fTime = 1.0, fAlpha = 0.0, fVelocityDirection = 180, nColor = 0xFFFFFF, },
		    }
		else
			tTextOption.fScale = 1.7
			tTextOption.fDuration = 2
			tTextOption.eCollisionMode = CombatFloater.CodeEnumFloaterCollisionMode.Vertical
			tTextOption.eLocation = CombatFloater.CodeEnumFloaterLocation.Back
			tTextOption.fOffset = 4 -- GOTCHA: Different
			tTextOption.fOffsetDirection = 90
			tTextOption.strFontFace = "CRB_FloaterSmall"
			tTextOption.arFrames = {
		        [1] = { fTime = 0.0, fAlpha = 0.0, fVelocityDirection = 180, fVelocityMagnitude = 1, nColor = 0xDB1D1D, },
		        [2] = { fTime = 0.5, fAlpha = 1.0, fVelocityDirection = 180, fVelocityMagnitude = 5, nColor = 0xDB1D1D, },
		        [3] = { fTime = 1.0, fAlpha = 0.0, fVelocityDirection = 180, nColor = 0xDB1D1D, },
		    }
		end
	else
		ChatSystemLib.Command("debug damage type: " .. eDamageType)
		return
	end

	CombatFloater.ShowTextFloater( GameLib.GetControlledUnit(), tostring(nDamage), tTextOption )
end

-----------------------------------------------------------------------------------------------
-- DaFloatTextForm Functions
-----------------------------------------------------------------------------------------------
-- when the OK button is clicked
function DaFloatText:OnOK()
	self.wndMain:Close() -- hide the window
end

-- when the Cancel button is clicked
function DaFloatText:OnCancel()
	self.wndMain:Close() -- hide the window
end

-----------------------------------------------------------------------------------------------
-- DaFloatText Instance
-----------------------------------------------------------------------------------------------
local DaFloatTextInst = DaFloatText:new()
DaFloatTextInst:Init()
