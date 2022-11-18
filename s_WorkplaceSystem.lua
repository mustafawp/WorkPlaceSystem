-- DEVELOPMENT BY BURAKMRX --
local isyerisiniri = 2   --bu degisken, bir oyuncunun kaçtane işyeri satın alabileceğini belirler.
local isyerikiralamasinir = 1   --bu degisken, bir oyuncunun kaçtane işyeri kiralayabileceğini belirler.
local isyeriolusturmapanel = "isyeriolustur"  -- bu komut, işyeri oluşturma panelinin komutunu belirler.
local yetkili = "Console" -- bu, hangi yetkilinin paneli açabileceğini belirler.


local db = dbConnect("sqlite","files/veriler/results.db")
local markerlar = { }
local girismarkerlari = { }
local px,py,pz
local interiors = {
    [1] = { -25.884498,-185.868988,1003.546875, 17 },  --market	
    [2] = { 207.737991,-109.019996,1005.132812, 15 },  --giyim
    [3] = { 1494.325195,1304.942871,1093.289062, 3 },  --kurum
    [4] = { -794.806396,497.738037,1376.195312, 1 },   --restorant
    [5] = { -2159.122802,641.517517,1052.381713, 1 },  --şirket
}

addEventHandler("onResourceStart",getRootElement(),function()
    results = dbPoll(dbQuery(db,"SELECT * FROM veriler"),-1)
    for i,v in pairs(results) do
        local lokasyon = fromJSON(v["xyz"])
        local x,y,z = unpack(lokasyon)
        local sira = v["id"]
        local tur = v["turu"]
        local marker = createMarker ( x, y, z+1, "arrow", 1.2, 255, 127, 0, 170 )
        table.insert(markerlar,{marker,sira,tur})
        addEventHandler("onMarkerHit",marker,markeragiris)
    end
end)

addEvent("WorkPlaceSystem:Olustur",true)
addEventHandler("WorkPlaceSystem:Olustur",getRootElement(),function(sira,sahip,tur,fiyat)
        local x,y,z = getElementPosition(source)
        local tablo = {tostring(x),tostring(y),tostring(z)}
        local konum = toJSON(tablo)
        dbExec(db,"INSERT INTO veriler (id,sahip,unvan,turu,kilit,fiyati,kiraci,saat,xyz,durum) VALUES (?,?,?,?,?,?,?,?,?,?)",sira,sahip,"İşyerim",tostring(tur),0,fiyat,"-","00:00-23:59",konum,"Satılık")
        local marker = createMarker ( x, y, z+1, "arrow", 1.2, 255, 127, 0, 170 )
        addEventHandler("onMarkerHit",marker,markeragiris)
        table.insert(markerlar,{marker,sira,tur})
end)

function markeragiris(oyuncu)
    local sira, tur
    for i,v in pairs(markerlar) do
        if v[1] == source then
            sira = v[2]
        end
    end
    local veri = dbPoll(dbQuery(db,"SELECT * FROM veriler WHERE id = ?",sira),-1)
    triggerClientEvent(oyuncu,"WorkPlaceSystem:GirisEkrani",oyuncu,veri)
end

addCommandHandler(isyeriolusturmapanel,function(oyuncu)
    local hesap = getAccountName(getPlayerAccount(oyuncu))
    if isObjectInACLGroup("user."..hesap, aclGetGroup(yetkili)) then
        local result = dbPoll(dbQuery(db,"SELECT * FROM veriler ORDER BY id ASC"),-1)
        triggerClientEvent(oyuncu,"WorkPlaceSystem:AdminPanel",oyuncu,result)
    else
        outputChatBox("Bu panele #ff7f00erişim yetkiniz #ffffffbulunmamaktadır.",oyuncu,255,255,255,true)
    end
end)

