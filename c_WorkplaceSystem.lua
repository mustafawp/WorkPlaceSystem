-- DEVELOPMENT BY BURAKMRX --
loadstring(exports.dgs:dgsImportFunction())()


local id
Genislik,Uzunluk = dgsGetScreenSize()
Genislika,Uzunluka = 615,320
X = (Genislik/2) - (Genislika/2)
Y = (Uzunluk/2) - (Uzunluka/2)

mainwindow = dgsCreateWindow(X, Y, Genislika, Uzunluka, "İş Yeri Yönetim", false)
dgsWindowSetSizable(mainwindow, false)
dgsSetVisible(mainwindow,false)
dgsWindowSetCloseButtonEnabled(mainwindow,false)

maintabpanel = dgsCreateTabPanel(5, 7, 604, 282, false, mainwindow)

mainIsYeriOlusturtab = dgsCreateTab("Oluştur", maintabpanel)
isyeriSiralbl = dgsCreateLabel(281, 32, 100, 20, "İş Yeri Sıra: ", false, mainIsYeriOlusturtab)
isyeriSiratxt = dgsCreateEdit(386, 28, 184, 29, "....", false, mainIsYeriOlusturtab)
isyeriSahibilbl = dgsCreateLabel(281, 73, 100, 20, "İş Yeri Sahibi: ", false, mainIsYeriOlusturtab)
isyeriSahibitxt = dgsCreateEdit(386, 68, 184, 29, "....", false, mainIsYeriOlusturtab)
isyeriTurulbl = dgsCreateLabel(281, 111, 100, 20, "İş Yeri Türü: ", false, mainIsYeriOlusturtab)
isyeriTuruchbox = dgsCreateComboBox(386, 107, 184, 29, "Seçiniz..", false, mainIsYeriOlusturtab)
dgsComboBoxAddItem(isyeriTuruchbox,"Market")
dgsComboBoxAddItem(isyeriTuruchbox,"Giyim")
dgsComboBoxAddItem(isyeriTuruchbox,"Kurum")
dgsComboBoxAddItem(isyeriTuruchbox,"Restorant")
dgsComboBoxAddItem(isyeriTuruchbox,"Şirket")
isyeriFiyatilbl = dgsCreateLabel(281, 151, 100, 20, "İş Yeri Fiyatı: ", false, mainIsYeriOlusturtab)
isyeriFiyatitxt = dgsCreateEdit(386, 146, 184, 29, "....", false, mainIsYeriOlusturtab)
isyeriOlusturbtn = dgsCreateButton(331, 191, 165, 44, "İş Yeri Oluştur", false, mainIsYeriOlusturtab)

mainIsYeriDuzenletab = dgsCreateTab("Düzenle", maintabpanel)

isyeriList1 = dgsCreateGridList(19, 10, 271, 237, false, mainIsYeriDuzenletab)
dgsGridListAddColumn(isyeriList1, "Sıra", 0.3)
dgsGridListAddColumn(isyeriList1, "Ünvan", 0.3)
dgsGridListAddColumn(isyeriList1, "Türü", 0.3)
dgsGridListAddColumn(isyeriList1, "Fiyat", 0.3)
dgsGridListAddColumn(isyeriList1, "Kilit", 0.3)
isyeriSiralbl1 = dgsCreateLabel(309, 20, 84, 20, "İş Yeri Sıra", false, mainIsYeriDuzenletab)
isyeriSiratxt1 = dgsCreateEdit(403, 16, 170, 29, "....", false, mainIsYeriDuzenletab)
isyeriUnvanlbl1 = dgsCreateLabel(309, 64, 84, 20, "İş Yeri Sahibi", false, mainIsYeriDuzenletab)
isYeriUnvantxt1 = dgsCreateEdit(403, 55, 170, 29, "....", false, mainIsYeriDuzenletab)
dgsEditSetMaxLength(isYeriUnvantxt1, 16)
isyeriTurulbl1 = dgsCreateLabel(309, 98, 84, 20, "İş Yeri Türü", false, mainIsYeriDuzenletab)
isyeriTuruchbox1 = dgsCreateComboBox(403, 94, 170, 29, "Seçiniz..", false, mainIsYeriDuzenletab)
dgsComboBoxAddItem(isyeriTuruchbox1,"Market")
dgsComboBoxAddItem(isyeriTuruchbox1,"Giyim")
dgsComboBoxAddItem(isyeriTuruchbox1,"Kurum")
dgsComboBoxAddItem(isyeriTuruchbox1,"Restorant")
dgsComboBoxAddItem(isyeriTuruchbox1,"Şirket")
isyeriKilidilbl1 = dgsCreateLabel(309, 138, 84, 20, "İş Yeri Kilidi", false, mainIsYeriDuzenletab)
isyeriKilidichbox1 = dgsCreateComboBox(403, 133, 170, 29, "Seçiniz..", false, mainIsYeriDuzenletab)
dgsComboBoxAddItem(isyeriKilidichbox1,"Kilitli")
dgsComboBoxAddItem(isyeriKilidichbox1,"Kilitsiz")
isyeriDuzenlebtn1 = dgsCreateButton(359, 188, 154, 44, "İş Yerini Güncelle", false, mainIsYeriDuzenletab)

