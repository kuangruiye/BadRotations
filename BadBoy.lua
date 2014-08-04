function BadBoyRun()

	if BadBoy_data == nil then BadBoy_data = {
		["Power"] = 1,
		["Currentconfig"] = " ",
		["Pause"] = 0,
		["frameShown"] = true,
		["anchor"] = "BOTTOM",
		["x"] = -20,
		["y"] = 130.0000061548516,

		["configShown"] = true,
		["configanchor"] = "RIGHT",
		["configx"] = -140,
		["configy"] = -135,
		["configWidth"] = 250,

		["AoE"] = 3,
		["Cooldowns"] = 2,
		["Defensive"] = 1,
		["Interrupts"] = 1,

		["Check Debug"] = 0,
		["Check PokeRotation"] = 0,
	}; end

	-- Run once.
	ReaderRun();
	-- Globals
	if badboyColors == nil then
		BadBoy_Colors = {
			["Black"]		= {B=0.1, 	G=0.1,	R=0.12,	Hex="|cff191919"},
			["Hunter"]		= {B=0.45,	G=0.83,	R=0.67,	Hex="|cffabd473"},
			["Gray"]		= {B=0.2,	G=0.2,	R=0.2,	Hex="|cff333333"},
			["Warrior"]		= {B=0.43,	G=0.61,	R=0.78,	Hex="|cffc79c6e"},
			["Paladin"] 	= {B=0.73,	G=0.55,	R=0.96,	Hex="|cfff58cba"},
			["Mage"]		= {B=0.94,	G=0.8,	R=0.41,	Hex="|cff69ccf0"},
			["Priest"]		= {B=1,		G=1,	R=1,	Hex="|cffffffff"},
			["Warlock"]		= {B=0.79,	G=0.51,	R=0.58,	Hex="|cff9482c9"},
			["Shaman"]		= {B=0.87,	G=0.44,	R=0,	Hex="|cff0070de"},
			["DeathKnight"]	= {B=0.23,	G=0.12,	R=0.77,	Hex="|cffc41f3b"},
			["Druid"]		= {B=0.04,	G=0.49,	R=1,	Hex="|cffff7d0a"},
			["Monk"]		= {B=0.59,	G=1,	R=0,	Hex="|cff00ff96"},
			["Rogue"]		= {B=0.41,	G=0.96,	R=1,	Hex="|cfffff569"}
		}
	end

	---------------------------------
	-- Macro Toggle ON/OFF
	SLASH_BadBoy1 = "/BadBoy"
	function SlashCmdList.BadBoy(msg, editbox)
		if badboyStarted == true then
			print("BadBoy Disabled.");
			badboyStarted = false;
			mainFrame:Hide();
		else
			print("BadBoy Enabled.");
			badboyStarted = true;
			mainFrame:Show();
		end
	end

	SLASH_AoE1 = "/aoe"
	function SlashCmdList.AoE(msg, editbox)
		ToggleAoE();
	end

	SLASH_Cooldowns1 = "/Cooldowns"
	function SlashCmdList.Cooldowns(msg, editbox)
		if BadBoy_data['Cooldowns'] == 1 then
	        ChatOverlay("\124cFF3BB0FFCooldowns Activated");
			BadBoy_data['Cooldowns'] = 2;
		else
	        ChatOverlay("\124cFFED0000Cooldowns Disabled");
			BadBoy_data['Cooldowns'] = 1;
		end
	end

	SLASH_Pause1 = "/Pause"
	function SlashCmdList.Pause(msg, editbox)
		if BadBoy_data['Pause'] == 0 then
	        ChatOverlay("\124cFFED0000 -- Paused -- ");
			BadBoy_data['Pause'] = 1;
		else			
	        ChatOverlay("\124cFF3BB0FF -- Pause Removed -- ");
			BadBoy_data['Pause'] = 0;
		end
	end

	SLASH_Power1 = "/Power"
	function SlashCmdList.Power(msg, editbox)
		if BadBoy_data['Power'] == 0 then
	        ChatOverlay("\124cFF3BB0FF -- BadBoy Enabled -- ");
			BadBoy_data['Power'] = 1;
		else			
	        ChatOverlay("\124cFFED0000 -- BadBoy Disabled -- ");
			BadBoy_data['Power'] = 0;
		end
	end

	function GetSpellCD(MySpell)
		if GetSpellCooldown(MySpell) == 0 then
			return 0
		else
			local Start ,CD = GetSpellCooldown(MySpell)
			local MyCD = Start + CD - GetTime()
			return MyCD
		end
	end


--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]

	-- Mettre a jour les valeurs chaque frame.
	function FrameUpdate(self, elapsed)
		profileStarts = GetTime();
		UIUpdate();

		-- And to update our users Health and Sort :)
		if NovaEngineUpdate == nil then NovaEngineUpdate = GetTime(); end
		if BadBoy_data["Check Interrupts"] == 1 and NovaEngineUpdate and NovaEngineUpdate <= GetTime() - 0.5 then
			NovaEngineUpdate = GetTime()
			nNova:Update()
			--ScanObjects();
		end

		
		-- Runs every tick.
		--ToolTipEngine();
		--Interrupts();


		local _, _, anchor, x, y = mainFrame:GetPoint(1);
		BadBoy_data.x = x;
		BadBoy_data.y = y;
		BadBoy_data.anchor = anchor;

		local _, _, anchor, x, y = configFrame:GetPoint(1);
		BadBoy_data.configx = x;
		BadBoy_data.configy = y;
		BadBoy_data.configanchor = anchor;

		--local _, _, anchor, x, y = pokeValueFrame:GetPoint(1);
		--BadBoy_data.pokeValuex = x;
		--BadBoy_data.pokeValuey = y;
		--BadBoy_data.pokeValueanchor = anchor;

			PokeEngine();
			local _MyClass = select(3,UnitClass("player"));
			local _MySpec = GetSpecialization("player");
			if _MyClass == 1 then -- Warrior
				--Warrior()
			elseif _MyClass == 2 then -- Paladin
				if _MySpec == 2 then
					PaladinProtection()
				end
			elseif _MyClass == 3 then -- Hunter
				Hunter();
			elseif _MyClass == 4 then -- Rogue
				--Rogue()
			elseif _MyClass == 5 then -- Priest
				--Priest()
			elseif _MyClass == 6 then -- Deathknight
				--Deathknight()
			elseif _MyClass == 7 then -- Shaman
				if _MySpec == 1 then
					ShamanElemental();
				end
				if _MySpec == 2 then
					ShamanEnhancement();
				end	
				--Shaman()		
			elseif _MyClass == 8 then -- Mage
				--Mage()		
			elseif _MyClass == 9 then -- Warlock
				--Warlock()		
			elseif _MyClass == 10 then -- Monk
				--Monk()						
			elseif _MyClass == 11 then -- Druid
				Druid()
			end

	end

--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]

	BadBoyEngine();
	BadBoyMinimapButton();
	BadBoyFrame();
	ConfigFrame();
	ChatOverlay("-= BadBoy Loaded =-")
end