addEvent("WorkPlaceSystem:İnfoUpdate",true)
addEventHandler("WorkPlaceSystem:İnfoUpdate",getRootElement(),function(sira,unvan,tur,kilitdrm,defid)
    if tonumber(sira) >= 1 then
        result = dbPoll(dbQuery(db,"SELECT * FROM veriler"),-1)
        for i,v in pairs(result) do
            if tonumber(v["id"]) == tonumber(sira) then
                if sira ~= defid then
                    outputChatBox("Bu id zaten başka bir işyerinde kullanılıyor.",source,255,255,255)
                    return
                end
            end
        end
        if kilitdrm == 0 or kilitdrm == 1 then
            dbExec(db,"UPDATE veriler SET id = ?, unvan = ?, turu = ?, kilit = ? WHERE id = ?",sira,unvan,tur,kilitdrm,defid)
            for i,v in pairs(markerlar) do
                if tostring(v[2]) == tostring(defid) then
                    v[2] = sira
                    v[3] = tur

                end
            end
            outputChatBox("Başarıyla seçili ev düzenlenildi.",source,255,255,255)
            outputChatBox("#ff7f00● #ffffffİş Yeri Sırası: #ff7f00"..sira.."#ffffff ✔",source,255,255,255,true)
            outputChatBox("#ff7f00● #ffffffİş Yeri Ünvanı: #ff7f00"..unvan.."#ffffff ✔",source,255,255,255,true)
            outputChatBox("#ff7f00● #ffffffİş Yeri Türü: #ff7f00"..tur.."#ffffff ✔",source,255,255,255,true)
            if kilitdrm == 0 then
            outputChatBox("#ff7f00● #ffffffİş Yeri Kilidi: #ff7f00 Kilitli #ffffff ✔",source,255,255,255,true)
            else
                outputChatBox("#ff7f00● #ffffffİş Yeri Kilidi: #ff7f00 Kilitsiz #ffffff ✔",source,255,255,255,true)
            end
        else
            outputChatBox("Geçersiz Kilit Tipi. Lütfen kilit türünü seçin.",source,255,255,255)
        end
    else
        outputChatBox("Geçersiz Sıra Numarası. Lütfen 1 veya daha büyük bir rakam girin")
    end
end)

addEvent("WorkPlaceSystem:Delete",true)
addEventHandler("WorkPlaceSystem:Delete",getRootElement(),function(id,durum,text,sahibi)
    if durum then
        local varmi = false
        veri = dbPoll(dbQuery(db,"SELECT * FROM veriler"),-1)
        for i,v in pairs(veri) do
            if tostring(v["id"]) == tostring(id) then
                varmi = true
            end
        end
        if varmi == false then outputChatBox("Böyle bir id ye sahip işyeri bulunmamaktadır.",source,255,255,255) return end
        if #text <= 5 then outputChatBox("Kaldırılma nedeni 5 harften daha uzun olmalıdır.",source,255,255,255) return end
        local hesap = getAccount(sahibi)
        setAccountData(getAccount(sahibi),"WorkPlaceSystemDurum",true)
        setAccountData(getAccount(sahibi),"WorkPlaceSystemMessage",text)
        dbExec(db,"DELETE FROM veriler WHERE id = ?",id)
        outputChatBox("Başarıyla Sıra Numarası girilen ev silindi. ",source,255,255,255)
        for i,v in pairs(markerlar) do
            if tostring(v[2]) == tostring(id) then
                destroyElement(v[1])
                table.remove(markerlar,i)
            end
        end
    else
        local varmi = false
        veri = dbPoll(dbQuery(db,"SELECT * FROM veriler"),-1)
        for i,v in pairs(veri) do
            if tostring(v["id"]) == tostring(id) then
                varmi = true
            end
        end
        if varmi == false then outputChatBox("Böyle bir id ye sahip işyeri bulunmamaktadır.",source,255,255,255) return end
        dbExec(db,"DELETE FROM veriler WHERE id = ?",id)
        outputChatBox("Başarıyla Sıra Numarası girilen ev silindi. ",source,255,255,255)
        for i,v in pairs(markerlar) do
            if tostring(v[2]) == tostring(id) then
                destroyElement(v[1])
                table.remove(markerlar,i)
            end
        end
    end
end)

