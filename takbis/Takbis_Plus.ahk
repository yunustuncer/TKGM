; Takbis Plus  ****  V.25_1﻿

;********** Başvuru Monitörü Genişlik Ve Aşıklama Menüsü **************

#Persistent
#SingleInstance Force

; Başlıkla pencereyi eşleştirme
SetTitleMatchMode, 2

global isHovering := false

; Menü oluşturma
Menu, Sub, Add, Alıcı, Write_Alici
Menu, Sub, Add, Emlak Beyan, Write_EmlakBeyan
Menu, Sub, Add, Serh Beyan, Write_SerhBeyan
Menu, Sub, Add, Şahit, Write_Sahit
Menu, Sub, Add, Okur-Yazar, Write_OkurDegil
Menu, Sub, Add, Tam Satış, Write_TamSatis
Menu, Sub, Add, Hisseli Satış, Write_HisseliSatis
Menu, Sub, Add, VİV İlişiği, Write_Viv


SetTimer, CheckWindow, 1000
SetTimer, CheckMousePosition, 50
return

CheckWindow:
    ; Pencere açıldığında başlıkta "Plus" yoksa genişliği ayarla
    if WinExist("TF0106 - Başvuru Belgeleri") {
        ; Başlık referansını kontrol et
        WinGetTitle, currentTitle, TF0106 - Başvuru Belgeleri
        if (InStr(currentTitle, "Plus") = 0) {  ; Eğer başlıkta "Plus" yoksa
            ; Pencereyi genişlet ve başlığı "Plus" olarak değiştir
            WinGet, windowState, MinMax, TF0106 - Başvuru Belgeleri
            if (windowState = 0) {  ; Eğer pencere normal modda
                WinGetPos, winX, winY, winW, winH, TF0106 - Başvuru Belgeleri
                if (winW != 1083) {  ; Eğer genişlik 1083 değilse
                    WinMove, TF0106 - Başvuru Belgeleri, , winX, winY, 1083, winH  ; Genişliği 1083 olarak ayarla
                }
                ; Başlığı "Plus" olarak değiştir
                WinSetTitle, TF0106 - Başvuru Belgeleri, , TF0106 - Başvuru Belgeleri-Plus
            }
        }
    }
return

CheckMousePosition:
    WinGetTitle, activeTitle, A
    if (activeTitle ~= "TF0106 - Başvuru Belgeleri") {
        MouseGetPos, xpos, ypos
        WinGetPos, winX, winY, winW, winH, TF0106 - Başvuru Belgeleri  ; Pencere boyutlarını al

        panelTop := winH - 280  ; **Alt kenardan 300 piksel yukarıya al**
        panelBottom := winH - 135  ; **Alt kenardan 200 piksel yukarıya al**

        if (xpos > 754 && xpos < 985 && ypos > panelTop && ypos < panelBottom) {
            isHovering := true
        } else {
            isHovering := false
        }
    } else {
        isHovering := false  ; Farklı pencere aktifse menü çıkmasın
    }
return

~RButton::
    ; Eğer sağ tıklama ahk_class #32768 pencere menüsü açıyorsa engelle
    IfWinExist ahk_class #32768
    {
        WinClose, ahk_class #32768  ; Sistem menüsünü kapat
    }

    if (!isHovering) {
        return  ; **Koordinat dışında sağ tıklanınca hiçbir şey yapma**
    }

    ; Menü göster
    Menu, Sub, Show
return



Write_Alici:
    ControlClick, TdxDBMemo1, TF0106 - Başvuru Belgeleri
    ClipBoard := "Alıcı:......................"
    Send, ^v
    Send, {Enter}
return


Write_EmlakBeyan:
    ControlClick, TdxDBMemo1, TF0106 - Başvuru Belgeleri
    ClipBoard := "Bedel: Emlak beyan değeri olarak alınmasını talep etmekteyiz."
    Send, ^v
    Send, {Enter}
return


Write_SerhBeyan:
    ControlClick, TdxDBMemo1, TF0106 - Başvuru Belgeleri
    ClipBoard := "Şerh-Beyan-Rehinleri kabul ediyorum."
    Send, ^v
    Send, {Enter}
return


Write_Sahit:
    ControlClick, TdxDBMemo1, TF0106 - Başvuru Belgeleri
    ClipBoard := "Şahitler;......................................"
    Send, ^v
    Send, {Enter}
return



Write_TamSatis:
    ControlClick, TdxDBMemo1, TF0106 - Başvuru Belgeleri
    ClipBoard := "Hissenin tamamı satılıyor"
    Send, ^v
    Send, {Enter}
return

Write_HisseliSatis:
    ControlClick, TdxDBMemo1, TF0106 - Başvuru Belgeleri
    ClipBoard := "Hissemin .......... metrekaresini satmaktayım."
    Send, ^v
    Send, {Enter}
return

Write_OkurDegil:
    ControlClick, TdxDBMemo1, TF0106 - Başvuru Belgeleri
    ClipBoard := "Taraflardan ............................ okuryazar değil."
    Send, ^v
    Send, {Enter}
return


Write_Viv:
    ControlClick, TdxDBMemo1, TF0106 - Başvuru Belgeleri
    ClipBoard := "Viv ilişiği kesilmeyecek."
    Send, ^v
    Send, {Enter}
return