mainIsYeriSiltab = dgsCreateTab("Sil", maintabpanel)

isyeriList2 = dgsCreateGridList(10, 15, 322, 232, false, mainIsYeriSiltab)
dgsGridListAddColumn(isyeriList2, "Sıra", 0.3)
dgsGridListAddColumn(isyeriList2, "Ünvan", 0.3)
dgsGridListAddColumn(isyeriList2, "Sahibi", 0.3)
isyeriSiralbl2 = dgsCreateLabel(370, 55, 75, 16, "İş Yeri Sıra", false, mainIsYeriSiltab)
isyeriSiratxt2 = dgsCreateEdit(455, 49, 109, 28, "....", false, mainIsYeriSiltab)
isyeriKaldirilmalbl2 = dgsCreateLabel(380, 98, 174, 15, "Kaldırılma Sebebi (isteğe bağlı)", false, mainIsYeriSiltab)
isyeriKaldirilmatxt2 = dgsCreateEdit(346, 122, 241, 28, "....", false, mainIsYeriSiltab)
isyeriKaldirbtn = dgsCreateButton(390, 186, 165, 41, "Kaldır", false, mainIsYeriSiltab)
--
mainpanelkapat = dgsCreateButton(593, -25, 22, 25, "X", false, mainwindow)

-- Giriş Paneli
Genislikx,Uzunlukx = 531,226
Xx = (Genislik/2) - (Genislikx/2)
Yx = (Uzunluk/2) - (Uzunlukx/2)

giriswindow = dgsCreateWindow(Xx, Yx, Genislikx, Uzunlukx, "İşyeri", false)
dgsWindowSetSizable(giriswindow, false)
dgsSetVisible(giriswindow,false)
dgsWindowSetCloseButtonEnabled(giriswindow,false)

local font0_Font13 = dgsCreateFont("files/veriler/Font13.ttf", 10)
girisunvanlbl = dgsCreateLabel(22, 12, 244, 21, "➥ İşyeri Sırası: ", false, giriswindow)
dgsSetFont(girisunvanlbl, font0_Font13)
girissahiblbl = dgsCreateLabel(22, 43, 244, 21, "➥ İşyeri Sahibi: ", false, giriswindow)
dgsSetFont(girissahiblbl, font0_Font13)
girisdurumlbl = dgsCreateLabel(22, 74, 244, 21, "➥ İşyeri Durumu: ", false, giriswindow)
dgsSetFont(girisdurumlbl, font0_Font13)
giristurulbl = dgsCreateLabel(22, 105, 244, 21, "➥ İşyeri Türü: ", false, giriswindow)
dgsSetFont(giristurulbl, font0_Font13)
girisfiyatlbl = dgsCreateLabel(22, 136, 244, 21, "➥ İşyeri Fiyatı: ", false, giriswindow)
dgsSetFont(girisfiyatlbl, font0_Font13)
giriscizgilbl = dgsCreateLabel(273, 12, 15, 172, "|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|", false, giriswindow)
girissatinalbtn = dgsCreateButton(319, 12, 174, 40, "Satın Al", false, giriswindow)
dgsSetFont(girissatinalbtn, font0_Font13)
giriskiralabtn = dgsCreateButton(319, 111, 174, 40, "Kirala", false, giriswindow)
dgsSetFont(giriskiralabtn, font0_Font13)
girisgirisyapbtn = dgsCreateButton(319, 61, 174, 40, "Giriş Yap", false, giriswindow)
dgsSetFont(girisgirisyapbtn, font0_Font13)
girisnotbiraktxt = dgsCreateEdit(292, 161, 115, 27, "", false, giriswindow)
dgsEditSetMaxLength(girisnotbiraktxt, 25)
girisnotbirakbtn = dgsCreateButton(417, 161, 90, 27, "Not Bırak", false, giriswindow)
dgsSetFont(girisnotbirakbtn, font0_Font13)
giriskapatbtn = dgsCreateButton(506, -25, 25, 25, "X", false, giriswindow)