addEventHandler("onPlayerLogin",getRootElement(),function()
    hesap = getPlayerAccount(source)
    if getAccountData(hesap,"WorkPlaceSystemDurum") == true then
        local text = getAccountData(hesap,"WorkPlaceSystemMessage")
        outputChatBox("#ff0000[BİLDİRİM] #ffffffİş yeriniz Yönetim Ekibi üyesi tarafından kaldırıldı. Sebebi: "..text,source,255,255,255,true)
        setAccountData(hesap,"WorkPlaceSystemDurum",false)
        setAccountData(hesap,"WorkPlaceSystemMessage","")
    end
end)

addEvent("WorkPlaceSystem:LoginToWorkPlace",true)
addEventHandler("WorkPlaceSystem:LoginToWorkPlace",getRootElement(),function(id)
    hesap = getAccountName(getPlayerAccount(source))
    local sahibimi = false
    local kiracimi = false
    local markervarmi = false
    local kilitdurumu
    local turua
    local veriler = dbPoll(dbQuery(db,"SELECT * FROM veriler"),-1)
    for i,v in pairs(veriler) do
        if tostring(v["id"]) == tostring(id) then
            if tostring(v["sahip"]) == tostring(hesap) then
                sahibimi = true
            elseif tostring(v["kiraci"]) == tostring(hesap) then
                kiracimi = true
            end
            turua = v["turu"]
            kilitdurumu = v["kilit"]
        end
    end
    if sahibimi == true then
        local durum = "sahibi"
        for i,v in pairs(markerlar) do
            if tostring(v[2]) == tostring(id) then
                if getElementData(v[1],"WorkPlaceSystem:NotuVarmi") == true then
                    local notus = getElementData(v[1],"WorkPlaceSystem:Notu")
                    outputChatBox("#ffffffBirisi işyerinizin önüne not bırakmış. Not: #ff7f00"..tostring(notus),source,255,255,255,true)
                    setElementData(v[1],"WorkPlaceSystem:NotuVarmi",false)
                end
            end
        end
        triggerClientEvent(source,"WorkPlaceSystem:PaneliKapat",source)
        triggerClientEvent(source,"WorkPlaceSystem:Owner",source,durum)
    elseif kiracimi == true then
        local durum = "kiracı"
        for i,v in pairs(markerlar) do
            if tostring(v[2]) == tostring(id) then
                if getElementData(v[1],"WorkPlaceSystem:NotuVarmi") == true then
                    local notus = getElementData(v[1],"WorkPlaceSystem:Notu")
                    outputChatBox("#ffffffBirisi işyerinizin önüne not bırakmış. Not: #ff7f00"..tostring(notus),source,255,255,255,true)
                    setElementData(v[1],"WorkPlaceSystem:NotuVarmi",false)
                end
            end
        end
        triggerClientEvent(source,"WorkPlaceSystem:PaneliKapat",source)
        triggerClientEvent(source,"WorkPlaceSystem:Owner",source,durum)
    else
        if tostring(kilitdurumu) == "0" then
            outputChatBox("#ffffffGirmeye çalıştığınız işyerinin kapısı #ff7f00Kilitli olduğu için #ffffffgiriş yapamazsınız",source,255,255,255,true)
        else
            setElementFrozen(source,false)
            fadeCamera(source,false)
            toggleAllControls(source,false)
            local hesapas = getPlayerAccount(source)
            triggerClientEvent(source,"WorkPlaceSystem:PaneliKapat",source)
            for i,v in pairs(girismarkerlari) do
                if tostring(v[1]) == tostring(id) then
                    markervarmi = true
                end
            end
            if markervarmi ~= true then
                px,py,pz = getElementPosition(source)
                if turua == "Market" then
                    local markersasd = createMarker ( interiors[1][1], interiors[1][2], interiors[1][3]+1, "arrow", 1.2, 255, 127, 0, 170 )
                    addEventHandler("onMarkerHit",markersasd,isyerindencikis)
                    setElementInterior( markersasd, interiors[1][4])
                    setElementDimension(markersasd,tonumber(id))
                    table.insert( girismarkerlari,{id,markersasd})
                  elseif turua == "Giyim" then
                    local markersasd = createMarker ( interiors[2][1], interiors[2][2], interiors[2][3]+1, "arrow", 1.2, 255, 127, 0, 170 )
                    addEventHandler("onMarkerHit",markersasd,isyerindencikis)
                    setElementInterior( markersasd, interiors[2][4])
                    setElementDimension(markersasd,tonumber(id))
                    table.insert( girismarkerlari,{id,markersasd})
                  elseif turua == "Kurum" then
                    local markersasd = createMarker ( interiors[3][1], interiors[3][2], interiors[3][3]+1, "arrow", 1.2, 255, 127, 0, 170 )
                    addEventHandler("onMarkerHit",markersasd,isyerindencikis)
                    setElementInterior( markersasd, interiors[3][4])
                    setElementDimension(markersasd,tonumber(id))
                    table.insert( girismarkerlari,{id,markersasd})
                  elseif turua == "Restorant" then
                    local markersasd = createMarker ( interiors[4][1], interiors[4][2], interiors[4][3]+1, "arrow", 1.2, 255, 127, 0, 170 )
                    addEventHandler("onMarkerHit",markersasd,isyerindencikis)
                    setElementInterior( markersasd, interiors[4][4])
                    setElementDimension(markersasd,tonumber(id))
                    table.insert( girismarkerlari,{id,markersasd})
                  elseif turua == "Şirket" then
                    local markersasd = createMarker ( interiors[5][1], interiors[5][2], interiors[5][3]+1, "arrow", 1.2, 255, 127, 0, 170 )
                    addEventHandler("onMarkerHit",markersasd,isyerindencikis)
                    setElementInterior( markersasd, interiors[5][4])
                    setElementDimension(markersasd,tonumber(id))
                    table.insert( girismarkerlari,{id,markersasd})
                  end
            end
            setAccountData(hesapas,"WorkPlaceSystem:Giris","true")
            setTimer( function( player )
                if getPedOccupiedVehicle( player ) then removePedFromVehicle( player ) end
                if turua == "Market" then
                  setElementInterior( player, interiors[1][4], interiors[1][1], interiors[1][2], interiors[1][3])
                elseif turua == "Giyim" then
                  setElementInterior( player, interiors[2][4], interiors[2][1], interiors[2][2], interiors[2][3])
                elseif turua == "Kurum" then
                  setElementInterior( player, interiors[3][4], interiors[3][1], interiors[3][2], interiors[3][3])
                elseif turua == "Restorant" then
                  setElementInterior( player, interiors[4][4], interiors[4][1], interiors[4][2], interiors[4][3])
                elseif turua == "Şirket" then
                  setElementInterior( player, interiors[5][4], interiors[5][1], interiors[5][2], interiors[5][3])
                end
                  setElementDimension(player, tonumber(id))
                  toggleAllControls( player, true );
                  fadeCamera( player, true );
              end, 1200, 1, client, t );
              setTimer(function(player)
                setAccountData(hesapas,"WorkPlaceSystem:Giris","false")
            end,2000,1,client,t)
        end
    end
end)

