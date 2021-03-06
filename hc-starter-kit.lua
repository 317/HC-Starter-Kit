--[[ *************** ]]--
--[[ HC STARTER KIT - DiDay & 317 ]]--
--[[ Thanks to the kits plugin from thomasfn]]--
--[[& the one from Feramor]]--
--[[ *************** ]]--

-- Define plugin variables
PLUGIN.Title = "HC STARTER KIT"
PLUGIN.Description = "Provide optimized starter kits"

PLUGIN.configFileName = "hc_starter_kits"
PLUGIN.premium_delay = 86400 --24H
PLUGIN.PlayerData = ""
-- *******************************************
-- PLUGIN:Init()
-- Called when the plugin is initialised
-- *******************************************
function PLUGIN:Init()
	-- print(self.premium_delay)

	self:SetKitData()
	-- self.kitsRawData = util.GetDataFile(self.configFileName)
	-- if(self.kitsRawData:GetText() == "")then
	-- self:SetKitData()
	-- else
	-- self.kitsData = json.decode(self.kitsRawData:GetText())
	-- if (not self.kitsData) then
	-- error("error parsing JSON")
	-- self:SetKitData()
	-- end
	-- end

	self:AddChatCommand("starter", self.GiveKit)

end

-- *******************************************
-- PLUGIN:OnSpawnPlayer()
-- Called when the plugin is initialised
-- *******************************************
function PLUGIN:OnSpawnPlayer()

end

function PLUGIN:SetKitData()
	self.kitsData = {}  

	self.kitsData["users"] = {}

	self.kitsData["kits"] = {}
	--Content definition of the basic kit
	self.kitsData["kits"]["basic"] = {}
	self.kitsData["kits"]["basic"][1]={}
	self.kitsData["kits"]["basic"][1]["name"] = "Raw Chicken Breast"
	self.kitsData["kits"]["basic"][1]["amount"] = 5

	--Content definition of the premium kit
	self.kitsData["kits"]["premium"] = {}
	self.kitsData["kits"]["premium"][1]={}
	self.kitsData["kits"]["premium"][1]["name"] = "Stone Hatchet"
	self.kitsData["kits"]["premium"][1]["amount"] = 1

	-- self.kitsRawData = util.GetDataFile(self.configFileName)
	-- self.kitsRawData:SetText(json.encode(self.kitsData))
	-- self.kitsRawData:Save()
end

-- *******************************************
-- PLUGIN:GiveKit()
-- Function deciding which kit should be given
-- *******************************************
function PLUGIN:GiveKit(netuser, cmd, args )
	self.kitsData["users"] = {}
	getRealtimeSinceStartup= util.GetStaticPropertyGetter( UnityEngine.Time, "realtimeSinceStartup" )
	time_now = getRealtimeSinceStartup()
	--TODO: get player ID
	playerID = 41
	if(self.kitsData["users"][playerID] == nil)then
		self.kitsData["users"][playerID]={}  
		self.kitsData["users"][playerID]["date_premium"] = time_now
		self.GivePremiumKit(netuser, cmd, args)
	else
		if(self.kitsData["users"][playerID]["date_premium"]+self.premium_delay<time_now) then
			self:GivePremiumKit(netuser, cmd, args)
			self.kitsData["users"][playerID]["date_premium"] = time_now
		else
			self:GiveBasicKit(netuser, cmd, args)
		end
	end


end

-- *******************************************
-- PLUGIN:GivePremiumKit()
-- Function which gives a premium kit
-- *******************************************
function PLUGIN:GivePremiumKit(netuser, cmd, args )
	local pref = rust.InventorySlotPreference( InventorySlotKind.Default, false, InventorySlotKindFlags.Belt )
	local inv = netuser.playerClient.rootControllable.idMain:GetComponent( "Inventory" )
	for i=1, #self.kitsData["kits"]["premium"] do
		local item = self.kitsData["kits"]["premium"][i]
		inv:AddItemAmount( item["name"], item["amount"], pref )
	end
end


-- *******************************************
-- PLUGIN:GiveBasicKit()
-- Function which give the basic kit
-- *******************************************
function PLUGIN:GiveBasicKit(netuser, cmd, args )
	local pref = rust.InventorySlotPreference( InventorySlotKind.Default, false, InventorySlotKindFlags.Belt )
	local inv = netuser.playerClient.rootControllable.idMain:GetComponent( "Inventory" )
	for i=1, #self.kitsData["kits"]["basic"] do
		local item = self.kitsData["kits"]["basic"][i]
		inv:AddItemAmount( item["name"], item["amount"], pref )
	end
end