-- Yönetim Paneli
Genisliky,Uzunluky = 531,356
Xy = (Genislik/2) - (Genisliky/2)
Yy = (Uzunluk/2) - (Uzunluky/2)

yonetimwindow = dgsCreateWindow(Xy, Yy, Genisliky, Uzunluky, "Yönetim", false)
dgsWindowSetSizable(yonetimwindow, false)
dgsSetVisible(yonetimwindow,false)
dgsWindowSetCloseButtonEnabled(yonetimwindow,false)

yonetimgirisbtn = dgsCreateButton(299, 17, 162, 43, "İşyerine Gir", false, yonetimwindow)
dgsSetFont(yonetimgirisbtn, font0_Font13)
yonetimkilitbtn = dgsCreateButton(82, 17, 162, 43, "Kilit: Kilitsiz", false, yonetimwindow)
dgsSetFont(yonetimkilitbtn, font0_Font13)
yonetimcizgilbl = dgsCreateLabel(0, 70, 527, 15, "⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻", false, yonetimwindow)
yonetimkiraliksatiliktxt = dgsCreateEdit(184, 100, 175, 33, "", false, yonetimwindow)
yonetimkiraligacikartbtn = dgsCreateButton(299, 142, 162, 43, "Kiralığa Çıkart", false, yonetimwindow)
dgsSetFont(yonetimkiraligacikartbtn, font0_Font13)
yonetimsatiligacikartbtn = dgsCreateButton(82, 142, 162, 43, "Satılığa Çıkart", false, yonetimwindow)
dgsSetFont(yonetimsatiligacikartbtn, font0_Font13)
yonetimkapatbtn = dgsCreateButton(506, -25  , 25, 25, "X", false, yonetimwindow)