function isyerindencikis(oyuncu)
    if getAccountData(getPlayerAccount(oyuncu),"WorkPlaceSystem:Giris") == "false" then
        if getElementInterior(oyuncu) > 0 then
            toggleAllControls(oyuncu,false)
            fadeCamera(oyuncu,false)
            setTimer(function()
                setElementDimension(oyuncu,0)
                setElementInterior( oyuncu, 0,px,py,pz)
                toggleAllControls(oyuncu,true)
                fadeCamera(oyuncu,true)
            end, 1200,1,client,t)
        end
    end
end

addEvent("WorkPlaceSystem:SatinAlma",true)
addEventHandler("WorkPlaceSystem:SatinAlma",getRootElement(),function(id)
    local hesap = getAccountName(getPlayerAccount(source))
    local veriler = dbPoll(dbQuery(db,"SELECT * FROM veriler"),-1)
    local isyerisahibi
    local fiyati
    local durum
    local tur 
    local sahipci = 0
    for i,v in pairs(veriler) do
        if tostring(v.id) == tostring(id) then
            isyerisahibi = v.sahip
            fiyati = v.fiyati
            durum = v.durum
            tur = v.turu
        end
        if tostring(v.sahip) == tostring(hesap) then
            sahipci = sahipci + 1
        end
    end
    local parasi = getPlayerMoney(source)
    if tostring(durum) == "Satılık" then
        if tonumber(isyerisiniri) > sahipci then
            if tonumber(parasi) >= tonumber(fiyati) then
                if tostring(hesap) == tostring(isyerisahibi) then outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffSatın Alma başarısız. Kendi işyerinizi satın alamazsınız.",source,255,255,255,true) return end
                takePlayerMoney(source,tonumber(fiyati))
                local adam = getAccountPlayer(getAccount(isyerisahibi))
                givePlayerMoney(adam,tonumber(fiyati))
                dbExec(db,"UPDATE veriler SET sahip = ?, durum = ? WHERE id = ?",hesap,"Satılık Değil",id)
                outputChatBox("#ff7f00● #ffffffBaşarıyla Bir İşyeri Satın Aldınız!",source,255,255,255,true)
                outputChatBox("#ff7f00● #ffffffİşyeri Sırası: #ff7f00"..tostring(id).."#ffffff ✔",source,255,255,255,true)
                outputChatBox("#ff7f00● #ffffffİşyeri Türü: #ff7f00"..tostring(tur).."#ffffff ✔",source,255,255,255,true)
                outputChatBox("#ff7f00● #ffffffİşyeri Fiyatı: #ff7f00"..tostring(fiyati).."#ffffff ✔",source,255,255,255,true)
                outputChatBox("#ff7f00● #ffffffİşyeri Önceki Sahibi: #ff7f00"..tostring(isyerisahibi).."#ffffff ✔",source,255,255,255,true)
                outputChatBox("#ff7f00● #ffffffİşyeri Yeni Sahibi: #ff7f00"..tostring(hesap).."#ffffff ✔",source,255,255,255,true)
                triggerClientEvent(source,"WorkPlaceSystem:PaneliKapat",source)
            else
                outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffSatın Alma başarısız. Yeterli paranız bulunmamaktadır. Satış Fiyatı: #ff0000"..tostring(fiyati),source,255,255,255,true)
            end
        else
            outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffSatın Alma başarısız. İşyeri satın alma sınırını geçtiniz. İşyeri satın alma sınırı: #ff0000"..tostring(isyerisiniri),source,255,255,255,true)
        end
    else
        outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffSatın Alma başarısız. İşyeri Durumu: #ff0000"..tostring(durum),source,255,255,255,true)
    end
end)

