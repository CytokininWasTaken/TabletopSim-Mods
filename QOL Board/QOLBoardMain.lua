local version = "[@1.0.0@]"

--fat script section!!

decktoolScript = {
    [[local assets = {
      {name = "modeText",url="http://cloud-3.steamusercontent.com/ugc/1839166905722132101/B80C3FE45AE7884AD131A11D9ABD386A78A8BF1F/"},
      {name = "modeButtons",url="http://cloud-3.steamusercontent.com/ugc/1839166905722131985/CE3145BCFB76FE148174040FB687FC7A856E55DE/"},

      {name = "buttons",url="http://cloud-3.steamusercontent.com/ugc/1842544393867541186/25F1329F1764ECDCECA06EBC2A8C67AAE55DD6FE/"},
      {name = "buttonHighlight",url="http://cloud-3.steamusercontent.com/ugc/1842544393867463273/45B6571036897A284D51BC72EE39DC87BE10BD75/"},
    }

    local textSize = 121.5
    local pad = 0

    local uiElements = {
      --board base
      {
        tag = "Image",
        attributes = {
          image = "toolBase",
          id = "toolBaseID",
          position = "0 0 -12",
          width = "0.81%",
          height = "2%",
          rotation = "0 0 180",
          active = "False",
          raycastTarget ="False",
        },
      },
      --buttons
      {
        tag = "Image",
        attributes = {
          image = "buttons",
          id = "buttonsID",
          position = "75 -5.25 -5",
          width = "70",
          height = "170",
          rotation = "0 0 180",
          raycastTarget ="False",
        },
      },
      {
        tag = "Image",
        attributes = {
          image = "buttonHighlight",
          id = "buttonHighlightID",
          position = "75 -70 -10",
          width = "70",
          height = "40",
          rotation = "0 0 180",
          raycastTarget ="False",
        },
      },

      --buttons
      {
        tag="Button",
        attributes = {
          id = "loadModeButtonID",
          position = "75 -70 0",
          width = "70",
          height = "40",
          rotation = "0 0 180",
          colors = "#00000000|#00000000|#00000000",
          onClick = "loadMode",
        },
      },
      {
        tag="Button",
        attributes = {
          id = "searchModeButtonID",
          position = "75 -27 0",
          width = "70",
          height = "40",
          rotation = "0 0 180",
          colors = "#00000000|#00000000|#00000000",
          onClick = "searchMode",
        },
      },
      {
        tag="Button",
        attributes = {
          id = "conflictModeButtonID",
          position = "75 16 0",
          width = "70",
          height = "40",
          rotation = "0 0 180",
          colors = "#00000000|#00000000|#00000000",
          onClick = "conflictMode",
        },
      },
      {
        tag="Button",
        attributes = {
          id = "modelModeButtonID",
          position = "75 59 0",
          width = "70",
          height = "40",
          rotation = "0 0 180",
          colors = "#00000000|#00000000|#00000000",
          onClick = "modelMode",
        },
      },
      {
        tag="Button",
        attributes = {
          id = "activateID",
          position = "0 88.5 -13",
          width = "75",
          height = "17.5",
          rotation = "0 0 180",
          colors = "#00000000|#00000000|#00000000",
          onClick = "loadFunction",
        },
      },
      {
        tag="InputField",
        attributes = {
          id = "inputID",
          position = "0 60.5 -13",
          width = "75",
          height = "26",
          rotation = "0 0 180",
          colors = "#00000000|#00000000|#00000000|#00000000|#00000000|#00000000",
          onValueChanged = "inputEditFunc",
          onEndEdit = "inputEndFunc",
        },
      },
      {
        tag="Text",
        attributes = {
          text = "...",
          id = "inputTextID",
          position = "0 60.5 -13",
          scale = "0.1 0.1 0.1",
          rotation = "0 0 180",
          color = "#FFFFFF",

          fontSize = "200",
          raycastTarget = "False",
        },
      },

      --
      {
        tag="Mask",
        attributes = {
          id = "modeTextMaskID",
          position = "0 0 -12",
          width = "0.81%",
          height = "2%",
          rotation = "0 0 180",
          raycastTarget ="False",
        },
        children = {
          {
            tag = "Image",
            attributes = {
              image = "modeText",
              id = "modeTextID",
              position = tostring(textSize+pad).." 0 0",
              width = "400%",
              height = "100%",
              raycastTarget ="False",
            },
          },
          {
            tag = "Image",
            attributes = {
              image = "modeButtons",
              id = "modeButtonsID",
              position = tostring(textSize+pad).." -87.5 0",
              width = "400%",
              height = "12.5%",
              raycastTarget ="False",
            },
          },
        }
      },
    }

    function inputEditFunc(player,input)
      local fontSize = math.floor(math.min(200/(#input*0.16),200))
      self.UI.setAttribute("inputTextID", "text", input)
      self.UI.setAttribute("inputTextID", "fontSize", tostring(fontSize))
      self.setDescription(input)
    end

    function inputEndFunc(player,input)
      if input == "" then
        self.UI.setAttribute("inputTextID", "text", "...")
        self.UI.setAttribute("inputTextID", "fontSize", "200")
      end
    end

    local posT = {121.5,-40.5,40.5,121.5,-121.5}
    function setInfo(mode)
      local pos = tostring(textSize - ((textSize*2)/3)*(mode-1)+pad)
      self.UI.setAttribute("modeTextID", "position", pos.." 0 0")
    end
    function setButton(mode)
      local pos = posT[mode]
      self.UI.setAttribute("modeButtonsID", "position", pos.." -87.5 0")
    end

    local zones = {"ce4312","4d7853","59e600","c788ce","001a84"}
    local tagzones = {
      ["Starter Card"] = "ce4312",
      ["Weak Encounter Card"] = "4d7853",
      ["Moderate Encounter Card"] = "59e600",
      ["Strong Encounter Card"] = "c788ce",
      ["Legendary Encounter Card"] = "001a84",
      ["Evolution Card"] = "ae4239",
      ["Galactic Grunt"] = "70f2bd",
      ["Galactic Commander"] = "c84564",
      ["Galactic Boss"] = "4cfdfd",
      ["Noble Encounter Card"] = "001a84",
      ["Ultra Beast Encounter Card"] = "001a84",
      ["Ultra Burst Encounter Card"] = "001a84",
    }

    local modelBags = {"a24e11","0c2ce1"}

    function color(r,g,b,a)
      return {r/255,g/255,b/255,a/255}
    end
    local defaultCol = color(72,50,78,0)--color(150,75,50,200)
    local selectedCol = color(120,80,120,0)--color(183,89,51,255)
    local defScale = {x=0.1, y=0.1, z=0.1}
    local defFontCol = {1,1,1,255}
    local selectedMode = 1
    local attachedCube

    local foundCards
    local conflicts

    function inputFunction(obj, color, input, stillEditing)
        self.setDescription(input)
    end

    function resetBlock()
      local block = getObjectFromGUID(self.getGMNotes())
      block.jointTo()
      block.setPosition(self.getPosition()+Vector(1.4,0.05,0))
      block.setScale({0.1, 0.1, 6})
      block.jointTo(self,{type = "Fixed", collision = false})
    end

    function scaleBlock(width)
      local block = getObjectFromGUID(self.getGMNotes())
      block.jointTo()
      local currentScale = block.getScale()
      block.setScale({width*3,currentScale.y,currentScale.z})

      local x = (1.85 + 0.5*(width*3-1))
      block.setPosition(self.getPosition()+Vector(x+0.01,0.05,0))
      block.jointTo(self,{type = "Fixed", collision = false})
    end

    function spawnBlock()
      if not getObjectFromGUID(self.getGMNotes()) then
        attachedCube = spawnObject({
          type = "BlockSquare",
          position = self.getPosition()+Vector(1.4,0.05,0),
          scale = {0.1, 0.1, 6},
          sound = false,
          callback_function = function(me) me.setLuaScript("function onUpdate() if not getObjectFromGUID(self.getDescription()) then self.destruct() end end") end,
        })

        attachedCube.setDescription(self.guid)
        attachedCube.jointTo(self,{type = "Fixed", collision = false,})
        attachedCube.setColorTint(color(50,50,60,255))
        attachedCube.interactable = false
        attachedCube.mass = 0
        self.setGMNotes(tostring(attachedCube.guid))
      end
    end

    function onLoad(saveData)


      self.UI.setCustomAssets(assets)
      self.UI.setXmlTable(uiElements)

      spawnBlock()
      Wait.frames(loadMode,5)

      self.setSnapPoints(JSON.decode('[{"position":{"x":0,"y":0,"z":-0.28325},"rotation":{"x":-0,"y":0,"z":-0},"rotation_snap":true,"tags":[]}]'))
    end

    local indices = {load=2,search=3,conflict=4,model=5}

    function highlight(index)
      self.UI.setAttribute("buttonHighlightID","position","75 "..tostring(-70+43.3*(index-2)).." -10")
    end

    function none() end

    local modes = {"deckModeID","searchModeID","conflictModeID","modelModeID"}
    function resetButtons()
      for _, name in ipairs(modes) do
        self.UI.setAttribute(name, "active", "False")
      end
      self.setDescription("")
      removeConflictButtons()
      resetColour()
    end

    --
    function getLine(string,line)
      local iter = 0
      for s in string:gmatch("[^\r\n]+") do
        iter = iter+1
        if iter == 2 then
          return s
        end
      end
    end

    function getInternalName(object)
      return string.match(getLine(object.lua_script), 'internal_name = "([^"]+)')
    end

    function has(t,s)
      for _, value in pairs(t) do
        if s == value then return true end
      end
    end

    function fuzzyHas(t,s)
      for _, value in pairs(t) do
        if string.find(value, s) then return true end
      end
    end
    --

    --SEARCH DECKS
    function searchMode()
      selectedMode = 2
      setInfo(selectedMode)
      setButton(selectedMode)
      highlight(indices.search)

      self.UI.setAttribute("searchModeID", "active", "True")
      self.UI.setAttribute("activateID","onClick","searchFunction")
    end

    function hasCards(obj)
      local found = Physics.cast({origin=obj.getPosition(),direction=Vector(0,1,0)})
      for _, hit in ipairs(found) do
        if hit.hit_object.name == "Deck" or hit.hit_object.name == "Card" then
          return hit.hit_object
        end
      end
    end

    function searchFunction()
      local on = hasCards(self)
      if on then
        if on.name == "Card" then
          handleCard(on)
        else
          distributingDeck = on
          startLuaCoroutine(self,"loadCoroutine")
        end
      elseif self.getDescription() ~= "" then
        for i, guid in ipairs(zones) do
          local zone = getObjectFromGUID(guid)
          for _, object in pairs(zone.getObjects()) do
            if object.name == "Deck" then
              for _, card in pairs(object.getObjects()) do
                if string.find(card.name,self.getDescription()) then
                  object.takeObject({guid=card.guid,position=self.getPosition()+Vector(0,0.5,0.9)})
                end
              end
            end
          end
        end
      end
    end

    ----

    --LOAD DECKS "loadFunction"
    distributingDeck = nil
    function loadMode()
      selectedMode = 1
      setInfo(selectedMode)
      setButton(selectedMode)
      highlight(indices.load)
      self.UI.setAttribute("deckModeID", "active", "True")
      self.UI.setAttribute("activateID","onClick","loadFunction")
    end

    function drawCard(obj)
      local card = obj.takeObject()
      if obj.remainder then return card, obj.remainder else return card, nil end
    end

    function tagCard(card)
      local description = self.getDescription()
      if not card.hasTag("_TAGGED") then
        if description:lower() == "vanilla" then
          card.addTag("Vanilla")
          card.addTag("_TAGGED")
          card.setDescription(card.getDescription().."\n".."Source: Vanilla")
        else
          local str = "Expansion: "..((description ~= "" and description) or "Unknown")
          card.addTag(str)
          card.addTag("_TAGGED")
          card.setDescription(card.getDescription().."\n".."Source: "..str)
        end
      end
    end

    function getZone(object)
      for key, value in pairs(tagzones) do
        if object.hasTag(key) then
          return getObjectFromGUID(value)
        end
      end
    end

    function putInZone(card)
      local zone = getZone(card)
      if zone then
        card.setPosition(zone:getPosition() + Vector(0, 2.5, 0))
        card.setRotation(zone:getRotation())
      else
        card.setPosition(self.getPosition()+Vector(3,1,0))
      end
    end

    function handleCard(card)
      tagCard(card)
      putInZone(card)
    end

    function loadCoroutine()
      if not distributingDeck then
        coroutine.yield(1)
      else
        repeat
          card, remainder = drawCard(distributingDeck)
          handleCard(card)
          coroutine.yield(0)
        until remainder
        handleCard(remainder)
      end
      coroutine.yield(1)
    end

    function loadFunction()
      local hit = Physics.cast({origin = self.getPosition(),direction=Vector(0,1,0)})
      for i, object in ipairs(hit) do
        if object.hit_object.name == "Deck" then
          distributingDeck = object.hit_object
          startLuaCoroutine(self,"loadCoroutine")
        elseif object.hit_object.name == "Card" then
          handleCard(object.hit_object)
        end
      end

    end

    ----

    --RESOLVE CONFLICTS


    function conflictMode()
      selectedMode = 3
      setInfo(selectedMode)
      setButton(selectedMode)
      highlight(indices.conflict)
      self.UI.setAttribute("conflictModeID", "active", "True")
      self.UI.setAttribute("activateID","onClick","conflictFunction")
    end

    function removeButtons()
      local buttons = self.getButtons()
      if buttons then
        for i = 1,#buttons do
          self.removeButton(i-1)
        end
      end
    end

    function getExpansion(tags)
      for i, tag in ipairs(tags) do
        if string.lower(tag) == "vanilla" then
          return "Vanilla"
        elseif string.find(tag,"Expansion: ") then
          return string.gsub(tag,"Expansion: ","")
        end
      end
    end

    function discardResolved(obj)
      obj.setPosition({46,4,23})
    end

    local drawn
    local currentConflict
    local resolutionRules = {}

    function chooseCard(object)
      for i, value in ipairs(drawn) do
        value.removeButton(0)
        if value ~= object then
          discardResolved(value)
        end
      end
      drawn = nil
      conflicts[currentConflict] = nil
      placeConflict()
      resolutionRules[currentConflict] = getExpansion(object.getTags())
      putInZone(object)
    end

    function resolveEvolution()
      local evoCards = {}
      local evoConflicts = {}
      local evolutionDeck
      local zone = getObjectFromGUID(tagzones["Evolution Card"])
      for _, obj in ipairs(zone.getObjects()) do
        if obj.name == "Deck" then
          evolutionDeck = obj
          break
        end
      end

      for _, card in ipairs(evolutionDeck.getObjects()) do
        local name = getInternalName(card)
        if evoCards[name] then
          evoConflicts[name] = evoConflicts[name] or {evoCards[name]}
          table.insert(evoConflicts[name],{guid=card.guid,tags=card.tags,deck=evolutionDeck.guid})
        else
          evoCards[name] = {guid=card.guid,tags=card.tags,deck=evolutionDeck.guid}
        end
      end

      for name, data in pairs(evoConflicts) do
        if resolutionRules[name] then
          for i, deckCard in ipairs(data) do
            local deck = getObjectFromGUID(deckCard.deck)
            local card = deck.takeObject({guid=deckCard.guid})
            if (getExpansion(deckCard.tags) == resolutionRules[name]) then
              putInZone(card)
            else
              discardResolved(card)
            end
          end
        end
      end
    end

    function placeConflict()
      local iter = 0
      for name, data in pairs(conflicts) do
        iter = iter + 1
        currentConflict = name

        scaleBlock(#data)
        removeButtons()
        drawn = {}
        for i = 1,#data do

          local deck = getObjectFromGUID(data[i].deck)
          table.insert(drawn,deck.takeObject({
            guid = data[i].guid,
            position = self.getPosition()+Vector({2.85+3*(i-1), 0.5, 0.2}),
            rotation = self.getRotation(),
            smooth = false,
          }))
          drawn[i].createButton({
            label = "Choose",
            position = Vector({0, 0.5, 1.75}),
            click_function = "chooseCard",
            function_owner = self,
            font_color = defFontCol,
            color = selectedCol,
            scale = {0.25,0.25,0.2},
            font_size = 800,
            height = 1000,
            width = 3000,
          })
          self.createButton({
            label = getExpansion(drawn[i].getTags()),
            position = {0.875*i, 0.15, -0.82},
            click_function = "none",
            font_color = defFontCol,
            color = selectedCol,
            scale = defScale,
            font_size = 600,
            height = 0,
            width = 0,
          })
        end
        break
      end
      if iter == 0 then
        conflicts = nil
        resetBlock()
        resolveEvolution()
        removeButtons()
      end
    end

    function conflictFunction()
      foundCards,conflicts = {},{}
      for _, id in ipairs(zones) do
        local zone = getObjectFromGUID(id)
        if zone then
          for __, obj in ipairs(zone.getObjects()) do
            if obj.name == "Deck" then -- make sure it is a deck
              for ___, deckCard in ipairs(obj.getObjects()) do
                local name = getInternalName(deckCard)
                if foundCards[name] and not has(deckCard.tags,"Noble") then
                  conflicts[name] = conflicts[name] or {foundCards[name]}
                  table.insert(conflicts[name],{guid=deckCard.guid,deck=obj.guid,tags=deckCard.tags})
                else
                  foundCards[name] = {guid=deckCard.guid,deck=obj.guid,tags=deckCard.tags}
                end
              end
            end
          end
        end
      end
      local desc = self.getDescription()
      if desc == "" then
        placeConflict()
      else
        for name, value in pairs(conflicts) do
          for _, thing in ipairs(value) do
            local tag = getExpansion(thing.tags)
            local deck = getObjectFromGUID(thing.deck)
            local card = deck.takeObject({guid=thing.guid})
            if has(thing.tags,tag) then
              putInZone(card)
              resolutionRules[name] = tag
            else
              discardResolved(card)
            end
          end
        end
        resolveEvolution()
      end
    end

    ----

    --Load Models

    function modelMode()
      selectedMode = 4
      setInfo(selectedMode)
      setButton(selectedMode)
      highlight(indices.model)
      self.UI.setAttribute("modelModeID", "active", "True")
      self.UI.setAttribute("activateID","onClick","modelFunction")
    end

    function placeModel(model)
      local bag1,bag2 = getObjectFromGUID(modelBags[1]),getObjectFromGUID(modelBags[2])
      model.addTag("Pokemon Model")
      model.setPosition(bag1.getPosition()+Vector(0,0,3))
      local clone = model.clone({position=bag2.getPosition()+Vector(0,0,-3)})
      bag1.putObject(model)
      bag2.putObject(clone)
    end

    local modelContainer
    function modelPlaceCoroutine()
      while modelContainer and modelContainer.getQuantity()>0 do
        local arenaobj = getObjectFromGUID("fb55ee")
        placeModel(modelContainer.takeObject({index=0,position = arenaobj.getPosition()+Vector(0,2,0)}))
        coroutine.yield(0)
      end
      modelContainer.destroy()

      return 1
    end

    function modelFunction()
      local hit = Physics.cast({
        origin       = self.getPosition()+Vector(0,1.15,1),
        direction    = Vector(0,1,0),
        type         = 3,
        size         = {2,2,2},
      })

      for k, v in pairs(hit) do
        local hit = v.hit_object
        if hit.name == "Bag" then
          modelContainer = hit
          startLuaCoroutine(self, "modelPlaceCoroutine")
        elseif string.find(hit.name, "Custom_Assetbundle") then
          placeModel(hit)
        end
      end
    end

    --ONUPDATE LOOP
    local t = 0
    function onUpdate()
      if selectedMode == 2 then
        t = t+1
        if t%30==0 then
          if hasCards(self) then
            setButton(5)
          else
            setButton(2)
          end
        end
      end
    end
    ----

  ]]
}
ballCraftScript = {
    [[function pointWithTag(tag)
    for i, point in ipairs(self.getSnapPoints()) do
      for _, t in pairs(point.tags) do
        if t == tag then
          return point
        end
      end
    end
  end

  function regular()
    local bag = getObjectFromGUID("4236c0")
    local points = self.getSnapPoints()
    local p = pointWithTag("Regular")
    bag.takeObject({rotation=self.getRotation(),position = self.positionToWorld(p.position)+Vector(0,2,0),smooth=false}).use_hands = true
  end

  function great()
    local bag = getObjectFromGUID("adaf28")
    local points = self.getSnapPoints()
    local p = pointWithTag("Greater")
    bag.takeObject({rotation=self.getRotation(),position = self.positionToWorld(p.position)+Vector(0,2,0),smooth=false}).use_hands = true
  end

  function ultra()
    local bag = getObjectFromGUID("768e7a")
    local points = self.getSnapPoints()
    local p = pointWithTag("Ultimate")
    bag.takeObject({rotation=self.getRotation(),position = self.positionToWorld(p.position)+Vector(0,2,0),smooth=false}).use_hands = true
  end

  function keystone()
    local bag = getObjectFromGUID("147ebc")
    local points = self.getSnapPoints()
    local p = pointWithTag("Keystone")
    bag.takeObject({rotation=self.getRotation(),position = self.positionToWorld(p.position)+Vector(0,2,0),smooth=false}).use_hands = true
  end

  function onLoad()
    self.setSnapPoints(JSON.decode('[{"position":{"x":0.101357251405716,"y":0.195000559091568,"z":-0.7026047706604},"rotation":{"x":9.82548385763948E-07,"y":-9.81325277656965E-15,"z":-1.14448914700915E-06},"rotation_snap":true,"tags":["Ball Token","Regular"]},{"position":{"x":0.101449057459831,"y":0.195000529289246,"z":-0.229821920394897},"rotation":{"x":9.82548385763948E-07,"y":-9.81325277656965E-15,"z":-1.14448914700915E-06},"rotation_snap":true,"tags":["Ball Token","Greater"]},{"position":{"x":0.10204254090786,"y":0.195000499486923,"z":0.241576105356216},"rotation":{"x":9.82548385763948E-07,"y":-9.81325277656965E-15,"z":-1.14448914700915E-06},"rotation_snap":true,"tags":["Ball Token","Ultimate"]},{"position":{"x":0.101376764476299,"y":0.195000469684601,"z":0.714220762252808},"rotation":{"x":9.82548385763948E-07,"y":-9.81325277656965E-15,"z":-1.14448914700915E-06},"rotation_snap":true,"tags":["Ball Token","Keystone"]}]'))

    self.createButton({
      label="",
      click_function="regular",
      function_owner=self,
      position={0.2,0.2,-0.71},
      rotation={0,0,0},
      height=1850,
      width=900,
      scale={x=0.1, y=0.1, z=0.1},
      color = {0,0,0,0}
    })

    self.createButton({
      label="",
      click_function="great",
      function_owner=self,
      position={0.2,0.2,-0.235},
      rotation={0,0,0},
      height=1850,
      width=900,
      scale={x=0.1, y=0.1, z=0.1},
      color = {0,0,0,0}
    })

    self.createButton({
      label="",
      click_function="ultra",
      function_owner=self,
      position={0.2,0.2,0.235},
      rotation={0,0,0},
      height=1850,
      width=900,
      scale={x=0.1, y=0.1, z=0.1},
      color = {0,0,0,0}
    })

    self.createButton({
      label="",
      click_function="keystone",
      function_owner=self,
      position={0.2,0.2,0.71},
      rotation={0,0,0},
      height=1850,
      width=900,
      scale={x=0.1, y=0.1, z=0.1},
      color = {0,0,0,0}
    })
  end]]
}
trackerObjScript = {
    [[local snapPos = '[{"position":{"x":0.600000023841858,"y":-0.200000002980232,"z":0.0500000007450581},"rotation":{"x":0,"y":0,"z":0},"rotation_snap":true,"tags":["Held Item"]},{"position":{"x":-0.743456065654755,"y":0.209307178854942,"z":-0.577698349952698},"rotation":{"x":-2.65765766016557E-06,"y":0.0163007471710444,"z":-2.06739446184656E-06},"rotation_snap":true,"tags":["Health Tracker"]},{"position":{"x":-0.74199640750885,"y":0.209307476878166,"z":-0.30115869641304},"rotation":{"x":-3.724092266566E-06,"y":359.992340087891,"z":-1.91761546375346E-06},"rotation_snap":true,"tags":["Initiative Tracker"]}]'
    local assets = {
      {name="trackerMask",url="http://cloud-3.steamusercontent.com/ugc/1836913203205517113/44A050F942B40E73CD2AD9F6486C5025E83D7F90/"},
      {name="trackerNumNew",url="http://cloud-3.steamusercontent.com/ugc/1836913203206418880/D55A0C40FBBABC5A805D11251BA94C783FE6BA89/"},
      {name="healthbarMask",url="http://cloud-3.steamusercontent.com/ugc/1842544061851029187/FE629955EF82E1253D7327119697783A46DAAD35/"},
      {name="healthbarFrame",url="http://cloud-3.steamusercontent.com/ugc/1842544061852377179/10BD573AA41B056576C460E4BAFC2CE91F7A770D/"},
      {name="healthbarFill",url="http://cloud-3.steamusercontent.com/ugc/1842544061851029086/EAE737E1D33BF5151FD1B304F2EB7D075742191E/"},
      {name="healthbarFillOver",url="http://cloud-3.steamusercontent.com/ugc/1842544061856788162/681DB56F55CC52BC70C2851043210623E242472D/"},
    }

    local xmlformat = '<Mask id="trackerMask" width="500" height="190" active="true" position="65 0 -1" raycastTarget="False">    <Image id="trackerImageS1" image="trackerNumNew" width="148" height="1928" color="#FFFFFFFF" position="45 -287.8 -0.01" rotation="0 0 180" raycastTarget="False" active="True" />    <Image id="trackerImageD1" image="trackerNumNew" width="120.25" height="1566.5" color="rgb(1,1,1,1)" position="95 0 -0.01" rotation="0 0 180" raycastTarget="False" active="False" />    <Image id="trackerImageD2" image="trackerNumNew" width="120.25" height="1566.5" color="rgb(1,1,1,1)" position="-25 0 -0.01" rotation="0 0 180" raycastTarget="False" active="False" /></Mask><Image id="healthbarFrameID" image="healthbarFrame" width="2100" height="200" position="755 -1300 0" rotation="0 0 180" raycastTarget="False" active="False">    <Mask id="healthbarMask" width="100%" height="100%" position="2.27373675443232E-13 0 0" rotation="0 0 180" raycastTarget="False">        <Image image="healthbarFill" id="healthbarFillID" width="100%" height="100%" position="2.27373675443232E-13 0 0" rotation="0 0 180" raycastTarget="False" color="rgba(0.352941176470588,0.784313725490196,0.352941176470588)" />    </Mask>    <Mask id="healthbarMaskOver" width="100%" height="100%" position="-2000 0 0" rotation="0 0 180" raycastTarget="False">        <Image image="healthbarFillOver" id="healthbarOverFillID" width="100%" height="100%" position="-2000 0 0" rotation="0 0 180" color="rgba(0,0,1,0.25)" raycastTarget="False" />    </Mask></Image>'

    local type = "health"
    local lastValue

    if self.getCustomObject().thickness > 0.01 then
      self.setCustomObject({thickness=0.01})
      self.reload()
    end

    local min,max,value = 0,99,0
    function onLoad()
      self.createButton({
        label="",
        click_function="counterFunction",
        function_owner=self,
        position={-1,0.005,0.1},
        rotation={0,0,0},
        height=350,
        width=350,
        font_size=450,
        scale={x=3, y=3, z=3},
        font_color={0,0,0,255},
        color = {0,0,0,0}
      })

      self.UI.setCustomAssets(assets)

      if self.hasTag("Health Tracker") then
        self.addContextMenuItem("Toggle Health Bar", toggleHealthbar)
        Wait.frames(updateValue,10)
        --Wait.frames(toggleHealthbar,5)
      end

      self.mass = 0
      self.UI.setXml(xmlformat,assets)
    end

    function toggleHealthbar()
      if self.UI.getAttribute("healthbarFrameID", "active") == "True" then
        self.UI.setAttribute("healthbarFrameID", "active", "False")
      else
        self.UI.setAttribute("healthbarFrameID", "active", "True")
      end
    end

    function getVal(o)
      return tonumber(o.getName()) or 0
    end

    function getVerticalPosition(value,heightmod)
      if value < 10 then
        local height = 2410 * heightmod
        local m = height/2
        local base = m
        local add = m - height/10 * value
        return add
      end
    end

    function getValueColor(value)
      local base = tonumber(self.getDescription())
      if base then
        if value > base then
          return "#5AC85AFF"
        elseif value < base then
          return "#D74B4BFF"
        else
          return "#FFFFFFFF"
        end
      end
    end

    function getCardValue(card)
      local type,number = "health", tonumber(self.getDescription())
      if self.hasTag("Initiative Tracker") then type = "initiative" end
      if not number then
        local grabbed = card.getVar(type)
        self.setDescription(grabbed)
        self.setName(grabbed)
        setNumbers()
      end
    end

    function facingUp(object)
      local up = object.getTransformUp().y
      local modifiedUp
      local mult = 1
      if up < 0 then modifiedUp,mult = up*-1,-1 else modifiedUp = up end
      return math.ceil(modifiedUp)*mult == 1
    end

    function inTable(thing,table) for _, m in ipairs(table) do if thing == m then return true end end end

    function getNumber(st)
      for w in st:gmatch("%S+") do return w end
    end

    function transitionHealthBars()
      local oldOverPos = self.UI.getAttribute("healthbarMaskOver", "position")
      local base = tonumber(self.getDescription()) or 1
      local overFraction = math.min((value-base) / base,1)
      local newOverPos = "-"..tostring(2000-2000*overFraction).." 0 0"


      local oldPos = self.UI.getAttribute("healthbarMask", "position")
      local fraction = math.min(value / base,1)
      if fraction < 0.05 then fraction = 0 elseif fraction > 0.99 then fraction = 1 end
      local bfraction = 1-fraction
      local newPos = "-"..tostring(2000-2000*fraction).." 0 0"
      local maxCol = {90,200,90}
      local minCol = {215,75,75}
      local new = {
        math.floor((maxCol[1]*fraction+minCol[1]*bfraction))/255,
        math.floor((maxCol[2]*fraction+minCol[2]*bfraction))/255,
        math.floor((maxCol[3]*fraction+minCol[3]*bfraction))/255,
      }
      local col = "rgba("..tostring(new[1])..","..tostring(new[2])..","..tostring(new[3])..")"
      local smooth = 30
      for i = 1,smooth do
        local oP = getNumber(oldPos)
        local nP = getNumber(newPos)
        local calc = oP + ((nP-oP)/smooth)*i
        local calc = ""..calc.." 0 0"
        self.UI.setAttribute("healthbarMask","position",calc)
        self.UI.setAttribute("healthbarFillID","position",calc)
        self.UI.setAttribute("healthbarFillID","color",col)

        local oPO = getNumber(oldOverPos)
        local nPO = getNumber(newOverPos)
        local calcO = oPO + ((nPO-oPO)/smooth)*i
        local calcO = ""..calcO.." 0 0"
        self.UI.setAttribute("healthbarMaskOver","position",calcO)
        self.UI.setAttribute("healthbarOverFillID","position",calcO)

        coroutine.yield(0)
      end

      coroutine.yield(1)
    end

    function updateHealthBar()
      startLuaCoroutine(self, "transitionHealthBars")
    end

    function setNumbers()
      value = getVal(self)
      if value > 9 then
        sizeMod = 0.65
        local num1 = math.floor(value/10)
        local num2 = value - num1*10
        local pos1,pos2 = getVerticalPosition(num1,sizeMod)-80,getVerticalPosition(num2,sizeMod)-80
        self.UI.setAttribute("trackerImageS1","active","False")
        self.UI.setAttribute("trackerImageD1","active","True")
        self.UI.setAttribute("trackerImageD2","active","True")

        self.UI.setAttribute("trackerImageD1","position","90 "..tostring(pos1).." -0.01")
        self.UI.setAttribute("trackerImageD2","position","-25 "..tostring(pos2).." -0.01")
        self.UI.setAttribute("trackerImageD1","color",getValueColor(value))
        self.UI.setAttribute("trackerImageD2","color",getValueColor(value))
      else
        local pos = getVerticalPosition(value,0.8) - 95
        self.UI.setAttribute("trackerImageS1","active","True")
        self.UI.setAttribute("trackerImageD1","active","False")
        self.UI.setAttribute("trackerImageD2","active","False")
        self.UI.setAttribute("trackerImageS1","position","45 "..tostring(pos).." -0.01")
        self.UI.setAttribute("trackerImageS1","color",getValueColor(value))
      end
      updateHealthBar()
    end

    function updateValue()
      value = getVal(self)
      setNumbers()
      lastValue = value
    end

    function counterFunction(_obj, _color, clickMode)
      local mod = 1
      if clickMode then mod = -1 end
      value = getVal(self)
      local localmax = max
      local base = tonumber(self.getDescription())
      if base then localmax = base*2 end
      local newValue = math.min(math.max(value + mod, min), math.min(localmax,99))
      if value ~= newValue then
        value = newValue
        self.setName(tostring(value))
        updateValue()
      end
    end

    function pointWithTag(obj,tag)
    for i, point in ipairs(obj.getSnapPoints()) do
      for _, t in pairs(point.tags) do
        if t == tag then
          return point
        end
      end
    end
    end

    function setupCard(card)
      local existing = card.getSnapPoints()
      if #existing <= 1 then
        card.setSnapPoints(JSON.decode(snapPos))
      end
    end

    function attach(object)
      self.jointTo(object, {
        type        = "Fixed",
        collision   = false,
      })
    end

    function onCollisionEnter(info)
      local object = info.collision_object
      local def = tonumber(self.getDescription())
      if (not def) and object.hasTag("Pokemon Card") and facingUp(object) then
        getCardValue(object)
        setupCard(object)
        local tag = "Health Tracker"
        if self.hasTag("Initiative Tracker") then tag = "Initiative Tracker" else self.UI.setAttribute("healthbarFrameID", "active", "True") end

        self.setPosition(object.positionToWorld(pointWithTag(object,tag).position)+Vector(0,0.1,0))
        self.setRotation(object.getRotation())

        Wait.frames(function() attach(object) end, 30)
      end
    end

    function onPlayerAction(player, action, targets)
      if action == Player.Action.FlipOver then
        for k, v in pairs(targets) do
          if v == self then
            local def = tonumber(self.getDescription())
            if def then
              self.setName(def)
              updateValue()
            end
            return false
          end
        end
      end
    end
  ]]
}

--

function getVersion(inp)
  print(inp)
  return inp:match("%[@(.-)%@]")
end


local liveQueue
function handle(get)
  liveQueue = get.text
end

function getUpdateScript()
  WebRequest.get("https://cytokininwastaken.github.io/",handle)
  Wait.frames(function() checkForUpdate(liveQueue) end, 60)
end

function checkForUpdate(text)
  local current = getVersion(self.getLuaScript())
  local live = text
  local liveVersion = getVersion(live)
  if current ~= liveVersion and liveVersion then
    self.setLuaScript(live)
    self.reload()
  end
  print("checked")
end

function facingUp(object)
  local up = object.getTransformUp().y
  local modifiedUp
  local mult = 1
  if up < 0 then modifiedUp,mult = up*-1,-1 else modifiedUp = up end
  return math.ceil(modifiedUp)*mult == 1
end

function has(t,s)
  for _, value in pairs(t) do
    if s == value then return true end
  end
end

function fuzzyHas(t,s)
  for _, value in pairs(t) do
    if string.find(value, s) then return true end
  end
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

--

local boardScale, boardPosition = {4.70, 1.00, 5.00}, {34.00, 0.96, -2.00}

local vanillaRuleBookGUID = "025df7"
local lock = {
  [vanillaRuleBookGUID] = {{59.00, 4.50, 0.00},{45.00, 270.00, 0.00}},
}
local offsets = {
  ["e2facd"] = {0.0425,0,11.68},
  ["691240"] = {0.0425,0,11.68},
  ["08eb73"] = {0.0425,0,11.68},
  ["74cc6c"] = {0.0425,0,11.68},
  ["78e587"] = {0.0425,0,11.68},
  ["faae83"] = {0.0425,0,11.68},
  ["142fb0"] = {0.0425,0,11.68},
  ["3637a8"] = {0.0425,0,11.68},
  ["0a3edb"] = {0.0425,0,11.68},
}

local tagzones = {
  ["Starter Card"] = "ce4312",
  ["Weak Encounter Card"] = "4d7853",
  ["Moderate Encounter Card"] = "59e600",
  ["Strong Encounter Card"] = "c788ce",
  ["Legendary Encounter Card"] = "001a84",
  ["Evolution Card"] = "ae4239",
  ["Galactic Grunt"] = "70f2bd",
  ["Galactic Commander"] = "c84564",
  ["Galactic Boss"] = "4cfdfd",
  ["Noble Encounter Card"] = "001a84",
  ["Ultra Beast Encounter Card"] = "001a84",
  ["Ultra Burst Encounter Card"] = "001a84",
}
function getZone(object)
  for key, value in pairs(tagzones) do
    if object.hasTag(key) then
      return getObjectFromGUID(value)
    end
  end
end

function putInZone(card)
  local zone = getZone(card)
  if zone then
    card.setPosition(zone:getPosition() + Vector(0, 2.5, 0))
    card.setRotation(zone:getRotation())
  else
    card.setPosition(self.getPosition()+Vector(3,1,0))
  end
end

local bagTiles = {"503e6c","1564d0","05f104","392385","0580c9","017063"}
local arenaTile = "8de467"

function rearrange()
  for guid, data in pairs(lock) do
    local obj = getObjectFromGUID(guid)
    obj.setPosition(data[1])
    obj.setRotation(data[2])
  end

  for guid, data in pairs(offsets) do
    local obj = getObjectFromGUID(guid)
    obj.setPosition(obj.getPosition()-Vector(data))
  end
end

function color(r,g,b,a)
  return {r/255,g/255,b/255,a/255}
end
local defaultCol = color(72,50,78,200)--color(150,75,50,200)
local selectedCol = color(120,80,120,200)--color(183,89,51,255)
local defScale = {x=0.1, y=0.1, z=0.1}
local defFontCol = {1,1,1,255}

function storeData()
  Notes.editNotebookTab({index=11,title="QOL DATA",body=JSON.encode(selfData)})
end

selfData = {}


local cardsToDistribute = {}
function putCardCoroutine()
  for _, deck in ipairs(cardsToDistribute) do
    local newPos = deck.getPosition()+Vector(0,5,-4.8)
    repeat
      local card = deck.takeObject({index = 0,position = newPos})
      card.addTag("Vanilla")
      card.addTag("_TAGGED")
      putInZone(card)
      coroutine.yield(0)
    until deck.remainder
    deck.remainder.addTag("Vanilla")
    deck.remainder.addTag("_TAGGED")
    putInZone(deck.remainder)
  end
  return 1
end

local deckZones = {"ce4312","4d7853","59e600","c788ce","001a84","ae4239"}
function tagCards()
  for _, id in ipairs(deckZones) do
    local zone = getObjectFromGUID(id)
    local deck = getObjectFromGUID(zone:getObjects()[1].guid)

    deck.locked = true
    deck.setPosition(deck.getPosition()+Vector(0,0,-4.8))
    cardsToDistribute[_] = deck
  end
  startLuaCoroutine(self, "putCardCoroutine")
end

function updateBookSelector(mode)
  local set = (mode == "on" and "True") or "False"
  for i = 1,5 do
    Wait.frames(function() self.UI.setAttribute("pdfButtonID"..i, "active", set) end,5*i)
  end
end

local buttonCol = "rgb(0.28,0.19,0.3,0.7)"

local pdfs = {
  "http://cloud-3.steamusercontent.com/ugc/1823404307025384062/7DC4103CC927652A94597BCDA95F4FC81360CA3E/",
  "http://cloud-3.steamusercontent.com/ugc/1839167371216005819/4C846A89073BB3BB607148D55B2706F3BD7101D6/",
}
local encodedPDFs = JSON.encode(pdfs)

function applyPDFQueue()
  pdfs = JSON.decode(encodedPDFs)
  if selfData.pdfQueue then
    for _, data in ipairs(selfData.pdfQueue) do
      table.insert(pdfs,data.url)
      self.UI.setAttribute("rulesText"..#pdfs, "text", data.name)
    end
  end
end

function addPDF(data)
  selfData.pdfQueue = selfData.pdfQueue or {}
  local f
  for _, t in ipairs(selfData.pdfQueue) do
    if t.name == data.name then f = true end
  end
  if not f then
    table.insert(selfData.pdfQueue,data)

    applyPDFQueue()
    storeData()
  end
end

function triggerPDFButton(mode)
  local old = selfData.ruleBook
  local obj = getObjectFromGUID(old)
  if obj then
    obj.destroy()
    selfData.ruleBook = nil
  end

  if pdfs[mode] then
    local pos = self.getPosition()
    local rot = self.getRotation()
    local spawned = spawnObjectData({
      data = {
          Name = "Custom_PDF",
          Transform = {
              posX = pos.x-2.9,
              posY = pos.y+0.01,
              posZ = pos.z+1.5,
              rotX = rot.x,
              rotY = rot.y,
              rotZ = rot.z,
              scaleX = 1.68,
              scaleY = 1,
              scaleZ = 1.68,
          },
          CustomPDF = {
            PDFUrl=pdfs[mode],
            PDFPassword="",
            PDFPage=0,
            PDFPageOffset=0,
          },
      },
    })
    spawned.setColorTint(color(0,0,0,255))
    spawned.locked = true
    selfData.ruleBook = spawned.guid
  end
  storeData()
end

function pdfButton1() triggerPDFButton(1) end
function pdfButton2() triggerPDFButton(2) end
function pdfButton3() triggerPDFButton(3) end
function pdfButton4() triggerPDFButton(4) end
function pdfButton5() triggerPDFButton(5) end
function pdfButton6() triggerPDFButton(6) end
function pdfButton7() triggerPDFButton(7) end
function pdfButton8() triggerPDFButton(8) end
function pdfButton9() triggerPDFButton(9) end
function pdfButton10() triggerPDFButton(10) end

local xmlTable = {
  {
    tag = "Button",
    attributes = {
      position = "162 43.5 -23",width = 490,height = 120,
      scale = "0.1 0.1 0.1",color = buttonCol,
      onClick = "pdfButton1",id = "pdfButtonID1",active="False",
    },
    children = {
      {
        tag = "Text",
        attributes = {
          text = "Rulebook",rotation = "0 0 180",color = "#FFFFFF",
          fontSize = 80,id = "rulesText1",
        },
      },
      {
        tag = "Button",
        attributes = {
          position = "0 125 0",width = 490,height = 120,color = buttonCol,
          onClick = "pdfButton2",
        },
        children = {
          {
            tag = "Text",
            attributes = {
              text = "QOL Guide",rotation = "0 0 180",color = "#FFFFFF",
              fontSize = 80,id = "rulesText2",
            },
          },
        }
      },
    }
  },

  {
    tag = "Button",
    attributes = {
      position = "112 43.5 -23",width = 490,height = 120,
      scale = "0.1 0.1 0.1",color = buttonCol,
      onClick = "pdfButton3",id = "pdfButtonID2",active="False",
    },
    children = {
      {
        tag = "Text",
        attributes = {
          text = "...",rotation = "0 0 180",color = "#FFFFFF",
          fontSize = 80,id = "rulesText3",
        },
      },
      {
        tag = "Button",
        attributes = {
          position = "0 125 0",width = 490,height = 120,color = buttonCol,
          onClick = "pdfButton4",
        },
        children = {
          {
            tag = "Text",
            attributes = {
              text = "...",rotation = "0 0 180",color = "#FFFFFF",
              fontSize = 80,id = "rulesText4",
            },
          },
        }
      },
    }
  },

  {
    tag = "Button",
    attributes = {
      position = "61.75 43.5 -23",width = 490,height = 120,
      scale = "0.1 0.1 0.1",color = buttonCol,
      onClick = "pdfButton5",id = "pdfButtonID3",active="False",
    },
    children = {
      {
        tag = "Text",
        attributes = {
          text = "...",rotation = "0 0 180",color = "#FFFFFF",
          fontSize = 80,id = "rulesText5",
        },
      },
      {
        tag = "Button",
        attributes = {
          position = "0 125 0",width = 490,height = 120,color = buttonCol,
          onClick = "pdfButton6",
        },
        children = {
          {
            tag = "Text",
            attributes = {
              text = "...",rotation = "0 0 180",color = "#FFFFFF",
              fontSize = 80,id = "rulesText6",
            },
          },
        }
      },
    }
  },

  {
    tag = "Button",
    attributes = {
      position = "11.65 43.5 -23",width = 490,height = 120,
      scale = "0.1 0.1 0.1",color = buttonCol,
      onClick = "pdfButton7",id = "pdfButtonID4",active="False",
    },
    children = {
      {
        tag = "Text",
        attributes = {
          text = "...",rotation = "0 0 180",color = "#FFFFFF",
          fontSize = 80,id = "rulesText7",
        },
      },
      {
        tag = "Button",
        attributes = {
          position = "0 125 0",width = 490,height = 120,color = buttonCol,
          onClick = "pdfButton8",
        },
        children = {
          {
            tag = "Text",
            attributes = {
              text = "...",rotation = "0 0 180",color = "#FFFFFF",
              fontSize = 80,id = "rulesText8",
            },
          },
        }
      },
    }
  },

  {
    tag = "Button",
    attributes = {
      position = "-38.5 43.5 -23",width = 490,height = 120,
      scale = "0.1 0.1 0.1",color = buttonCol,
      onClick = "pdfButton9",id = "pdfButtonID5",active="False",
    },
    children = {
      {
        tag = "Text",
        attributes = {
          text = "...",rotation = "0 0 180",color = "#FFFFFF",
          fontSize = 80,id = "rulesText9",
        },
      },
      {
        tag = "Button",
        attributes = {
          position = "0 125 0",width = 490,height = 120,color = buttonCol,
          onClick = "pdfButton10",
        },
        children = {
          {
            tag = "Text",
            attributes = {
              text = "...",rotation = "0 0 180",color = "#FFFFFF",
              fontSize = 80,id = "rulesText10",
            },
          },
        }
      },
    }
  },
}

function onLoad()
  self.addContextMenuItem("Check For Update", getUpdateScript)

  local desc = Notes.getNotebookTabs()[12].body
  if desc ~= "" then selfData = JSON.decode(desc) end

  local loadedCheck = getObjectFromGUID("691240")
  if loadedCheck and (not loadedCheck.hasTag("QOL MOVED")) then
    rearrange()
    self.setPosition(boardPosition)
    self.setScale(boardScale)
    self.locked = true
    tagCards()
    loadedCheck.addTag("QOL MOVED")
  end

  local vanillaRulesObj = getObjectFromGUID(vanillaRuleBookGUID)
  if vanillaRulesObj then
    pdfs[1] = JSON.decode(vanillaRulesObj.getJSON()).CustomPDF.PDFUrl
    encodedPDFs = JSON.encode(pdfs)
  end


  Wait.frames(function() refreshTile(getObjectFromGUID(arenaTile)) end,60)
  Wait.frames(function() applyPDFQueue() end,60)

  self.UI.setXmlTable(xmlTable)

  self.createButton({
     label          = "",
     click_function = "showDeckTool",
     function_owner = self,
     position       = {-1.6225,0.21,0.81},
     rotation       = {0,0,0},
     height         = 1680,
     width          = 2350,
     font_size      = 800,
     scale          = defScale,
     font_color     = defFontCol,
     color          = color(75,50,75,150),
  })
  self.createButton({
     label          = "",
     click_function = "none",
     function_owner = self,
     position       = {-1.6225+0.505*1,0.21,0.81},
     rotation       = {0,0,0},
     height         = 1680,
     width          = 2350,
     font_size      = 800,
     scale          = defScale,
     font_color     = defFontCol,
     color          = color(75,50,75,150),
  })
  self.createButton({
     label          = "",
     click_function = "none",
     function_owner = self,
     position       = {-1.6225+0.505*2,0.21,0.81},
     rotation       = {0,0,0},
     height         = 1680,
     width          = 2350,
     font_size      = 800,
     scale          = defScale,
     font_color     = defFontCol,
     color          = color(75,50,75,150),
  })
  self.createButton({
     label          = "",
     click_function = "none",
     function_owner = self,
     position       = {-1.6225+0.505*3,0.21,0.81},
     rotation       = {0,0,0},
     height         = 1680,
     width          = 2350,
     font_size      = 800,
     scale          = defScale,
     font_color     = defFontCol,
     color          = color(75,50,75,150),
  })
  self.createButton({
     label          = "",
     click_function = "showRules",
     function_owner = self,
     position       = {-1.6225+0.505*4,0.21,0.81},
     rotation       = {0,0,0},
     height         = 1680,
     width          = 2350,
     font_size      = 800,
     scale          = defScale,
     font_color     = defFontCol,
     color          = color(75,50,75,150),
  })

  --sidebar tools

  self.createButton({
     label          = "",
     click_function = "toggleHealthInitiative",
     function_owner = self,
     position       = {1.265,0.21,-0.859},
     rotation       = {0,0,0},
     height         = 1220,
     width          = 5840,
     font_size      = 800,
     scale          = defScale,
     font_color     = defFontCol,
     color          = color(75,50,75,150),
  })
  self.createButton({
     label          = "",
     click_function = "toggleBallCraft",
     function_owner = self,
     position       = {1.265,0.21,-0.859+0.269},
     rotation       = {0,0,0},
     height         = 1220,
     width          = 5840,
     font_size      = 800,
     scale          = defScale,
     font_color     = defFontCol,
     color          = color(75,50,75,150),
  })
  self.createButton({
     label          = "",
     click_function = "toggleLegendaryInfo",
     function_owner = self,
     position       = {1.265,0.21,-0.859+0.269*2},
     rotation       = {0,0,0},
     height         = 1220,
     width          = 5840,
     font_size      = 800,
     scale          = defScale,
     font_color     = defFontCol,
     color          = color(75,50,75,150),
  })

  self.createButton({
     label          = "",
     click_function = "toggleExpandedTable",
     function_owner = self,
     position       = {1.265,0.21,-0.859+0.269*6.20},
     rotation       = {0,0,0},
     height         = 1650,
     width          = 5840,
     font_size      = 800,
     scale          = defScale,
     font_color     = defFontCol,
     color          = color(75,50,75,150),
  })
end

--


--

function none() modeSwitchClear() end

function modeSwitchClear()
  if self.getDescription() == "reset" then selfData = JSON.decode("[]") end

  if getObjectFromGUID(selfData.deckTool or "") then
    getObjectFromGUID(selfData.deckTool).destroy()
    selfData.deckTool = nil
  end

  if getObjectFromGUID(selfData.ruleBook or "") then
    getObjectFromGUID(selfData.ruleBook).destroy()
    selfData.ruleBook = nil
  end

  updateBookSelector("off")
  storeData()
end

function showDeckTool()
  modeSwitchClear()
  local spawned = spawnObject({
    type = "Custom_Tile",
    position = self.getPosition()+Vector(-5,1,1),
    rotation = self.getRotation(),
    scale = {3.3,1,3.3},
  })
  spawned.setCustomObject({
    image = "http://cloud-3.steamusercontent.com/ugc/1839166905722441189/B058A2965E966E76C5657E1F078C3F5A2FC088A9/",
    thickness = 0.1,
    type = 0,
  })
  spawned.setLuaScript(decktoolScript[1])
  spawned.setColorTint(color(50,50,50,255))
  spawned.reload()
  selfData.deckTool = spawned.guid
  storeData()
end

function showRules()
  modeSwitchClear()
  updateBookSelector("on")
  local pos = self.getPosition()
  local rot = self.getRotation()
  triggerPDFButton(1)

end

function showModelLoader()
  modeSwitchClear()
end

-- Health and Initiative trackers

local healthBase = "http://cloud-3.steamusercontent.com/ugc/1836913203203609033/E976A42013BF1231C2D05389D3E930F7E881EAF2/"
local initiativeBase = "http://cloud-3.steamusercontent.com/ugc/1836913203203609091/7B10BABDAC040B186A59F0A50B5195B8561A5B2C/"

function spawnTracker(position,type)
  local spawned = spawnObject({
    type              = "Custom_Token",
    position          = position,
    scale             = {0.12,1,0.12},
  })
  spawned.setCustomObject({
    image = (type == "Health Tracker" and healthBase) or initiativeBase,
    thickness = 0.1,
  })
  spawned.addTag(type)
  spawned.addTag("Dice")
  spawned.setLuaScript(trackerObjScript[1])

  return spawned
end

function placeTrackers(tile,position)
  local hBag,iBag = getObjectFromGUID(tile.getName()),getObjectFromGUID(tile.getDescription())
  hBag.takeObject({position=position+Vector(-0.5,0.5,0)})
  iBag.takeObject({position=position+Vector(0.5,0.5,0)})
end

function placeTrackers1()
  local tile = getObjectFromGUID(arenaTile)
  placeTrackers(tile,tile.getPosition()+Vector(0,0,2))
end

function placeTrackers2()
  local tile = getObjectFromGUID(arenaTile)
  placeTrackers(tile,tile.getPosition()+Vector(0,0,-2))
end

function onPlayerAction(player, action, targets)
  if action == Player.Action.FlipOver then
    for k, v in pairs(targets) do
      if string.find(v.name,"Card") then
        print(v.getJoints())

        local hit = Physics.cast({
          origin       = v.getPosition(),
          direction    = Vector(0,1,0),
          type         = 3,
          size         = Vector(2,1,2),
          max_distance = 2,
        })

        local deleted = false
        for _, o in ipairs(hit) do
          local ob = o.hit_object
          if ob.hasTag("Health Tracker") or ob.hasTag("Initiative Tracker") then
            ob.destroy()
            deleted = true
          end
        end
        if deleted then return false end
      end
    end
  end
end

local toput = {}

function refreshTile(tile)
  if selfData.trackers then
    setupTile(tile)
  end
end

function setupTile(tile)
  local name,desc = tile.getName(),tile.getDescription()
  local b1,b2 = getObjectFromGUID(name),getObjectFromGUID(desc)
  if b1 then b1.destroy() end
  if b2 then b2.destroy() end

  tile.UI.setCustomAssets({{name="display",url="http://cloud-3.steamusercontent.com/ugc/1842544393860672243/7B159A1A001D310FD21F61A0BB5B3400F8698BB1/"}})
  tile.UI.setXmlTable({{tag="Image",attributes = {id = "ImageID",image = "display",width = "1%",height ="1%",position = "0 0 -60"}}})
  tile.setColorTint(color(53,51,61,255))

  for i = -1,1,2 do
    local spawned = spawnObject({
      type = "Custom_Model",
      position = tile.getPosition()+Vector(1.08*i,0.11,0),
      scale = {0.40, 0.10, 0.75},
      rotation = tile.getRotation(),
    })
    spawned.setCustomObject({
      mesh = "http://pastebin.com/raw/PMjCsZFs",
      type = 7,
      collider = "http://pastebin.com/raw/PMjCsZFs",
    })
    spawned.setColorTint(color(0,0,1,0.2))
    spawned.locked = true
    if i == -1 then
      tile.setName(spawned.guid)
    else
      tile.setDescription(spawned.guid)
    end
  end
  tile.tooltip = false

  toput[1], toput[2] = spawnTracker({0,2,0},"Health Tracker").guid,spawnTracker({1,2,0},"Initiative Tracker").guid
  Wait.frames(
    function()
      local tile = getObjectFromGUID(arenaTile)
      local health = getObjectFromGUID(toput[1])
      local init = getObjectFromGUID(toput[2])
      health.use_grid = false
      init.use_grid = false
      health.setRotation({0.00, 180.00, 0.00})
      init.setRotation({0.00, 180.00, 0.00})

      local hBag = getObjectFromGUID(tile.getName())
      local iBag = getObjectFromGUID(tile.getDescription())

      hBag.putObject(health)
      iBag.putObject(init)
    end,20)

  tile.createButton({
    label = "",
    position = {0,0.5,0.25},
    scale = {0.1,0.1,0.1},
    width = 2600,
    height = 2200,
    color = {0,0,0,0.2},
    click_function = "placeTrackers1",
    function_owner = self,
  })
  tile.createButton({
    label = "",
    position = {0,0.5,-0.25},
    scale = {0.1,0.1,0.1},
    width = 2600,
    height = 2200,
    color = {0,0,0,0.2},
    click_function = "placeTrackers2",
    function_owner = self,
  })
end

function toggleHealthInitiative()
  if not selfData.trackers then
  	setupTile(getObjectFromGUID(arenaTile))
    selfData.trackers = true
    storeData()
  else
    local tile = getObjectFromGUID(arenaTile)
    tile.setColorTint(color(150,75,50,255))
    selfData.trackers = nil
    getObjectFromGUID(tile.getName()).destroy()
    getObjectFromGUID(tile.getDescription()).destroy()
    tile.UI.setXml("")
    tile.removeButton(0)
    tile.removeButton(1)
    storeData()
  end
end

--ball craft tiles

function toggleBallCraft()
  if not selfData.craftTiles then --spawn tiles
    local offset = {4.24,0,-0.01}
    selfData.craftTiles = {}
    for _, id in ipairs(bagTiles) do
      local obj = getObjectFromGUID(id)
      local rot = obj.getRotation()
      local pos = obj.getPosition()
      local offsetVector = (rot.y == 0 and Vector({4.24,-0.01,0.01})) or Vector({-4.24,-0.01,-0.01})

      local spawned = spawnObject({
        type = "Custom_Tile",
        position = obj.getPosition()+offsetVector,
        rotation = obj.getRotation(),
        scale = {4.10, 1.00, 4.10},
      })
      spawned.setCustomObject({
        image = "http://cloud-3.steamusercontent.com/ugc/1838038580067499567/B679DD971CE8AC16E44511FED26C22A9E3502FE5/",
        thickness = 0.2,
        type = 0,
      })
      spawned.setLuaScript(ballCraftScript[1])
      spawned.locked = true
      spawned.setColorTint(color(150,75,50,255))
      spawned.reload()
      table.insert(selfData.craftTiles,spawned.guid)

    end
  else --remove tiles instead
    for _, id in ipairs(selfData.craftTiles) do
      getObjectFromGUID(id).destroy()
    end
    selfData.craftTiles = nil
  end
  storeData()
end
--

--Legend info
local legendaryTags = {"Legendary Encounter Card","Ultra Beast Encounter Card","Noble Encounter Card"}
local alphaName = "Alpha Pokémon"
local guids = {"f8489f","bab211","c31531","547ae7","d65598","8168c0"}
local madeZones = {}

function toggleLegendaryInfo()
  if selfData.legendInfo then
    removeLegendaryInfo()
  else
    setupLegendaryInfo()
  end
end

function setupLegendaryInfo()
  madeZones = {}
  for _, id in ipairs(guids) do
    board = getObjectFromGUID(id)
    for i = 1,6 do
      local zoff = (board.getRotation().y == 180 and 2.34) or -2.34
      local temp = spawnObject({
        type = "ScriptingTrigger",
        position = board.getPosition()+Vector({-7.37, 0, 0})+Vector(2.95*(i-1),0,zoff),
        rotation = board.getRotation(),
        scale = {2,1,3},
      })
      table.insert(madeZones,temp.guid)
    end
  end
  selfData.legendInfo = madeZones
  storeData()
end

function removeLegendaryInfo()
  local zoneData = selfData.legendInfo
  for _, id in ipairs(zoneData) do
    local zone = getObjectFromGUID(id)
    local zoneTile = getObjectFromGUID(zone.getGMNotes())
    if zoneTile then zoneTile.destroy() end
    zone.destroy()
  end
  selfData.legendInfo = nil
  storeData()
end

function updateLegendaryStatus(zone)
  local legend = false
  for _, object in ipairs(zone.getObjects()) do
    for _, tag in ipairs(legendaryTags) do
      if (object.hasTag(tag) and facingUp(object)) or object.getName() == alphaName then
        legend = true
        break
      end
    end
  end
  local tileID = zone.getGMNotes()
  if legend then
    if tileID == "" then
      local pos = zone.getPosition()+Vector(0,0.105,(zone.getRotation().y == 180 and -4.6) or 4.6)
      local rot = zone.getRotation()
      local tile = spawnObject({type="Custom_Tile",position = pos, rotation = rot,scale = {1.45, 1.00, 1.45}})
      tile.setCustomObject({
        image = "http://cloud-3.steamusercontent.com/ugc/1842541435814036636/0262D876458DF1B53DF391265F868038C523F5B7/",
        thickness = 0.1,
      })
      tile.locked = true
      zone.setGMNotes(tile.guid)
    end
  else
    if tileID ~= "" then
      getObjectFromGUID(tileID).destroy()
      zone.setGMNotes("")
    end
  end
end

function onObjectEnterZone(zone, object)
  if selfData.legendInfo then
    if has(madeZones, zone.guid) then
      updateLegendaryStatus(zone)
    end
  end
end
function onObjectLeaveZone(zone, object)
  if selfData.legendInfo then
    if has(madeZones, zone.guid) then
      updateLegendaryStatus(zone)
    end
  end
end
--

function toggleExpandedTable()
  if selfData.tableExpander then
    local board = getObjectFromGUID(selfData.tableExpander)
    if board then board.destroy() end
    selfData.tableExpander = nil
    local vanillaRules = getObjectFromGUID(vanillaRuleBookGUID)
    if vanillaRules then vanillaRules.setPosition(lock[vanillaRuleBookGUID][1]) end
  else
    local board = spawnObject({type="Custom_Tile",position = {0, 0.755, 0}, rotation = {0,180,0},scale = {26, 1.00, 26}})
    board.setCustomObject({
      image = "http://cloud-3.steamusercontent.com/ugc/1839167371215920975/CD92B1E38FFA7D3786A9820248945281EE4FDB51/",
      thickness = 0.2,
    })
    board.setColorTint(color(150,75,50,255))
    board.locked,board.interactable = true,false
    selfData.tableExpander = board.guid

    local vanillaRules = getObjectFromGUID(vanillaRuleBookGUID)
    if vanillaRules then vanillaRules.setPosition({-1000, -1000, -1000}) end
  end
  storeData()
end