--KODLAMA--
addEventHandler("onDgsMouseClickUp",getRootElement(),function()
    if source == isyeriOlusturbtn then
        if dgsGetText(isyeriSiratxt) == "" or dgsGetText(isyeriSahibitxt) == "" or dgsGetText(isyeriFiyatitxt) == "" or dgsComboBoxGetSelectedItem(isyeriTuruchbox) == -1 or dgsGetText(isyeriSiratxt) == "...." or dgsGetText(isyeriSahibitxt) == "...." or dgsGetText(isyeriFiyatitxt) == "...." then
            outputChatBox("Lütfen boş yer bırakmadığınızdan ve seçim yaptığınızdan emin olun.",255,255,255)
        else
            secili = dgsComboBoxGetSelectedItem(isyeriTuruchbox)
            local sira, sahip, tur, fiyat = dgsGetText(isyeriSiratxt), dgsGetText(isyeriSahibitxt), dgsComboBoxGetItemText(isyeriTuruchbox,secili), dgsGetText(isyeriFiyatitxt)
            triggerServerEvent("WorkPlaceSystem:Olustur",localPlayer,sira,sahip,tur,fiyat)
            dgsSetVisible(mainwindow,false)
            showCursor(false)
            outputChatBox("Başarıyla #ff7f00Yeni Bir İş Yeri #ffffffOluşturdunuz!",255,255,255,true)
            outputChatBox("#ff7f00● #ffffffİş Yeri Sırası: #ff7f00"..sira.."#ffffff ✔",255,255,255,true)
            outputChatBox("#ff7f00● #ffffffİş Yeri Sahibi: #ff7f00"..sahip.."#ffffff ✔",255,255,255,true)
            outputChatBox("#ff7f00● #ffffffİş Yeri Türü: #ff7f00"..tur.."#ffffff ✔",255,255,255,true)
            outputChatBox("#ff7f00● #ffffffİş Yeri Fiyatı: #ff7f00"..fiyat.."#ffffff ✔",255,255,255,true)
        end
    end
    if source == isyeriList1 then
            local sel = dgsGridListGetSelectedItem(isyeriList1)
            if sel ~= -1 then 
                            dgsSetText(isyeriSiratxt1,dgsGridListGetItemText(isyeriList1,sel,1))
                            dgsSetText(isYeriUnvantxt1,dgsGridListGetItemText(isyeriList1,sel,2))
                            if dgsGridListGetItemText(isyeriList1,sel,3) == "Market" then
                                dgsComboBoxSetSelectedItem(isyeriTuruchbox1,1)
                            elseif dgsGridListGetItemText(isyeriList1,sel,3) == "Giyim" then
                                dgsComboBoxSetSelectedItem(isyeriTuruchbox1,2)
                            elseif dgsGridListGetItemText(isyeriList1,sel,3) == "Kurum" then
                                dgsComboBoxSetSelectedItem(isyeriTuruchbox1,3)
                            elseif dgsGridListGetItemText(isyeriList1,sel,3) == "Restorant" then
                                dgsComboBoxSetSelectedItem(isyeriTuruchbox1,4)
                            elseif dgsGridListGetItemText(isyeriList1,sel,3) == "Şirket" then
                                dgsComboBoxSetSelectedItem(isyeriTuruchbox1,5)
                            end
                            if tostring(dgsGridListGetItemText(isyeriList1,sel,5)) == "Kilitli" then
                                    dgsComboBoxSetSelectedItem(isyeriKilidichbox1,1)
                            else
                                    dgsComboBoxSetSelectedItem(isyeriKilidichbox1,2)
                            end
                    else
                            dgsSetText(isyeriSiratxt1,"")
                            dgsSetText(isYeriUnvantxt1,"")
                            dgsComboBoxSetSelectedItem(isyeriTuruchbox1,-1)
                            dgsComboBoxSetSelectedItem(isyeriKilidichbox1,-1)
            end
    end
    if source == isyeriList2 then
        local sel = dgsGridListGetSelectedItem(isyeriList2)
        if sel ~= -1 then 
            dgsSetText(isyeriSiratxt2,dgsGridListGetItemText(isyeriList2,sel,1))
        else
            dgsSetText(isyeriSiratxt2,"")
        end
    end
    if source == isyeriDuzenlebtn1 then
        local sel = dgsGridListGetSelectedItem(isyeriList1)
        if sel ~= -1 then 
        secili1 = dgsComboBoxGetSelectedItem(isyeriTuruchbox1)
        secili2 = dgsComboBoxGetSelectedItem(isyeriKilidichbox1)
        local sira, unvan, tur, kilitdrm = dgsGetText(isyeriSiratxt1), dgsGetText(isYeriUnvantxt1), dgsComboBoxGetItemText(isyeriTuruchbox1,secili1), dgsComboBoxGetItemText(isyeriKilidichbox1,secili2)
        if kilitdrm == "Kilitli" then
            kilitdrm = 0
        else
            kilitdrm = 1
        end
        local defid = dgsGridListGetItemText(isyeriList1,sel,1)
        triggerServerEvent("WorkPlaceSystem:İnfoUpdate",localPlayer,sira,unvan,tur,kilitdrm,defid)
        dgsSetVisible(mainwindow,false)
        showCursor(false)
    else
        outputChatBox("Lütfen listeden, düzenleyeceğiniz işyerini seçin.",255,255,255)
    end
    end
    if source == isyeriKaldirbtn then
        local id = dgsGetText(isyeriSiratxt2)
        local text = dgsGetText(isyeriKaldirilmatxt2)
        local secilia = dgsGridListGetSelectedItem(isyeriList2)
        local sahibi = dgsGridListGetItemText(isyeriList2,secilia,3)
        if id == "" or id == "...." then
            outputChatBox("Lütfen silmek istediğiniz evin sıra numarasını yazın veya listeden seçin.",255,255,255)
            return
        else
            if text == "" or text == "...." then
                local durum = false
                triggerServerEvent("WorkPlaceSystem:Delete",localPlayer,id,durum,text,sahibi)
                dgsSetVisible(mainwindow,false)
                showCursor(false)
            else
                local durum = true
                triggerServerEvent("WorkPlaceSystem:Delete",localPlayer,id,durum,text,sahibi)
                dgsSetVisible(mainwindow,false)
                showCursor(false)
            end
        end
    end
    if source == girisgirisyapbtn then
        triggerServerEvent("WorkPlaceSystem:LoginToWorkPlace",localPlayer,id)
    end
    if source == girissatinalbtn then
        triggerServerEvent("WorkPlaceSystem:SatinAlma",localPlayer,id)
    end
    if source == yonetimkapatbtn then
        dgsSetVisible(yonetimwindow,false)
        showCursor(false)
    end
    if source == giriskiralabtn then
        triggerServerEvent("WorkPlaceSystem:Kiralama",localPlayer,id)
    end
    if source == girisnotbirakbtn then
        local sa = dgsGetText(girisnotbiraktxt)
        triggerServerEvent("WorkPlaceSystem:NotBirak",localPlayer,id,sa)
    end
    if source == yonetimkilitbtn then
        local text = dgsGetText(yonetimkilitbtn)
        local yapilcak
        if text == "Kilit: Kilitsiz" then
            yapilcak = 0
            outputChatBox("#ffffffBaşarıyla #ff7f00işyerinin kilitlendi.",255,255,255,true)
            dgsSetText(yonetimkilitbtn,"Kilit: Kilitli")
        else
            yapilcak = 1
            outputChatBox("#ffffffBaşarıyla #ff7f00işyerinin kilidi açıldı.",255,255,255,true)
            dgsSetText(yonetimkilitbtn,"Kilit: Kilitsiz")
        end
        triggerServerEvent("WorkPlaceSystem:KilitGuncelle",localPlayer,id,yapilcak)
    end
    if source == yonetimgirisbtn then
        triggerServerEvent("WorkPlaceSystem:LoginMyWorkPlace",localPlayer,id)
    end
    if source == yonetimsatiligacikartbtn then
        local miktar = dgsGetText(yonetimkiraliksatiliktxt)
        if dgsGetText(yonetimsatiligacikartbtn) == "Satılığa Çıkart" then
            dgsSetText(yonetimsatiligacikartbtn,"Satışı İptal Et")
        else
            dgsSetText(yonetimsatiligacikartbtn,"Satılığa Çıkart")
        end
        triggerServerEvent("WorkPlaceSystem:SatiligaCikar",localPlayer,id,miktar)
    end
    if source == yonetimkiraligacikartbtn then
        local miktar = dgsGetText(yonetimkiraliksatiliktxt)
        if dgsGetText(yonetimkiraligacikartbtn) == "Kiralığa Çıkart" then
            dgsSetText(yonetimsatiligacikartbtn,"Kirayı İptal Et")
        else
            dgsSetText(yonetimsatiligacikartbtn,"Kiralığa Çıkart")
        end
        triggerServerEvent("WorkPlaceSystem:KiraligaCikar",localPlayer,id,miktar)
    end
    if source == yonetimcalismasaatibtn then
        local text = dgsGetText(yonetimsaatunvantxt)
        if text == "7/24" then

        else
            if #text == 11 then
                if string.find(tostring(text),":") and string.find(tostring(text),"-") then
                    triggerServerEvent("WorkPlaceSystem:CalismaSaatiniGuncelle",localPlayer,id,text)
                else
                    outputChatBox("#FFFFFFÇalışma saati ÖRNEK #ff0000'07:30-21:30' #ffffffgibi olması veya #ff0000'7/24' #ffffffolması gerekmektedir.",255,255,255,true)
                end
            else
                outputChatBox("#FFFFFFÇalışma saati ÖRNEK #ff0000'07:30-21:30' #ffffffgibi olması veya #ff0000'7/24' #ffffffolması gerekmektedir.",255,255,255,true)
            end
        end
    end
end)