addEvent("WorkPlaceSystem:Kiralama",true)
addEventHandler("WorkPlaceSystem:Kiralama",getRootElement(),function(id)
    local hesap = getAccountName(getPlayerAccount(source))
    local veriler = dbPoll(dbQuery(db,"SELECT * FROM veriler"),-1)
    local isyerisahibi
    local fiyati
    local durum
    local tur
    local oncekikiraci 
    local kiracimi = 0
    for i,v in pairs(veriler) do
        if tostring(v.id) == tostring(id) then
            isyerisahibi = v.sahip
            fiyati = v.fiyati
            durum = v.durum
            tur = v.turu
            oncekikiraci = v.kiraci
        end
        if tostring(v.kiraci) == tostring(hesap) then
            kiracimi = kiracimi + 1
        end
    end
    local parasi = getPlayerMoney(source)
    if tostring(durum) == "Kiralık" then
        if tonumber(isyerikiralamasinir) > kiracimi then
            if tonumber(parasi) >= tonumber(fiyati) then
                if tostring(hesap) == tostring(isyerisahibi) then outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffKiralama başarısız. Kendi işyerinizi kiralayamazsınız.",source,255,255,255,true) return end
                takePlayerMoney(source,tonumber(fiyati))
                print("paran alındı kalan = "..getPlayerMoney(source))
                local adam = getAccountPlayer(getAccount(isyerisahibi))
                givePlayerMoney(adam,tonumber(fiyati))
                print("para geldi toplam = "..getPlayerMoney(adam))
                dbExec(db,"UPDATE veriler SET kiraci = ?, durum = ? WHERE id = ?",hesap,"Kirada",id)
                outputChatBox("#ff7f00● #ffffffBaşarıyla Bir İşyeri Kiraladınız!",source,255,255,255,true)
                outputChatBox("#ff7f00● #ffffffİşyeri Sırası: #ff7f00"..tostring(id).."#ffffff ✔",source,255,255,255,true)
                outputChatBox("#ff7f00● #ffffffİşyeri Türü: #ff7f00"..tostring(tur).."#ffffff ✔",source,255,255,255,true)
                outputChatBox("#ff7f00● #ffffffİşyeri Fiyatı: #ff7f00"..tostring(fiyati).."#ffffff ✔",source,255,255,255,true)
                outputChatBox("#ff7f00● #ffffffİşyeri Önceki Kiracı: #ff7f00"..tostring(oncekikiraci).."#ffffff ✔",source,255,255,255,true)
                outputChatBox("#ff7f00● #ffffffİşyeri Yeni Kiracı: #ff7f00"..tostring(hesap).."#ffffff ✔",source,255,255,255,true)
                triggerClientEvent(source,"WorkPlaceSystem:PaneliKapat",source)
            else
                outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffKiralama başarısız. Yeterli paranız bulunmamaktadır. Kiralama Fiyatı: #ff0000"..tostring(fiyati),source,255,255,255,true)
            end
        else
            outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffKiralama başarısız. İşyeri kiralama sınırını geçtiniz. İşyeri kiralama sınırı: #ff0000"..tostring(isyerikiralamasinir),source,255,255,255,true)
        end
    else
        outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffKiralama başarısız. İşyeri Durumu: #ff0000"..tostring(durum),source,255,255,255,true)
    end
end)

