macro(500, "Auto Haste", nil, function()

    if not hasHaste() and storage.autoHasteText:len() > 0 then

      if saySpell(storage.autoHasteText) then

        delay(1000)

      end

    end

  end)

  addTextEdit("autoHasteText", storage.autoHasteText or "concentrate chakra feet", function(widget, text) 

    storage.autoHasteText = text

end)