addEvent("WorkPlaceSystem:AdminPanel",true)
addEventHandler("WorkPlaceSystem:AdminPanel",getRootElement(),function(result)
    dgsGridListClear(isyeriList1)
    dgsGridListClear(isyeriList2)
    for i,v in pairs(result) do
                row = dgsGridListAddRow(isyeriList1) 
                dgsGridListSetItemText(isyeriList1,row,1,v["id"])
                dgsGridListSetItemText(isyeriList1,row,2,v["sahip"])
                dgsGridListSetItemText(isyeriList1,row,3,v["turu"])
                dgsGridListSetItemText(isyeriList1,row,4,v["fiyati"])
                if v["kilit"] == 0 then
                    dgsGridListSetItemText(isyeriList1,row,5,"Kilitli")
                else
                    dgsGridListSetItemText(isyeriList1,row,5,"Kilitsiz")
                end
                row2 = dgsGridListAddRow(isyeriList2) 
                dgsGridListSetItemText(isyeriList2,row2,1,v["id"])
                dgsGridListSetItemText(isyeriList2,row2,2,v[""])
                dgsGridListSetItemText(isyeriList2,row2,3,v["sahip"])
    end
    dgsSetVisible(mainwindow,true)
    showCursor(true)
end)

addEvent("WorkPlaceSystem:GirisEkrani",true)
addEventHandler("WorkPlaceSystem:GirisEkrani",getRootElement(),function(veriler)
    for i,v in pairs(veriler) do
        dgsSetText(girisunvanlbl,"➥ İşyeri Ünvanı: "..tostring(v["unvan"]))
        dgsSetText(girissahiblbl,"➥ İşyeri Sahibi: "..tostring(v["sahip"]))
        dgsSetText(girisdurumlbl,"➥ İşyeri Durumu: "..tostring(v["durum"]))
        dgsSetText(giristurulbl,"➥ İşyeri Türü: "..tostring(v["turu"]))
        if v["durum"] == "Kiralık" then
        dgsSetText(girisfiyatlbl,"➥ İşyeri Kiralama Fiyatı: "..tostring(v["fiyati"]))
        else
            dgsSetText(girisfiyatlbl,"➥ İşyeri Satış Fiyatı: "..tostring(v["fiyati"]))
        end
        dgsSetText(giriscalismasaatlerilbl,"➥ Çalışma Saatleri: "..tostring(v["saat"]))
        id = tonumber(v["id"])
        if v["kilit"] == 0 then
        dgsSetText(yonetimkilitbtn,"Kilit: Kilitli")
        else
            dgsSetText(yonetimkilitbtn,"Kilit: Kilitsiz")
        end
        if v["durum"] == "Satılık" then
            dgsSetText(yonetimsatiligacikartbtn,"Satışı İptal Et")
        elseif v["durum"] == "Satılık Değil" then
            dgsSetVisible(yonetimsatiligacikartbtn,"Satılığa Çıkart")
        elseif v["durum"] == "Kiralık" then
            dgsSetVisible(yonetimkiraligacikartbtn,"Kirayı İptal Et")
        end
        dgsSetVisible(giriswindow,true)
        showCursor(true)
    end
end)

