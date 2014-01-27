--[[ *************** ]]--
--[[ HC STARTER KIT - DiDay & 317 ]]--
--[[ Thanks to the kits plugin from thomasfn]]--
--[[& the one from Feramor]]--
--[[ *************** ]]--

-- Define plugin variables
PLUGIN.Title = "HC STARTER KIT"
PLUGIN.Description = "Provide optimized starter kits"

PLUGIN.configFileName = "hc-starter-kits"
-- *******************************************
-- PLUGIN:Init()
-- Called when the plugin is initialised
-- *******************************************
function PLUGIN:Init()
  self.kitsRawData = util.GetDataFile(self.configFileName)
  if(self.kitsRawData:GetText() == "")then
    self:SetKitData()
  else
    self.kitsData = json.decode(self.kitsRawData:GetText())
      if (not self.kitsData) then
        error("error parsing JSON")
        self:SetKitData()
      end
    end
    
end

-- *******************************************
-- PLUGIN:OnSpawnPlayer()
-- Called when the plugin is initialised
-- *******************************************
function PLUGIN:OnSpawnPlayer()

end

function PLUGIN:SetKitData()
  self.kitsData = {}  
  
  --Content definition of the basic kit
  self.kitsData["basic"] = {}
  self.kitsData["basic"][1]={}
  self.kitsData["basic"][1]["name"] = "Raw Chicken Breast"
  self.kitsData["basic"][1]["amount"] = 5
  
  --Content definition of the premium kit
  self.kitsData["premium"] = {}
  self.kitsData["premium"][1]={}
  self.kitsData["premium"][1]["name"] = "Stone Hatchet"
  self.kitsData["premium"][1]["amount"] = 1
  
  self.kitsRawData = util.GetDataFile(self.configFileName)
  self.kitsRawData:SetText(json.encode(self.kitsData))
  self.kitsRawData:Save()
end

-- *******************************************
-- PLUGIN:GiveKit()
-- Function deciding which kit should be given
-- *******************************************
function PLUGIN:GiveKit(netuser, cmd, args )

end

-- *******************************************
-- PLUGIN:GiveKit()
-- Function which gives a premium kit
-- *******************************************
function PLUGIN:GivePremiumKit(netuser, cmd, args )

end

-- *******************************************
-- PLUGIN:GiveKit()
-- Function which give the basic kit
-- *******************************************
function PLUGIN:GiveBasicKit(netuser, cmd, args )

end