addEvent("WorkPlaceSystem:NotBirak",true)
addEventHandler("WorkPlaceSystem:NotBirak",getRootElement(),function(id,mesaj)
        if #mesaj >= 5 then
            for i,v in pairs(markerlar) do
                if tostring(v[2]) == tostring(id) then
                    if getElementData(v[1],"WorkPlaceSystem:NotuVarmi") == false then
                        local hesap = string.gsub(getPlayerName(source), "#%x%x%x%x%x%x", "")
                        setElementData(v[1],"WorkPlaceSystem:NotuVarmi",true)
                        setElementData(v[1],"WorkPlaceSystem:Notu",mesaj)
                        outputChatBox("#ff7f00● #ffffffBaşarıyla Not bıraktınız!",source,255,255,255,true)
                        outputChatBox("#ff7f00● #ffffffNotunuz: #ff7f00"..tostring(mesaj),source,255,255,255,true)
                    else
                        outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffNot Bırakma Başarısız. Zaten başka birisi not bırakmış.",source,255,255,255,true)
                    end
                end
            end
        else
            outputChatBox("#FF0000[BİLGİLENDİRME] #ffffffNot Bırakma Başarısız. Not en az 5 karakter olmalıdır.",source,255,255,255,true)
        end
end)

addEvent("WorkPlaceSystem:KilitGuncelle",true)
addEventHandler("WorkPlaceSystem:KilitGuncelle",getRootElement(),function(id,durum)
    if tonumber(durum) == 0 then
    dbExec(db,"UPDATE veriler SET kilit = ? WHERE id = ?","Kilitli",id)
    else
        dbExec(db,"UPDATE veriler SET kilit = ? WHERE id = ?","Kilitsiz",id)
    end
end)