addEvent("WorkPlaceSystem:Owner",true)
addEventHandler("WorkPlaceSystem:Owner",getRootElement(),function(durum)
    if durum == "sahibi" then
        dgsSetEnabled(yonetimkiraligacikartbtn,true)
        dgsSetEnabled(yonetimsatiligacikartbtn,true)
        dgsSetEnabled(yonetimkiraliksatiliktxt,true)
        dgsSetVisible(yonetimwindow,true)
        showCursor(true)
    elseif durum == "kiracı" then
        dgsSetEnabled(yonetimkiraligacikartbtn,false)
        dgsSetEnabled(yonetimsatiligacikartbtn,false)
        dgsSetEnabled(yonetimkiraliksatiliktxt,false)
        dgsSetVisible(yonetimwindow,true)
        showCursor(true)
    end
end)

addEvent("WorkPlaceSystem:PaneliKapat",true)
addEventHandler("WorkPlaceSystem:PaneliKapat",getRootElement(),function()
    dgsSetVisible(giriswindow,false)
    showCursor(false)
end)

addEvent("WorkPlaceSystem:PaneliKapat2",true)
addEventHandler("WorkPlaceSystem:PaneliKapat2",getRootElement(),function()
    dgsSetVisible(yonetimwindow,false)
    showCursor(false)
end)

