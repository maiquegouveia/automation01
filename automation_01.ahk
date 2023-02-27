#SingleInstance, Force
#Include, <Rufaydium>

chrome := new Rufaydium("chromedriver.exe")
chrome.capabilities.setUserProfile("Default")
driver := chrome.NewSession()

WinWaitActive, ahk_exe chrome.exe
WinMaximize, ahk_exe chrome.exe

driver.Navigate("https://maiquegouveia.pythonanywhere.com/admin/login")
Sleep, 3000

; Authentication process

username := driver.getElementByID("username")
password := driver.getElementByID("password")
submit_btn := driver.getElementByID("submit_btn")

if(username){
    username.SendKey("USERNAME")
    Sleep, 1000
    if(password){
        password.SendKey("PASSWORD")
        Sleep, 1000
        if(submit_btn){
            submit_btn.Click()
            Sleep, 1000
        } else {
            MsgBox, , Alert, Couldn't find submit button!
            Goto, end
        }
    } else {
        MsgBox, , Alert, Couldn't find password!
        Goto, end
    }
} else {
    MsgBox, , Alert, Couldn't find username!
    Goto, end
}

; Getting inbox screenshot

elements := driver.getElementsbyXpath("//*[@id='navbarCenteredExample']/ul/li[2]/a")
if(elements){
    inbox := elements[0]
    inbox.Click()
    Sleep, 3000
    driver.Screenshot(A_desktop "/inboxUpdate.png")
    Sleep, 1000
} else {
    MsgBox, , Alert, Couldn't find inbox!
    Goto, end
}

; Logging out

elements := driver.getElementsbyXpath("/html/body/nav/div/ul/li/a")
if(elements){
    logout := elements[0]
    logout.Click()
    Sleep, 3000
    MsgBox, , Alert, Script is done!, 10
    Goto, end
} else {
    MsgBox, , Alert, Couldn't find logout!
    Goto, end
}


end:
chrome.QuitAllSessions()
chrome.Driver.Exit()
ExitApp