addEvent("WorkPlaceSystem:LoginMyWorkPlace",true)
addEventHandler("WorkPlaceSystem:LoginMyWorkPlace",getRootElement(),function(id)
    local veriler = dbPoll(dbQuery(db,"SELECT * FROM veriler"),-1)
    for i,v in pairs(veriler) do
        if tostring(v["id"]) == tostring(id) then
            turua = v["turu"]
        end
    end
    setElementFrozen(source,false)
    fadeCamera(source,false)
    toggleAllControls(source,false)
    local hesapas = getPlayerAccount(source)
    triggerClientEvent(source,"WorkPlaceSystem:PaneliKapat2",source)
    for i,v in pairs(girismarkerlari) do
        if tostring(v[1]) == tostring(id) then
            markervarmi = true
        end
    end
    if markervarmi ~= true then
        px,py,pz = getElementPosition(source)
        if turua == "Market" then
            local markersasd = createMarker ( interiors[1][1], interiors[1][2], interiors[1][3]+1, "arrow", 1.2, 255, 127, 0, 170 )
            addEventHandler("onMarkerHit",markersasd,isyerindencikis)
            setElementInterior( markersasd, interiors[1][4])
            setElementDimension(markersasd,tonumber(id))
            table.insert( girismarkerlari,{id,markersasd})
          elseif turua == "Giyim" then
            local markersasd = createMarker ( interiors[2][1], interiors[2][2], interiors[2][3]+1, "arrow", 1.2, 255, 127, 0, 170 )
            addEventHandler("onMarkerHit",markersasd,isyerindencikis)
            setElementInterior( markersasd, interiors[2][4])
            setElementDimension(markersasd,tonumber(id))
            table.insert( girismarkerlari,{id,markersasd})
          elseif turua == "Kurum" then
            local markersasd = createMarker ( interiors[3][1], interiors[3][2], interiors[3][3]+1, "arrow", 1.2, 255, 127, 0, 170 )
            addEventHandler("onMarkerHit",markersasd,isyerindencikis)
            setElementInterior( markersasd, interiors[3][4])
            setElementDimension(markersasd,tonumber(id))
            table.insert( girismarkerlari,{id,markersasd})
          elseif turua == "Restorant" then
            local markersasd = createMarker ( interiors[4][1], interiors[4][2], interiors[4][3]+1, "arrow", 1.2, 255, 127, 0, 170 )
            addEventHandler("onMarkerHit",markersasd,isyerindencikis)
            setElementInterior( markersasd, interiors[4][4])
            setElementDimension(markersasd,tonumber(id))
            table.insert( girismarkerlari,{id,markersasd})
          elseif turua == "Şirket" then
            local markersasd = createMarker ( interiors[5][1], interiors[5][2], interiors[5][3]+1, "arrow", 1.2, 255, 127, 0, 170 )
            addEventHandler("onMarkerHit",markersasd,isyerindencikis)
            setElementInterior( markersasd, interiors[5][4])
            setElementDimension(markersasd,tonumber(id))
            table.insert( girismarkerlari,{id,markersasd})
          end
    end
    setAccountData(hesapas,"WorkPlaceSystem:Giris","true")
    setTimer( function( player )
        if getPedOccupiedVehicle( player ) then removePedFromVehicle( player ) end
        if turua == "Market" then
          setElementInterior( player, interiors[1][4], interiors[1][1], interiors[1][2], interiors[1][3])
        elseif turua == "Giyim" then
          setElementInterior( player, interiors[2][4], interiors[2][1], interiors[2][2], interiors[2][3])
        elseif turua == "Kurum" then
          setElementInterior( player, interiors[3][4], interiors[3][1], interiors[3][2], interiors[3][3])
        elseif turua == "Restorant" then
          setElementInterior( player, interiors[4][4], interiors[4][1], interiors[4][2], interiors[4][3])
        elseif turua == "Şirket" then
          setElementInterior( player, interiors[5][4], interiors[5][1], interiors[5][2], interiors[5][3])
        end
          setElementDimension(player, tonumber(id))
          toggleAllControls( player, true );
          fadeCamera( player, true );
      end, 1200, 1, client, t );
      setTimer(function(player)
        setAccountData(hesapas,"WorkPlaceSystem:Giris","false")
    end,2000,1,client,t)
end)