addEventHandler("onDgsMouseClickUp",getRootElement(),function()
    if source == mainpanelkapat then
        dgsSetVisible(mainwindow,false)
        showCursor(false)
    end
    if source == isyeriKaldirilmatxt2 then
        if dgsGetText(isyeriKaldirilmatxt2) == "...." then
            dgsSetText(isyeriKaldirilmatxt2,"")
        end
    end
    if source == isyeriSiratxt2 then
        if dgsGetText(isyeriSiratxt2) == "...." then
            dgsSetText(isyeriSiratxt2,"")
        end
    end
    if source == isYeriUnvantxt1 then
        if dgsGetText(isYeriUnvantxt1) == "...." then
            dgsSetText(isYeriUnvantxt1,"")
        end
    end
    if source == isyeriSiratxt1 then
        if dgsGetText(isyeriSiratxt1) == "...." then
            dgsSetText(isyeriSiratxt1,"")
        end
    end
    if source == isyeriFiyatitxt then
        if dgsGetText(isyeriFiyatitxt) == "...." then
            dgsSetText(isyeriFiyatitxt,"")
        end
    end
    if source == isyeriSahibitxt then
        if dgsGetText(isyeriSahibitxt) == "...." then
            dgsSetText(isyeriSahibitxt,"")
        end
    end
    if source == isyeriSiratxt then
        if dgsGetText(isyeriSiratxt) == "...." then
            dgsSetText(isyeriSiratxt,"")
        end
    end
    if source == giriskapatbtn then
        dgsSetVisible(giriswindow,false)
        showCursor(false)
    end
end)

addEventHandler("onDgsComboBoxSelect", getRootElement(), function()
    secili = dgsComboBoxGetSelectedItem(isyeriTuruchbox)
    if secili == 1 then
        dgsSetVisible(isyeriolusturResim,false)
        dgsSetVisible(isyeriolusturResim1,true)
        dgsSetVisible(isyeriolusturResim2,false)
        dgsSetVisible(isyeriolusturResim3,false)
        dgsSetVisible(isyeriolusturResim4,false)
        dgsSetVisible(isyeriolusturResim5,false)
    elseif secili == 2 then
        dgsSetVisible(isyeriolusturResim,false)
        dgsSetVisible(isyeriolusturResim1,false)
        dgsSetVisible(isyeriolusturResim2,true)
        dgsSetVisible(isyeriolusturResim3,false)
        dgsSetVisible(isyeriolusturResim4,false)
        dgsSetVisible(isyeriolusturResim5,false)
    elseif secili == 3 then
        dgsSetVisible(isyeriolusturResim,false)
        dgsSetVisible(isyeriolusturResim1,false)
        dgsSetVisible(isyeriolusturResim2,false)
        dgsSetVisible(isyeriolusturResim3,true)
        dgsSetVisible(isyeriolusturResim4,false)
        dgsSetVisible(isyeriolusturResim5,false)
    elseif secili == 4 then
        dgsSetVisible(isyeriolusturResim,false)
        dgsSetVisible(isyeriolusturResim1,false)
        dgsSetVisible(isyeriolusturResim2,false)
        dgsSetVisible(isyeriolusturResim3,false)
        dgsSetVisible(isyeriolusturResim4,true)
        dgsSetVisible(isyeriolusturResim5,false)
    elseif secili == 5 then
        dgsSetVisible(isyeriolusturResim,false)
        dgsSetVisible(isyeriolusturResim1,false)
        dgsSetVisible(isyeriolusturResim2,false)
        dgsSetVisible(isyeriolusturResim3,false)
        dgsSetVisible(isyeriolusturResim4,false)
        dgsSetVisible(isyeriolusturResim5,true)
    end
end)
