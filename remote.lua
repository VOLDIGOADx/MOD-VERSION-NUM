local TABLE_VERSION = 22
local approvedID = ""
local accessGranted = false


function resetToggleBox()
    for i = 1, 24 do
        local toggleboxName = "CEToggleBox" .. i
        if UDF1[toggleboxName] then
            UDF1[toggleboxName].checked = false
        end
    end
end




function checkUpdate()

local version_url = "https://raw.githubusercontent.com/VOLDIGOADx/MOD-VERSION-NUM/main/ZEREF%20MOD%20VERSION.txt"
local tableLink_url = "https://raw.githubusercontent.com/VOLDIGOADx/MOD-VERSION-NUM/main/MOD%20LINK.txt"
local tablePasswordLink_url = "https://raw.githubusercontent.com/VOLDIGOADx/MOD-VERSION-NUM/main/PASSWORD.txt"
local approvedID_url = "https://voldigoad-dashboard.vercel.app/api/hwids/cached"



local http_version = getInternet()
local version_result = http_version.getURL(version_url)
http_version.destroy()


local http_tableLink = getInternet()
local tableLink_url_result = http_tableLink.getURL(tableLink_url)
http_tableLink.destroy()


local http_approvedID = getInternet()
approvedID = http_approvedID.getURL(approvedID_url)
http_approvedID.destroy()


if version_result then
  local version = tonumber(version_result:match("%d+"))
  if version == 0 then
    local answer = messageDialog("Zeref mod tool is currently updating and not available.\nPlease Stay Tuned for the update!\n\nWould you like to be forwarded to our server channel ?", mtInformation, mbYes, mbNo)
    if answer == mrYes then
      ShellExecute("https://discord.com/channels/853619521142390784/896466356994723921")
      os.exit()
    else
    os.exit()
    end
  end
  if TABLE_VERSION < version then
    local answer = messageDialog("There is a newer version of this table.\nPlease download it to be able to use mod!", mtWarning, mbYes, mbNo)
    if answer == mrYes then
      ShellExecute(tablePasswordLink_url)
      ShellExecute(tableLink_url_result)
      os.exit()
    else
    os.exit()
    end
  end
else
  messageDialog("Please Make Sure You Are Connected To Internet!\nProgram Will Shutdown..", mtError, mbOK)
  os.exit()
end
end

checkUpdate()



function formdrag1d8101()
UDF1.dragNow()
end

function closeform1d8101()
os.exit()
end




function formdrag2d8101()
UDF1.dragNow()
end

function closeform2d8101()
os.exit()
end


-- Function to generate a fixed device ID using PowerShell to get the UUID
function generateDeviceID()
    -- Use PowerShell to get the UUID
    local file = io.popen('powershell -Command "Get-WmiObject -Class Win32_ComputerSystemProduct | Select-Object -ExpandProperty UUID"')
    local uuid = file:read("*a")
    file:close()
    return uuid:match("%S+"):gsub("-", "")  -- Extract and format device ID
end

-- Your specific approved device ID
--local approvedID = "30444335383254305144BCE92F7EDE90"  -- Replace with your approved ID without hyphens

-- Create a new form
local form = createForm(false)
form.Caption = 'Device ID Access'
form.Width = 400
form.Height = 200

-- Create a new CEEdit box named CEEdit1
local CEEdit1 = createEdit(form)
CEEdit1.Name = 'CEEdit1'
CEEdit1.Left = 20
CEEdit1.Top = 50
CEEdit1.Width = 360
CEEdit1.Text = generateDeviceID()  -- Display generated device ID in CEEdit1
writeToClipboard(ansiToUtf8(CEEdit1.Text))
CEEdit1.ReadOnly = true  -- Ensure CEEdit1 is read-only

-- Function to show a message box
function showMessage(msg)
    messageDialog(msg, mtInformation, mbOK)
end


























-- Function to check access based on input in CEEdit1
function checkAccess()
    local deviceID = CEEdit1.Text  -- Get device ID from CEEdit1
    local accessGranted = false    -- default to false

    -- Check if the device ID is approved
    if string.find(approvedID, deviceID) then
        accessGranted = true
    end

    if accessGranted then
        -- Enable the main trainer form
        if UDF1 then
            UDF1.Enabled = true
        end

        showMessage("Access granted. Trainer is loading...")

        -- Here you can call any additional initialization code for the trainer
    else
        -- Freeze the main trainer form
        if UDF1 then
            UDF1.Enabled = false
        end

        -- Create the "Access Denied" popup
        local denyForm = createForm(true)  -- modal = true
        denyForm.Caption = "Access Denied"
        denyForm.Width = 605
        denyForm.Height = 220
        denyForm.Position = "poScreenCenter"

        -- If user closes the popup with the X button, close the whole trainer
        denyForm.OnClose = function()
            os.exit()
        end

        -- Message label
        local msgLabel = createLabel(denyForm)
        msgLabel.Caption = "This device is not approved.\n\nYour User ID is shown below. Please send this ID to "
        msgLabel.Left = 20
        msgLabel.Top = 20
        msgLabel.Width = 340
        msgLabel.Height = 40

        -- Clickable contact label
        local contactLabel = createLabel(denyForm)
        contactLabel.Caption = "ZEREF VOLDIGOAD"
        contactLabel.Left = msgLabel.Left + msgLabel.Width
        contactLabel.Top = msgLabel.Top + 50
        contactLabel.Font.Style = "fsUnderline"
        contactLabel.Font.Color = 0x0000FF
        contactLabel.Cursor = -21
        contactLabel.OnClick = function()
            local contactForm = createForm(true)
            contactForm.Caption = "Contact Options"
            contactForm.Width = 300
            contactForm.Height = 220
            contactForm.Position = "poScreenCenter"

            local discordBtn = createButton(contactForm)
            discordBtn.Caption = "Discord"
            discordBtn.Left = 80
            discordBtn.Top = 20
            discordBtn.Width = 120
            discordBtn.OnClick = function()
                ShellExecute("https://discord.com/users/819518873643646976")
            end

            local gmailBtn = createButton(contactForm)
            gmailBtn.Caption = "Gmail"
            gmailBtn.Left = 80
            gmailBtn.Top = 60
            gmailBtn.Width = 120
            gmailBtn.OnClick = function()
                ShellExecute("https://mail.google.com/mail/u/0/?to=voldigoadzeref@gmail.com&su=Access+Request&body=Hello,+I+want+access+to+your+zeref_voldigoad_mod_tool&fs=1&tf=cm")
            end

            local whatsappBtn = createButton(contactForm)
            whatsappBtn.Caption = "WhatsApp"
            whatsappBtn.Left = 80
            whatsappBtn.Top = 100
            whatsappBtn.Width = 120
            whatsappBtn.OnClick = function()
                ShellExecute("https://api.whatsapp.com/send/?phone=905075638741&text=Hello%2C+I+want+access+to+your+zeref_voldigoad_mod_tool&type=phone_number&app_absent=0")
            end

            local instaBtn = createButton(contactForm)
            instaBtn.Caption = "Instagram"
            instaBtn.Left = 80
            instaBtn.Top = 140
            instaBtn.Width = 120
            instaBtn.OnClick = function()
                ShellExecute("https://www.instagram.com/sosultane/")
            end
        end

        -- Show the device ID in a read-only box
        local idBox = createEdit(denyForm)
        idBox.Text = deviceID
        idBox.Left = 20
        idBox.Top = 100
        idBox.Width = 570
        idBox.ReadOnly = true

        -- Auto-copy once
        writeToClipboard(ansiToUtf8(deviceID))

        -- Copy button
        local copyButton = createButton(denyForm)
        copyButton.Caption = "Copy ID"
        copyButton.Left = 140
        copyButton.Top = 160
        copyButton.Width = 100
        copyButton.OnClick = function()
            writeToClipboard(ansiToUtf8(deviceID))
            showMessage("User ID copied to clipboard!")
        end

        -- Close button (closes whole trainer)
        local closeButton = createButton(denyForm)
        closeButton.Caption = "Close"
        closeButton.Left = 260
        closeButton.Top = 160
        closeButton.Width = 100
        closeButton.OnClick = function()
            os.exit()
        end

        denyForm.show()
    end
end


















-- Create a button to trigger access check
local checkButton = createButton(form)
checkButton.Caption = "Check Access"
checkButton.Left = 150
checkButton.Top = 100
checkButton.OnClick = checkAccess

-- Show the form
if accessGranted ~= true then
--form.show()
end

-- Perform initial access check on form launch
checkAccess()




































-- Ensure the GUI is shown by default
UDF1.show()

-- Define the original button color
local originalButtonColor = 0x00212121

-- Function to reset CECustomButtons to default state
function resetTrainerGUI()
    for i = 1, 29 do
        local buttonName = "CECustomButton" .. i
        local button = UDF1[buttonName]
        if button then
            button.buttoncolor = originalButtonColor
        end
    end
end

-- Function to play the 'loading.wav' sound file
function playLoadingSound()
    -- Attempt to find and play the sound file
    local soundFile = findTableFile('loading.wav')
    if soundFile then
        playSound(soundFile)
    else
        print('Sound file "loading.wav" not found')
    end
end




-- Function to attach to the game process
function attach()
    local GameID = getProcessIDFromProcessName("BleachBraveSouls.exe")
    if GameID ~= getOpenedProcessID() and GameID ~= nil then
        resetToggleBox()
        openProcess("BleachBraveSouls.exe")
        UDF1.hide()  -- Hide the GUI
        resetTrainerGUI() -- Reset colors instantly
        playLoadingSound() -- Play the loading sound
        local hideTimer = createTimer(nil, false)
        hideTimer.OnTimer = function()
            UDF1.show()  -- Show the GUI again after 8 seconds
            hideTimer.destroy()  -- Destroy the timer after it has executed
        end
        hideTimer.Interval = 8000  -- 8 seconds
        hideTimer.Enabled = true
    end
end


-========================================
-- AUTO ATTACH + AUTO MONO (STABLE)
--========================================

local PROCESS_NAME = "BleachBraveSouls.exe"

local attachTimer = nil
local monoTimer = nil


-- AUTO ATTACH
attachTimer = createTimer(nil,false)
attachTimer.Interval = 2000

attachTimer.OnTimer = function(t)

    if getOpenedProcessID() ~= 0 then return end

    local pid = getProcessIDFromProcessName(PROCESS_NAME)

    if pid then
        openProcess(pid)
        print("Attached to "..PROCESS_NAME)

        createThread(ActivateMemoryPatch)

        t.destroy()
    end
end

attachTimer.Enabled = true


function ActivateMemoryPatch(thread)
  sleep(3000) -- change this value if it's still rushing the game
  if LaunchMonoDataCollector() == 0 then
  else
    while monopipe and not monoSymbolList.FullyLoaded do
    sleep(10)
    end
  end
  return;
end












-- Function to reset the trainer GUI and play the loading sound when GUI is hidden
function onHide()
    resetTrainerGUI()
    playLoadingSound() -- Play the loading sound
end

-- Register onHide function to execute when GUI is hidden
UDF1.OnHide = onHide

-- Timer to continuously check for the game process and reset GUI when game is not running
local checkGameTimer = createTimer(nil, false)
timer_onTimer(checkGameTimer, checkGameStatus)
timer_setInterval(checkGameTimer, 5000)  -- Check every 5 seconds
timer_setEnabled(checkGameTimer, true)

-- Timer to continuously check for the game process and attach when detected
local attachTimer = createTimer(nil, false)
timer_onTimer(attachTimer, attach)
timer_setInterval(attachTimer, 4000)
timer_setEnabled(attachTimer, true)








function runGameOnClick(sender)
    shellExecute('steam://rungameid/1201240')
end





local attachedTime = os.time() -- Record the time when the game is attached
local enableCloseFunctionTime = attachedTime + 5 -- Enable close function 30 seconds after game attachment

function closeGameWithCmd()
    local currentTime = os.time()
    if currentTime < enableCloseFunctionTime then
        -- If the current time is before the enable time, return without closing the game
        return
    end
    local processName = "BleachBraveSouls.exe"
    local command = 'taskkill /F /IM "' .. processName .. '"'
    local hiddenCmd = 'cmd.exe /C "' .. command .. '" >nul 2>&1'
    os.execute(hiddenCmd)
end

function closeGameWithCmdOnClick(sender)
    closeGameWithCmd()
end








-- Function to configure the minimize action for CEPanel1
function configureMinimizePanel()
  -- Reference your custom panel
  local minimizePanel = UDF1.CEPanel1

  -- Ensure the panel exists
  if minimizePanel then
    -- Set the panel's OnClick event to minimize the form
    minimizePanel.OnClick = function()
      UDF1.WindowState = 'wsMinimized'
    end
  end
end

-- Call the function to configure the minimize panel
configureMinimizePanel()






function onCustomButton1Click()
  -- Check the current color of CustomButton2 and toggle it
  if UDF1.CECustomButton1.buttoncolor == 0x212121 then
    UDF1.CECustomButton1.buttoncolor = 0xD36F70
  else
    UDF1.CECustomButton1.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox1
  UDF1.CEToggleBox1.checked = not UDF1.CEToggleBox1.checked
end

-- Assign the function to the OnClick event of CustomButton1
UDF1.CECustomButton1.OnClick = onCustomButton1Click








-- Flag to track if CustomButton2 is clicked
local customButton2Clicked = false

-- Function to update button enable/disable state based on CustomButton2
local function updateButtonStates()
  local enableButtons = not customButton2Clicked
  UDF1.CECustomButton8.enabled = enableButtons
  UDF1.CECustomButton9.enabled = enableButtons
  UDF1.CECustomButton10.enabled = enableButtons
  UDF1.CECustomButton11.enabled = enableButtons
end

-- Function for CustomButton2 click event
function onCustomButton2Click()
  -- Toggle the color of CustomButton2
  if UDF1.CECustomButton2.buttoncolor == 0x212121 then
    UDF1.CECustomButton2.buttoncolor = 0xD36F70
  else
    UDF1.CECustomButton2.buttoncolor = 0x212121
  end

  -- Toggle the checked state of ToggleBox2
  UDF1.CEToggleBox2.checked = not UDF1.CEToggleBox2.checked

  -- Update the flag and enable/disable state of other buttons
  customButton2Clicked = not customButton2Clicked
  updateButtonStates()
end

-- Assign the function to the OnClick event of CustomButton2
UDF1.CECustomButton2.OnClick = onCustomButton2Click

-- Function for CustomButton8 click event
function onCustomButton8Click()
  if customButton2Clicked then
    return  -- Do nothing if CustomButton2 is clicked
  end
  -- Your existing logic for CustomButton8 click
end

-- Assign the function to the OnClick event of CustomButton8
UDF1.CECustomButton8.OnClick = onCustomButton8Click

-- Function for CustomButton9 click event
function onCustomButton9Click()
  if customButton2Clicked then
    return  -- Do nothing if CustomButton2 is clicked
  end
  -- Your existing logic for CustomButton9 click
end

-- Assign the function to the OnClick event of CustomButton9
UDF1.CECustomButton9.OnClick = onCustomButton9Click

-- Function for CustomButton10 click event
function onCustomButton10Click()
  if customButton2Clicked then
    return  -- Do nothing if CustomButton2 is clicked
  end
  -- Your existing logic for CustomButton10 click
end

-- Assign the function to the OnClick event of CustomButton10
UDF1.CECustomButton10.OnClick = onCustomButton10Click

-- Function for CustomButton11 click event
function onCustomButton11Click()
  if customButton2Clicked then
    return  -- Do nothing if CustomButton2 is clicked
  end
  -- Your existing logic for CustomButton11 click
end

-- Assign the function to the OnClick event of CustomButton11
UDF1.CECustomButton11.OnClick = onCustomButton11Click










function onCustomButton3Click()
  -- Check the current color of CustomButton3 and toggle it
  if UDF1.CECustomButton3.buttoncolor == 0x212121 then
    UDF1.CECustomButton3.buttoncolor = 0xD36F70
  else
    UDF1.CECustomButton3.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox3
  UDF1.CEToggleBox3.checked = not UDF1.CEToggleBox3.checked
end

-- Assign the function to the OnClick event of CustomButton3
UDF1.CECustomButton3.OnClick = onCustomButton3Click









function onCustomButton4Click()
  -- Check the current color of CustomButton4 and toggle it
  if UDF1.CECustomButton4.buttoncolor == 0x212121 then
    UDF1.CECustomButton4.buttoncolor = 0xD36F70
  else
    UDF1.CECustomButton4.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox4
  UDF1.CEToggleBox4.checked = not UDF1.CEToggleBox4.checked
end

-- Assign the function to the OnClick event of CustomButton4
UDF1.CECustomButton4.OnClick = onCustomButton4Click















function onCustomButton5Click()
  -- Check the current color of CustomButton5 and toggle it
  if UDF1.CECustomButton5.buttoncolor == 0x212121 then
    UDF1.CECustomButton5.buttoncolor = 0x85A032
  else
    UDF1.CECustomButton5.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox5
  UDF1.CEToggleBox5.checked = not UDF1.CEToggleBox5.checked
end

-- Assign the function to the OnClick event of CustomButton5
UDF1.CECustomButton5.OnClick = onCustomButton5Click






function onCustomButton6Click()
  -- Check the current color of CustomButton6 and toggle it
  if UDF1.CECustomButton6.buttoncolor == 0x212121 then
    UDF1.CECustomButton6.buttoncolor = 0x85A032
  else
    UDF1.CECustomButton6.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox6
  UDF1.CEToggleBox6.checked = not UDF1.CEToggleBox6.checked
end

-- Assign the function to the OnClick event of CustomButton6
UDF1.CECustomButton6.OnClick = onCustomButton6Click





function onCustomButton7Click()
  -- Check the current color of CustomButton7 and toggle it
  if UDF1.CECustomButton7.buttoncolor == 0x212121 then
    UDF1.CECustomButton7.buttoncolor = 0x85A032  -- Change to desired color value
  else
    UDF1.CECustomButton7.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox7
  UDF1.CEToggleBox7.checked = not UDF1.CEToggleBox7.checked
end

-- Assign the function to the OnClick event of CustomButton7
UDF1.CECustomButton7.OnClick = onCustomButton7Click





function onCustomButton26Click()
  -- Check the current color of CustomButton26 and toggle it
  if UDF1.CECustomButton26.buttoncolor == 0x212121 then
    UDF1.CECustomButton26.buttoncolor = 0x85A032  -- Change to desired color value
  else
    UDF1.CECustomButton26.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox8
  UDF1.CEToggleBox8.checked = not UDF1.CEToggleBox8.checked
end

-- Assign the function to the OnClick event of CustomButton26
UDF1.CECustomButton26.OnClick = onCustomButton26Click











function onCustomButton27Click()
  -- Check the current color of CustomButton27 and toggle it
  if UDF1.CECustomButton27.buttoncolor == 0x212121 then
    UDF1.CECustomButton27.buttoncolor = 0x85A032  -- Change to desired color value
  else
    UDF1.CECustomButton27.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox9
  UDF1.CEToggleBox9.checked = not UDF1.CEToggleBox9.checked
end

-- Assign the function to the OnClick event of CustomButton27
UDF1.CECustomButton27.OnClick = onCustomButton27Click








function onCustomButton8Click()
  -- Check the current color of CustomButton8 and toggle it
  if UDF1.CECustomButton8.buttoncolor == 0x212121 then
    UDF1.CECustomButton8.buttoncolor = 0x2E84A5  -- Change to desired color value
  else
    UDF1.CECustomButton8.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox10
  UDF1.CEToggleBox10.checked = not UDF1.CEToggleBox10.checked
end

-- Assign the function to the OnClick event of CustomButton8
UDF1.CECustomButton8.OnClick = onCustomButton8Click




function onCustomButton9Click()
  -- Check the current color of CustomButton9 and toggle it
  if UDF1.CECustomButton9.buttoncolor == 0x212121 then
    UDF1.CECustomButton9.buttoncolor = 0x38389A  -- Change to desired color value
  else
    UDF1.CECustomButton9.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox11
  UDF1.CEToggleBox11.checked = not UDF1.CEToggleBox11.checked
end

-- Assign the function to the OnClick event of CustomButton9
UDF1.CECustomButton9.OnClick = onCustomButton9Click









function onCustomButton10Click()
  -- Check the current color of CustomButton10 and toggle it
  if UDF1.CECustomButton10.buttoncolor == 0x212121 then
    UDF1.CECustomButton10.buttoncolor = 0x38389A  -- Change to desired color value
  else
    UDF1.CECustomButton10.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox12
  UDF1.CEToggleBox12.checked = not UDF1.CEToggleBox12.checked
end

-- Assign the function to the OnClick event of CustomButton10
UDF1.CECustomButton10.OnClick = onCustomButton10Click








function onCustomButton11Click()
  -- Check the current color of CustomButton11 and toggle it
  if UDF1.CECustomButton11.buttoncolor == 0x212121 then
    UDF1.CECustomButton11.buttoncolor = 0x38389A  -- Change to desired color value
  else
    UDF1.CECustomButton11.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox13
  UDF1.CEToggleBox13.checked = not UDF1.CEToggleBox13.checked
end

-- Assign the function to the OnClick event of CustomButton11
UDF1.CECustomButton11.OnClick = onCustomButton11Click




function onCustomButton12Click()
  -- Check the current color of CustomButton12 and toggle it
  if UDF1.CECustomButton12.buttoncolor == 0x212121 then
    UDF1.CECustomButton12.buttoncolor = 0xD271A2  -- Change to desired color value
  else
    UDF1.CECustomButton12.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox14
  UDF1.CEToggleBox14.checked = not UDF1.CEToggleBox14.checked
end

-- Assign the function to the OnClick event of CustomButton12
UDF1.CECustomButton12.OnClick = onCustomButton12Click


















function onCustomButton14Click()
  -- Check the current color of CustomButton14 and toggle it
  if UDF1.CECustomButton14.buttoncolor == 0x212121 then
    UDF1.CECustomButton14.buttoncolor = 0x777777  -- Change to desired color value
  else
    UDF1.CECustomButton14.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox15
  UDF1.CEToggleBox15.checked = not UDF1.CEToggleBox15.checked
end

-- Assign the function to the OnClick event of CustomButton14
UDF1.CECustomButton14.OnClick = onCustomButton14Click




function onCustomButton15Click()
  -- Check the current color of CustomButton15 and toggle it
  if UDF1.CECustomButton15.buttoncolor == 0x212121 then
    UDF1.CECustomButton15.buttoncolor = 0x777777  -- Change to desired color value
  else
    UDF1.CECustomButton15.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox16
  UDF1.CEToggleBox16.checked = not UDF1.CEToggleBox16.checked
end

-- Assign the function to the OnClick event of CustomButton15
UDF1.CECustomButton15.OnClick = onCustomButton15Click




function onCustomButton16Click()
  -- Check the current color of CustomButton16 and toggle it
  if UDF1.CECustomButton16.buttoncolor == 0x212121 then
    UDF1.CECustomButton16.buttoncolor = 0x777777  -- Change to desired color value
  else
    UDF1.CECustomButton16.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox17
  UDF1.CEToggleBox17.checked = not UDF1.CEToggleBox17.checked
end

-- Assign the function to the OnClick event of CustomButton16
UDF1.CECustomButton16.OnClick = onCustomButton16Click





function onCustomButton17Click()
  -- Check the current color of CustomButton17 and toggle it
  if UDF1.CECustomButton17.buttoncolor == 0x212121 then
    UDF1.CECustomButton17.buttoncolor = 0x777777  -- Change to desired color value
  else
    UDF1.CECustomButton17.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox18
  UDF1.CEToggleBox18.checked = not UDF1.CEToggleBox18.checked
end

-- Assign the function to the OnClick event of CustomButton17
UDF1.CECustomButton17.OnClick = onCustomButton17Click






function onCustomButton18Click()
  -- Check the current color of CustomButton18 and toggle it
  if UDF1.CECustomButton18.buttoncolor == 0x212121 then
    UDF1.CECustomButton18.buttoncolor = 0x777777  -- Change to desired color value
  else
    UDF1.CECustomButton18.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox19
  UDF1.CEToggleBox19.checked = not UDF1.CEToggleBox19.checked
end

-- Assign the function to the OnClick event of CustomButton18
UDF1.CECustomButton18.OnClick = onCustomButton18Click





function onCustomButton19Click()
  -- Check the current color of CustomButton19 and toggle it
  if UDF1.CECustomButton19.buttoncolor == 0x212121 then
    UDF1.CECustomButton19.buttoncolor = 0x777777  -- Change to desired color value
  else
    UDF1.CECustomButton19.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox20
  UDF1.CEToggleBox20.checked = not UDF1.CEToggleBox20.checked
end

-- Assign the function to the OnClick event of CustomButton19
UDF1.CECustomButton19.OnClick = onCustomButton19Click






function onCustomButton31Click()
  -- Check the current color of CustomButton31 and toggle it
  if UDF1.CECustomButton31.buttoncolor == 0x212121 then
    UDF1.CECustomButton31.buttoncolor = 0x777777  -- Change to desired color value
  else
    UDF1.CECustomButton31.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox21
  UDF1.CEToggleBox21.checked = not UDF1.CEToggleBox21.checked
end

-- Assign the function to the OnClick event of CustomButton31
UDF1.CECustomButton31.OnClick = onCustomButton31Click





























function onCustomButton21Click()
  -- Check the current color of CustomButton21 and toggle it
  if UDF1.CECustomButton21.buttoncolor == 0x212121 then
    UDF1.CECustomButton21.buttoncolor = 0x777777  -- Change to desired color value
  else
    UDF1.CECustomButton21.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox22
  UDF1.CEToggleBox22.checked = not UDF1.CEToggleBox22.checked
end

-- Assign the function to the OnClick event of CustomButton21
UDF1.CECustomButton21.OnClick = onCustomButton21Click











function onCustomButton22Click()
  -- Check the current color of CustomButton22 and toggle it
  if UDF1.CECustomButton22.buttoncolor == 0x212121 then
    UDF1.CECustomButton22.buttoncolor = 0x777777  -- Change to desired color value
  else
    UDF1.CECustomButton22.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox23
  UDF1.CEToggleBox23.checked = not UDF1.CEToggleBox23.checked
end

-- Assign the function to the OnClick event of CustomButton22
UDF1.CECustomButton22.OnClick = onCustomButton22Click




function onCustomButton23Click()
  -- Check the current color of CustomButton23 and toggle it
  if UDF1.CECustomButton23.buttoncolor == 0x212121 then
    UDF1.CECustomButton23.buttoncolor = 0x777777  -- Change to desired color value
  else
    UDF1.CECustomButton23.buttoncolor = 0x212121
  end

  -- Simulate a click on ToggleBox24
  UDF1.CEToggleBox24.checked = not UDF1.CEToggleBox24.checked
end

-- Assign the function to the OnClick event of CustomButton23
UDF1.CECustomButton23.OnClick = onCustomButton23Click
























function showDialog()
    showMessage('This mod is made by: zeref voldigoad                                🆉🅴🆁🅴🅵 🆅🅾🅻🅳🅸🅶🅾🅰🅳                                           contributers:       Turbo☢—「☬」 - mrdarkflame')
end




function openYouTube()
    shellExecute('https://discord.gg/x6u7JjWxAw')
end

















-- Define global variables to store disable info GOD MODE
local SCRIPT_1_disableInfo, SCRIPT_2_disableInfo, SCRIPT_3_disableInfo, SCRIPT_4_disableInfo
local SCRIPT_5_disableInfo, SCRIPT_6_disableInfo, SCRIPT_7_disableInfo, SCRIPT_8_disableInfo
local SCRIPT_9_disableInfo, SCRIPT_10_disableInfo, SCRIPT_11_disableInfo

function ToggleBox1Click(sender)

    local script1 = [[
{ Game   : BleachBraveSouls.exe invincible     Bleach.Games.QuestBattle.Characters.CharaBase.InvincibleRoutine
  Version:
  Date   : 2024-05-26
  Author : Mohammed

  This script does blah blah blah
}

define(address,Bleach.Games.QuestBattle.Characters.CharaBase.InvincibleRoutine+3B)

[ENABLE]

assert(address,bytes)
alloc(newmem,$1000,Bleach.Games.QuestBattle.Characters.CharaBase.InvincibleRoutine+3B)

label(code)
label(return)
label(invinsiblePlayer)

newmem:
  cmp byte ptr [rbx+39],01    //IsPlayerSide
  je invinsiblePlayer
  cmp byte ptr [rbx+39],01    //IsPlayerSide
  jne code

invinsiblePlayer:
  mov [rbx+00000270],(float)1
  movss xmm6,[rbx+00000270]
  jmp return

code:
  movss xmm6,[rbx+00000270]
  jmp return

address:
  jmp newmem
  nop 3
return:

[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.CharaBase.InvincibleRoutine+3B:
movss xmm6,[rbx+00000270]
//Alt: db F3 0F 10 B3 70 02 00 00
    ]]





    local script4 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat     Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsInvalidSuperArmor
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsInvalidSuperArmor)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsInvalidSuperArmor:
jmp newmem
nop 3
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsInvalidSuperArmor:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

//Alt: db 48 83 EC 28 48 8B 41 20
    ]]

    local script5 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat INVA GUARD     Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsInvalidGuard
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsInvalidGuard)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsInvalidGuard:
jmp newmem
nop 3
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsInvalidGuard:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

//Alt: db 48 83 EC 28 48 8B 41 20
    ]]

local script6 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat    Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsHitHiddenEnemyProb
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsHitHiddenEnemyProb)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsHitHiddenEnemyProb:
jmp newmem
nop 3
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsHitHiddenEnemyProb:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

//Alt: db 48 83 EC 38 48 8B 41 20
    ]]

local script7 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat     Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBadStInvalidProb
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBadStInvalidProb)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBadStInvalidProb:
jmp newmem
nop 3
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBadStInvalidProb:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

//Alt: db 48 83 EC 38 48 8B 41 28
    ]]

local script8 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat     Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBlueAttackCrossProb
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBlueAttackCrossProb)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBlueAttackCrossProb:
jmp newmem
nop 3
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBlueAttackCrossProb:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

//Alt: db 48 83 EC 38 48 8B 41 28
    ]]

local script9 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat    Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRedAttackCrossProb
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRedAttackCrossProb)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRedAttackCrossProb:
jmp newmem
nop 3
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRedAttackCrossProb:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

//Alt: db 48 83 EC 38 48 8B 41 28
    ]]

local script10 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat BLIND RESIST  Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_BlindResistRate
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_BlindResistRate)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_BlindResistRate:
jmp newmem
nop 3
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_BlindResistRate:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

//Alt: db 48 83 EC 28 48 8B 41 28
    ]]

local script11 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat    Bleach.Games.QuestBattle.Characters.AbilityEnhancement.IsDyingSurvivalProb
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.IsDyingSurvivalProb)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.IsDyingSurvivalProb:
jmp newmem
nop
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.IsDyingSurvivalProb:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al
//Alt: db 40 53 48 83 EC 30
    ]]

local script17 = [[
[ENABLE]
{$Lua}
if syntaxcheck then return end
-- Play the loading sound when enabled
playSound(findTableFile('buttonpress.wav'))
{$Asm}

[DISABLE]
{$Lua}
if syntaxcheck then return end
{$Asm}
    ]]

    -- Check if ToggleBox1 is checked
    if sender.Checked then
        -- Enable scripts
        local SCRIPT_1_enabledOk
        SCRIPT_1_enabledOk, SCRIPT_1_disableInfo = autoAssemble(script1)
        if not SCRIPT_1_enabledOk then
            local message = "Error enabling script 1"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_2_enabledOk
        SCRIPT_2_enabledOk, SCRIPT_2_disableInfo = autoAssemble(script2)
        if not SCRIPT_2_enabledOk then
            local message = "Error enabling script 2"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_3_enabledOk
        SCRIPT_3_enabledOk, SCRIPT_3_disableInfo = autoAssemble(script3)
        if not SCRIPT_3_enabledOk then
            local message = "Error enabling script 3"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_4_enabledOk
        SCRIPT_4_enabledOk, SCRIPT_4_disableInfo = autoAssemble(script4)
        if not SCRIPT_4_enabledOk then
            local message = "Error enabling script 4"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_5_enabledOk
        SCRIPT_5_enabledOk, SCRIPT_5_disableInfo = autoAssemble(script5)
        if not SCRIPT_5_enabledOk then
            local message = "Error enabling script 5"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_6_enabledOk
        SCRIPT_6_enabledOk, SCRIPT_6_disableInfo = autoAssemble(script6)
        if not SCRIPT_6_enabledOk then
            local message = "Error enabling script 6"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_7_enabledOk
        SCRIPT_7_enabledOk, SCRIPT_7_disableInfo = autoAssemble(script7)
        if not SCRIPT_7_enabledOk then
            local message = "Error enabling script 7"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_8_enabledOk
        SCRIPT_8_enabledOk, SCRIPT_8_disableInfo = autoAssemble(script8)
        if not SCRIPT_8_enabledOk then
            local message = "Error enabling script 8"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_9_enabledOk
        SCRIPT_9_enabledOk, SCRIPT_9_disableInfo = autoAssemble(script9)
        if not SCRIPT_9_enabledOk then
            local message = "Error enabling script 9"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_10_enabledOk
        SCRIPT_10_enabledOk, SCRIPT_10_disableInfo = autoAssemble(script10)
        if not SCRIPT_10_enabledOk then
            local message = "Error enabling script 10"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_11_enabledOk
        SCRIPT_11_enabledOk, SCRIPT_11_disableInfo = autoAssemble(script11)
        if not SCRIPT_11_enabledOk then
            local message = "Error enabling script 11"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_17_enabledOk
        SCRIPT_17_enabledOk, SCRIPT_17_disableInfo = autoAssemble(script17)
        if not SCRIPT_17_enabledOk then
            local message = "Error enabling script 17"
            messageDialog(message, mtWarning, mbOK)
        end

    else
        -- Disable scripts
        if SCRIPT_1_disableInfo then
            local SCRIPT_1_disabledOk = autoAssemble(script1, SCRIPT_1_disableInfo)
            if SCRIPT_1_disabledOk then
                SCRIPT_1_disableInfo = nil
            end
        end

        if SCRIPT_2_disableInfo then
            local SCRIPT_2_disabledOk = autoAssemble(script2, SCRIPT_2_disableInfo)
            if SCRIPT_2_disabledOk then
                SCRIPT_2_disableInfo = nil
            end
        end

        if SCRIPT_3_disableInfo then
            local SCRIPT_3_disabledOk = autoAssemble(script3, SCRIPT_3_disableInfo)
            if SCRIPT_3_disabledOk then
                SCRIPT_3_disableInfo = nil
            end
        end

        if SCRIPT_4_disableInfo then
            local SCRIPT_4_disabledOk = autoAssemble(script4, SCRIPT_4_disableInfo)
            if SCRIPT_4_disabledOk then
                SCRIPT_4_disableInfo = nil
            end
        end

        if SCRIPT_5_disableInfo then
            local SCRIPT_5_disabledOk = autoAssemble(script5, SCRIPT_5_disableInfo)
            if SCRIPT_5_disabledOk then
                SCRIPT_5_disableInfo = nil
            end
        end

        if SCRIPT_6_disableInfo then
            local SCRIPT_6_disabledOk = autoAssemble(script6, SCRIPT_6_disableInfo)
            if SCRIPT_6_disabledOk then
                SCRIPT_6_disableInfo = nil
            end
        end

        if SCRIPT_7_disableInfo then
            local SCRIPT_7_disabledOk = autoAssemble(script7, SCRIPT_7_disableInfo)
            if SCRIPT_7_disabledOk then
                SCRIPT_7_disableInfo = nil
            end
        end

        if SCRIPT_8_disableInfo then
            local SCRIPT_8_disabledOk = autoAssemble(script8, SCRIPT_8_disableInfo)
            if SCRIPT_8_disabledOk then
                SCRIPT_8_disableInfo = nil
            end
        end

        if SCRIPT_9_disableInfo then
            local SCRIPT_9_disabledOk = autoAssemble(script9, SCRIPT_9_disableInfo)
            if SCRIPT_9_disabledOk then
                SCRIPT_9_disableInfo = nil
            end
        end

        if SCRIPT_10_disableInfo then
            local SCRIPT_10_disabledOk = autoAssemble(script10, SCRIPT_10_disableInfo)
            if SCRIPT_10_disabledOk then
                SCRIPT_10_disableInfo = nil
            end
        end

        if SCRIPT_11_disableInfo then
            local SCRIPT_11_disabledOk = autoAssemble(script11, SCRIPT_11_disableInfo)
            if SCRIPT_11_disabledOk then
                SCRIPT_11_disableInfo = nil
            end
        end

        if SCRIPT_17_disableInfo then
            local SCRIPT_17_disabledOk = autoAssemble(script17, SCRIPT_17_disableInfo)
            if SCRIPT_17_disabledOk then
                SCRIPT_17_disableInfo = nil
            end
        end


    end
end






-- Define global variables to store disable info   NERF ENEMIES
local SCRIPT_12_disableInfo, SCRIPT_13_disableInfo, SCRIPT_14_disableInfo, SCRIPT_15_disableInfo, SCRIPT_17_disableInfo

function ToggleBox2Click(sender)

    local script12 = [[
[ENABLE]
alloc(newmem,2048,Bleach.Games.QuestBattle.UI.CharacterStatus.set_HP+78)            //Bleach.Games.QuestBattle.UI.CharacterStatus.set_HP
label(returnhere)
label(originalcode)
label(enemies)
label(exit)

newmem:
    cmp byte ptr [rbx+B9],01   // IsPlayerSide check         Bleach.Games.TeamBattleCore.UI.CharacterThumbnailUI.SetVisibleEndureHp
    je originalcode
    jne enemies

enemies:
    mov dword ptr [rbx+80],1   // Force enemy HP to 1         x   Bleach.Games.QuestBattle.UI.CharacterStatus.get_HPMax
    jmp originalcode

originalcode:
    mov r9d,[rbx+00000080]     // Original instruction
    jmp exit

exit:
    jmp returnhere

Bleach.Games.QuestBattle.UI.CharacterStatus.set_HP+78:
    jmp newmem
    nop 2
returnhere:

[DISABLE]
dealloc(newmem)
Bleach.Games.QuestBattle.UI.CharacterStatus.set_HP+78:
    mov r9d,[rbx+00000080]
// Alt: db 44 8B 8B 80 00 00 00
    ]]

    local script13 = [[
{ Game   : BleachBraveSouls.exe
  Version:
  Date   : 2024-05-23
  Author : YT_SyntaXError305

  This script does blah blah blah
}

[ENABLE]

aobscanmodule(Temp,GameAssembly.dll,66 0F 6E 41 50) // should be unique
alloc(newmem,$100,Temp)

label(code)
label(return)

newmem:

code:
  mov [rcx+50],#1 //d xmm0
  jmp return

Temp:
  jmp newmem
return:
registersymbol(Temp)

[DISABLE]

Temp:
  db 66 0F 6E 41 50

unregistersymbol(Temp)
dealloc(newmem)


    ]]

    local script14 = [[
define(address,Bleach.Games.CoQuestBattle.Core.Characters.Enemies.AI.CoEnemyAi.BaseUpdate+76)

[ENABLE]

assert(address,bytes)
alloc(newmem,$1000,Bleach.Games.CoQuestBattle.Core.Characters.Enemies.AI.CoEnemyAi.BaseUpdate+76)

label(code)
label(return)
label(Aibattle)

newmem:
  pushf
  mov rdi,[rcx+58]                            //Jackpot.Web.WebViewSteam.set_Logger   Jackpot.Web.UIWebView.get_Viewport
  cmp byte ptr [rcx+00000151],00             //IsFollowTargetCamera    Bleach.Games.CoQuestBattle.Core.Characters.Enemies.AI.CoEnemyAi.BaseUpdate      XXXXX  AdjustSdk.JSONNode.Deserialize
  je Aibattle
  jmp code

Aibattle:
  //cmp byte ptr [onehitkills],1
  //jne code
  mov [rdi+0000050],#10                  //hp      Bleach.Games.CoQuestBattle.Core.Characters.Enemies.AI.EnemyAi.set_CurrentEffectiveRangeState    Bleach.Games.CoQuestBattle.Core.Characters.Enemies.AI.EnemyAi.get_CurrentEffectiveRangeState
  mov [rdi+0000054],#10                  //hpmax   Bleach.Games.RaidQuest.Characters.RaidEnemyActionScenario.set_LocalWaveCount           Bleach.Model.TeamBattleEnemyInfoModel.get_Rank
  jmp code

code:
  popf
  mov ecx,[rcx+000002A8]
  jmp return

address:
  jmp newmem
  nop
return:

[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.CoQuestBattle.Core.Characters.Enemies.AI.CoEnemyAi.BaseUpdate+76:
mov ecx,[rcx+000002A8]
//Alt: db 8B 89 A8 02 00 00
    ]]

    local script15 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat                 Bleach.Games.RaidQuest.Characters.RaidEnemyAction.Start
alloc(newmem,2048,Bleach.Games.RaidQuest.Characters.RaidEnemyAction.Start)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
ret
nop
nop
nop
xor edx,edx

exit:
jmp returnhere

Bleach.Games.RaidQuest.Characters.RaidEnemyAction.Start:
jmp newmem
nop
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.RaidQuest.Characters.RaidEnemyAction.Start:
ret
nop
nop
nop
xor edx,edx
//Alt: db C6 41 20 01 33 D2
    ]]

    local script17 = [[
[ENABLE]
{$Lua}
if syntaxcheck then return end
-- Play the loading sound when enabled
playSound(findTableFile('buttonpress.wav'))
{$Asm}

[DISABLE]
{$Lua}
if syntaxcheck then return end
{$Asm}
    ]]

    -- Check if ToggleBox2 is checked
    if sender.Checked then
        -- Enable scripts
        local SCRIPT_12_enabledOk
        SCRIPT_12_enabledOk, SCRIPT_12_disableInfo = autoAssemble(script12)
        if not SCRIPT_12_enabledOk then
            local message = "Error enabling script 12"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_13_enabledOk
        SCRIPT_13_enabledOk, SCRIPT_13_disableInfo = autoAssemble(script13)
        if not SCRIPT_13_enabledOk then
            local message = "Error enabling script 13"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_14_enabledOk
        SCRIPT_14_enabledOk, SCRIPT_14_disableInfo = autoAssemble(script14)
        if not SCRIPT_14_enabledOk then
            local message = "Error enabling script 14"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_15_enabledOk
        SCRIPT_15_enabledOk, SCRIPT_15_disableInfo = autoAssemble(script15)
        if not SCRIPT_15_enabledOk then
            local message = "Error enabling script 15"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_17_enabledOk
        SCRIPT_17_enabledOk, SCRIPT_17_disableInfo = autoAssemble(script17)
        if not SCRIPT_17_enabledOk then
            local message = "Error enabling script 17"
            messageDialog(message, mtWarning, mbOK)
        end

    else
        -- Disable scripts
        if SCRIPT_12_disableInfo then
            local SCRIPT_12_disabledOk = autoAssemble(script12, SCRIPT_12_disableInfo)
            if SCRIPT_12_disabledOk then
                SCRIPT_12_disableInfo = nil
            end
        end

        if SCRIPT_13_disableInfo then
            local SCRIPT_13_disabledOk = autoAssemble(script13, SCRIPT_13_disableInfo)
            if SCRIPT_13_disabledOk then
                SCRIPT_13_disableInfo = nil
            end
        end

        if SCRIPT_14_disableInfo then
            local SCRIPT_14_disabledOk = autoAssemble(script14, SCRIPT_14_disableInfo)
            if SCRIPT_14_disabledOk then
                SCRIPT_14_disableInfo = nil
            end
        end

        if SCRIPT_15_disableInfo then
            local SCRIPT_15_disabledOk = autoAssemble(script15, SCRIPT_15_disableInfo)
            if SCRIPT_15_disabledOk then
                SCRIPT_15_disableInfo = nil
            end
        end

        if SCRIPT_17_disableInfo then
            local SCRIPT_17_disabledOk = autoAssemble(script17, SCRIPT_17_disableInfo)
            if SCRIPT_17_disabledOk then
                SCRIPT_17_disableInfo = nil
            end
        end


    end
end





-- Define global variables to store disable info   TIME SPOOF
local SCRIPT_16_disableInfo, SCRIPT_17_disableInfo, SCRIPT_18_disableInfo

function ToggleBox3Click(sender)

    local script16 = [[
define(address,Bleach.Menus.Quest.QuestRecords.UpdateQuestBattleClearedTime+8)

[ENABLE]
assert(address,bytes)
alloc(newmem,$1000,Bleach.Menus.Quest.QuestRecords.UpdateQuestBattleClearedTime+8)
label(code)
label(return)
label(float59)

newmem:
  mov [float59],0x426C0000  // 59.0 in float         Bleach.Menus.Quest.QuestRecords.UpdateQuestBattleClearedTime
  movss xmm1,[float59]
  movss [rcx+00000094],xmm1
  jmp return

float59:
  dd 426C0000

code:
  movss [rcx+00000094],xmm1
  jmp return

address:
  jmp newmem
  nop 3
return:

[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Menus.Quest.QuestRecords.UpdateQuestBattleClearedTime+8:
movss [rcx+00000094],xmm1
//Alt: db F3 0F 11 89 94 00 00 00

    ]]

    local script17 = [[
[ENABLE]
{$Lua}
if syntaxcheck then return end
-- Play the loading sound when enabled
playSound(findTableFile('buttonpress.wav'))
{$Asm}

[DISABLE]
{$Lua}
if syntaxcheck then return end
{$Asm}
    ]]

    local script18 = [[
{ Game   : BleachBraveSouls.exe
  Version:
  Date   : 2024-06-06
  Author : Mohammed

  This script does blah blah blah                       Bleach.Games.RaidQuest.UI.RaidUIController.UpdateTimeCount
}

define(address,Bleach.Games.RaidQuest.UI.RaidUIController.UpdateTimeCount+6)

[ENABLE]

assert(address,bytes)
alloc(newmem,$1000,Bleach.Games.RaidQuest.UI.RaidUIController.UpdateTimeCount+6)

label(code)
label(return)

newmem:
  mov [rcx+150],(float)120                    //Pointing To Full Address To Get elapsedTime 0x130  synch time
  cmp byte ptr [rcx+30],00
  mov rbx,rcx
  jmp return

code:
  cmp byte ptr [rcx+30],00
  mov rbx,rcx
  jmp return

address:
  jmp newmem
  nop 2
return:


[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.RaidQuest.UI.RaidUIController.UpdateTimeCount+6:
cmp byte ptr [rcx+30],00
mov rbx,rcx
//Alt: db 80 79 30 00 48 8B D9
{
// ORIGINAL CODE - INJECTION POINT: GameAssembly.dll+F0F276

GameAssembly.dll+F0F261: 48 83 C4 30     - add rsp,30
GameAssembly.dll+F0F265: 5B              - pop rbx
GameAssembly.dll+F0F266: C3              - ret
GameAssembly.dll+F0F267: E8 24 03 33 FF  - call GameAssembly.DllGetActivationFactory+76D0
GameAssembly.dll+F0F26C: CC              - int 3
GameAssembly.dll+F0F26D: CC              - int 3
GameAssembly.dll+F0F26E: CC              - int 3
GameAssembly.dll+F0F26F: CC              - int 3
Bleach.Games.RaidQuest.UI.UIController.UpdateTimeCount: 40 53           - push rbx
GameAssembly.dll+F0F272: 48 83 EC 40     - sub rsp,40
// ---------- INJECTING HERE ----------
GameAssembly.dll+F0F276: 80 79 30 00     - cmp byte ptr [rcx+30],00
// ---------- DONE INJECTING  ----------
GameAssembly.dll+F0F27A: 48 8B D9        - mov rbx,rcx
GameAssembly.dll+F0F27D: 74 74           - je GameAssembly.dll+F0F2F3
GameAssembly.dll+F0F27F: 0F 29 74 24 30  - movaps [rsp+30],xmm6
GameAssembly.dll+F0F284: 0F 29 7C 24 20  - movaps [rsp+20],xmm7
GameAssembly.dll+F0F289: F3 0F 10 71 34  - movss xmm6,[rcx+34]
GameAssembly.dll+F0F28E: 33 D2           - xor edx,edx
GameAssembly.dll+F0F290: E8 CB 00 00 00  - call Bleach.Games.RaidQuest.UI.UIController.get_ProgressTime
GameAssembly.dll+F0F295: 4C 8B 03        - mov r8,[rbx]
GameAssembly.dll+F0F298: F3 0F 5C F0     - subss xmm6,xmm0
GameAssembly.dll+F0F29C: 0F 57 FF        - xorps xmm7,xmm7
}
    ]]

    -- Check if ToggleBox3 is checked
    if sender.Checked then
        -- Enable scripts
        local SCRIPT_16_enabledOk
        SCRIPT_16_enabledOk, SCRIPT_16_disableInfo = autoAssemble(script16)
        if not SCRIPT_16_enabledOk then
            local message = "Error enabling script 16"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_17_enabledOk
        SCRIPT_17_enabledOk, SCRIPT_17_disableInfo = autoAssemble(script17)
        if not SCRIPT_17_enabledOk then
            local message = "Error enabling script 17"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_18_enabledOk
        SCRIPT_18_enabledOk, SCRIPT_18_disableInfo = autoAssemble(script18)
        if not SCRIPT_18_enabledOk then
            local message = "Error enabling script 18"
            messageDialog(message, mtWarning, mbOK)
        end

    else
        -- Disable scripts
        if SCRIPT_16_disableInfo then
            local SCRIPT_16_disabledOk = autoAssemble(script16, SCRIPT_16_disableInfo)
            if SCRIPT_16_disabledOk then
                SCRIPT_16_disableInfo = nil
            end
        end

        if SCRIPT_17_disableInfo then
            local SCRIPT_17_disabledOk = autoAssemble(script17, SCRIPT_17_disableInfo)
            if SCRIPT_17_disabledOk then
                SCRIPT_17_disableInfo = nil
            end
        end

        if SCRIPT_18_disableInfo then
            local SCRIPT_18_disabledOk = autoAssemble(script18, SCRIPT_18_disableInfo)
            if SCRIPT_18_disabledOk then
                SCRIPT_18_disableInfo = nil
            end
        end
    end
end






-- Define global variables to store disable info   ULTIMATE SPEED
local SCRIPT_19_disableInfo, SCRIPT_20_disableInfo, SCRIPT_21_disableInfo, SCRIPT_22_disableInfo,
      SCRIPT_23_disableInfo, SCRIPT_24_disableInfo, SCRIPT_25_disableInfo, SCRIPT_26_disableInfo,
      SCRIPT_27_disableInfo, SCRIPT_28_disableInfo

function ToggleBox4Click(sender)

    local script19 = [[
[ENABLE]

// --- HOOK 1 --- AbilityEnhancement.get_IsHitHiddenEnemyProb
alloc(newmem1,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsHitHiddenEnemyProb)
label(returnhere1)

newmem1:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al
jmp returnhere1

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsHitHiddenEnemyProb:
jmp newmem1
nop 3
returnhere1:


// --- HOOK 2 --- CharaBase.BaseUpdate+303
alloc(newmem2,2048,Bleach.Games.QuestBattle.Characters.CharaBase.BaseUpdate+303)
label(returnhere2)

newmem2:
mov dword ptr [rdx+64],41C00000
movss xmm1,[rdx+64]
jmp returnhere2

Bleach.Games.QuestBattle.Characters.CharaBase.BaseUpdate+303:
jmp newmem2
returnhere2:


// --- HOOK 3 --- AbilityEnhancement.get_NormalAtkSpeedUpRate+D
alloc(newmem3,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_NormalAtkSpeedUpRate+D)
alloc(myvalue,8)
label(returnhere3)

myvalue:
dq (double)5.0

newmem3:
movsd xmm0,[myvalue]
jmp returnhere3

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_NormalAtkSpeedUpRate+D:
jmp newmem3
nop 3
returnhere3:


[DISABLE]

// --- RESTORE HOOK 1 ---
dealloc(newmem1)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsHitHiddenEnemyProb:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

// --- RESTORE HOOK 2 ---
dealloc(newmem2)
Bleach.Games.QuestBattle.Characters.CharaBase.BaseUpdate+303:
movss xmm1,[rdx+64]

// --- RESTORE HOOK 3 ---
dealloc(newmem3)
dealloc(myvalue)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_NormalAtkSpeedUpRate+D:
movsd xmm0,[rax+00000198]
]]

    local script20 = [[
[ENABLE]
{$Lua}
if syntaxcheck then return end
-- Play the loading sound when enabled
playSound(findTableFile('buttonpress.wav'))
{$Asm}

[DISABLE]
{$Lua}
if syntaxcheck then return end
{$Asm}
    ]]

    local script21 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat  Bleach.Menus.CharacterTheater.CharacterTheaterController.Update+15A
alloc(newmem,2048,Bleach.Menus.CharacterTheater.CharacterTheaterController.Update+15A)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
jmp Bleach.Menus.CharacterTheater.CharacterTheaterController.Update+18F
jmp Bleach.Menus.CharacterTheater.CharacterTheaterController.Update+12B
je Bleach.Menus.CharacterTheater.CharacterTheaterController.Update+446


exit:
jmp returnhere

Bleach.Menus.CharacterTheater.CharacterTheaterController.Update+15A:
jmp newmem
nop
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Menus.CharacterTheater.CharacterTheaterController.Update+15A:
je Bleach.Menus.CharacterTheater.CharacterTheaterController.Update+446
//Alt: db 48 8B 47 50 48 85 C0
    ]]

    local script22 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat               //Bleach.Games.QuestBattle.Characters.AttackCoolTime.Charge
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AttackCoolTime.Charge+62)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
mov [rbx+40],(float)616 //ss xmm0


exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AttackCoolTime.Charge+62:
jmp newmem
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AttackCoolTime.Charge+62:
movss [rbx+40],xmm1
//Alt: db F3 0F 11 4B 40
    ]]

local script23 = [[
define(address,Bleach.Games.QuestBattle.PlayerController.UpdateMove+237)

[ENABLE]
assert(address,bytes)
alloc(newmem,$1000,Bleach.Games.QuestBattle.PlayerController.UpdateMove+237)

label(code)
label(return)
label(playermovementspd)

newmem:
  cmp byte ptr [rcx+39],01    //IsPlayerSide  Bleach.Games.QuestBattle.PlayerController.UpdateMove+237
  jne code
  je playermovementspd


playermovementspd:
  push eax
  mov eax,(float)140.0
  mov [rcx+000003E4],eax
  pop eax
  mov eax,[rcx+000003E4]
  jmp return

code:
  mov eax,[rcx+000003E4]
  jmp return

address:
  jmp newmem
  nop
return:


[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.PlayerController.UpdateMove+237:
mov eax,[rax+000003E4]
//Alt: db 8B 80 E4 03 00 00
    ]]

local script24 = [[
{ Game   : BleachBraveSouls.exe
  Version:
  Date   : 2024-05-25
  Author : Mohammed

  This script does blah blah blah          Bleach.Games.QuestBattle.AI.AutoModeAI.AutoModeMoveToTarget+2DF
}

define(address,Bleach.Games.QuestBattle.AI.AutoModeAI.AutoModeMoveToTarget+2DF)

[ENABLE]

assert(address,bytes)
alloc(newmem,$1000,Bleach.Games.QuestBattle.AI.AutoModeAI.AutoModeMoveToTarget+2DF)

label(code)
label(return)

newmem:
 mov eax,(float)140.0
  mov [rdi+00000450],eax
  jmp return

code:
  mov eax,[rax+44]
  mov [rdi+00000450],eax
  jmp return

address:
  jmp newmem
  nop 4
return:

[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.AI.AutoModeAI.AutoModeMoveToTarget+2DF:
mov eax,[rax+44]
mov [rdi+00000450],eax
//Alt: db 8B 40 44 89 87 50 04 00 00
    ]]

local script25 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.CharaBase.UpdateCheckCollision+15D)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access           Bleach.Games.QuestBattle.Characters.CharaBase.UpdateCheckCollision+15D
//place your code here

originalcode:
mov [rcx+48],01 //ShapeType (Attack type)
mov [rcx+4C],(float)1000 //ShapeRadius (Radius)
mov [rcx+50],(float)360 //ShapeAngle (Direction (360 - in all directions))
mov ecx,[rcx+48]
sub ecx,01

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.CharaBase.UpdateCheckCollision+15D:
jmp newmem
nop
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.CharaBase.UpdateCheckCollision+15D:
mov ecx,[rcx+48]
sub ecx,01
//Alt: db 8B 49 48 83 E9 01
    ]]

local script26 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat MOVEMENT ZEREF    Bleach.Games.Common.Masters.PlayableMaster.get_MovementSpeed
alloc(newmem,2048,Bleach.Games.Common.Masters.PlayableMaster.get_MovementSpeed)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here
mov eax,43480000 // 20.0 in hex (IEEE 754 format)
movd xmm0,eax
jmp exit

originalcode:
movss xmm0,[GameAssembly.dll+3CCE6F4]

exit:
jmp returnhere

Bleach.Games.Common.Masters.PlayableMaster.get_MovementSpeed:
jmp newmem
nop 3
returnhere:


[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.Common.Masters.PlayableMaster.get_MovementSpeed:
movss xmm0,[GameAssembly.dll+3CCE6F4]
//Alt: db F3 0F 10 05 D8 26 A3 02
    ]]

local script27 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat
alloc(newmem,2048,BulletControl.SetUp+16B)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access         BulletControl.SetUp+16B
//place your code here

originalcode:
mov [rdx+6C],02 //ProjectileType (Attack type)
mov [rdx+70],(float)1000 //ProjectileWidth (Attack width)
mov [rdx+78],(float)1000 //ProjectileLength (Attack range)
mov [rdx+84],(float)1000 //ProjectileImpactRadius (Attack radius)
mulss xmm1,[rdx+74]

exit:
jmp returnhere

BulletControl.SetUp+16B:
jmp newmem
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
BulletControl.SetUp+16B:
mulss xmm1,[rdx+74]
//Alt: db F3 0F 59 4A 74
    ]]

local script28 = [[
///////////////
// ENABLE
///////////////

[ENABLE]

// ---------- HOOK 1 ----------
alloc(newmem1,2048,Bleach.Games.Common.Characters.Attack.FightingAttackBehaviour.CullingCircle+45)             //Bleach.Games.Common.Characters.Attack.FightingAttackBehaviour.CullingCircle+45
label(return1)
label(originalcode1)
label(exit1)

newmem1:

originalcode1:
    mov [rbx+60],(float)500000      // Shape Radius            Bleach.Games.Common.Characters.Status.StatusRevivalTimerBehaviour.set_Time
    mov [rbx+64],(float)360         // Shape Angle             Bleach.Games.QuestBattle.Animations.MotionEvent.set_VariationIndex
    mov rcx,[rbx+18]
    test rcx,rcx

exit1:
    jmp return1

Bleach.Games.Common.Characters.Attack.FightingAttackBehaviour.CullingCircle+45:
    jmp newmem1
    nop 2
return1:

// ---------- HOOK 2 ----------                          Bleach.Games.Common.Characters.Attack.FightingAttackBehaviour.CullingCircle+77
alloc(newmem2,2048,Bleach.Games.Common.Characters.Attack.FightingAttackBehaviour.CullingCircle+77)
label(return2)
label(originalcode2)
label(exit2)

newmem2:

originalcode2:
    mov [rbx+6C],(float)900000          // Length          Bleach.Games.QuestBattle.Animations.MotionEvent.set_AdventAnimationLoop
    mov [rbx+68],(float)900000          // Width           Bleach.Games.Common.Masters.CharacterAttackMaster.get_ReadyTime
    mov rcx,[rbx+18]
    test rcx,rcx

exit2:
    jmp return2

Bleach.Games.Common.Characters.Attack.FightingAttackBehaviour.CullingCircle+77:
    jmp newmem2
    nop 2
return2:



///////////////
// DISABLE
///////////////

[DISABLE]

// --- Restore Hook 1 ---
dealloc(newmem1)
Bleach.Games.Common.Characters.Attack.FightingAttackBehaviour.CullingCircle+45:
    mov rcx,[rbx+18]
    test rcx,rcx

// --- Restore Hook 2 ---
dealloc(newmem2)
Bleach.Games.Common.Characters.Attack.FightingAttackBehaviour.CullingCircle+77:
    mov rcx,[rbx+18]
    test rcx,rcx
    ]]


    -- Check if ToggleBox4 is checked
    if sender.Checked then
        -- Enable scripts
        local SCRIPT_19_enabledOk
        SCRIPT_19_enabledOk, SCRIPT_19_disableInfo = autoAssemble(script19)
        if not SCRIPT_19_enabledOk then
            local message = "Error enabling script 19"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_20_enabledOk
        SCRIPT_20_enabledOk, SCRIPT_20_disableInfo = autoAssemble(script20)
        if not SCRIPT_20_enabledOk then
            local message = "Error enabling script 20"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_21_enabledOk
        SCRIPT_21_enabledOk, SCRIPT_21_disableInfo = autoAssemble(script21)
        if not SCRIPT_21_enabledOk then
            local message = "Error enabling script 21"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_22_enabledOk
        SCRIPT_22_enabledOk, SCRIPT_22_disableInfo = autoAssemble(script22)
        if not SCRIPT_22_enabledOk then
            local message = "Error enabling script 22"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_23_enabledOk
        SCRIPT_23_enabledOk, SCRIPT_23_disableInfo = autoAssemble(script23)
        if not SCRIPT_23_enabledOk then
            local message = "Error enabling script 23"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_24_enabledOk
        SCRIPT_24_enabledOk, SCRIPT_24_disableInfo = autoAssemble(script24)
        if not SCRIPT_24_enabledOk then
            local message = "Error enabling script 24"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_25_enabledOk
        SCRIPT_25_enabledOk, SCRIPT_25_disableInfo = autoAssemble(script25)
        if not SCRIPT_25_enabledOk then
            local message = "Error enabling script 25"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_26_enabledOk
        SCRIPT_26_enabledOk, SCRIPT_26_disableInfo = autoAssemble(script26)
        if not SCRIPT_26_enabledOk then
            local message = "Error enabling script 26"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_27_enabledOk
        SCRIPT_27_enabledOk, SCRIPT_27_disableInfo = autoAssemble(script27)
        if not SCRIPT_27_enabledOk then
            local message = "Error enabling script 27"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_28_enabledOk
        SCRIPT_28_enabledOk, SCRIPT_28_disableInfo = autoAssemble(script28)
        if not SCRIPT_28_enabledOk then
            local message = "Error enabling script 28"
            messageDialog(message, mtWarning, mbOK)
        end

    else
        -- Disable scripts
        if SCRIPT_19_disableInfo then
            local SCRIPT_19_disabledOk = autoAssemble(script19, SCRIPT_19_disableInfo)
            if SCRIPT_19_disabledOk then
                SCRIPT_19_disableInfo = nil
            end
        end

        if SCRIPT_20_disableInfo then
            local SCRIPT_20_disabledOk = autoAssemble(script20, SCRIPT_20_disableInfo)
            if SCRIPT_20_disabledOk then
                SCRIPT_20_disableInfo = nil
            end
        end

        if SCRIPT_21_disableInfo then
            local SCRIPT_21_disabledOk = autoAssemble(script21, SCRIPT_21_disableInfo)
            if SCRIPT_21_disabledOk then
                SCRIPT_21_disableInfo = nil
            end
        end

        if SCRIPT_22_disableInfo then
            local SCRIPT_22_disabledOk = autoAssemble(script22, SCRIPT_22_disableInfo)
            if SCRIPT_22_disabledOk then
                SCRIPT_22_disableInfo = nil
            end
        end

        if SCRIPT_23_disableInfo then
            local SCRIPT_23_disabledOk = autoAssemble(script23, SCRIPT_23_disableInfo)
            if SCRIPT_23_disabledOk then
                SCRIPT_23_disableInfo = nil
            end
        end

        if SCRIPT_24_disableInfo then
            local SCRIPT_24_disabledOk = autoAssemble(script24, SCRIPT_24_disableInfo)
            if SCRIPT_24_disabledOk then
                SCRIPT_24_disableInfo = nil
            end
        end

        if SCRIPT_25_disableInfo then
            local SCRIPT_25_disabledOk = autoAssemble(script25, SCRIPT_25_disableInfo)
            if SCRIPT_25_disabledOk then
                SCRIPT_25_disableInfo = nil
            end
        end

        if SCRIPT_26_disableInfo then
            local SCRIPT_26_disabledOk = autoAssemble(script26, SCRIPT_26_disableInfo)
            if SCRIPT_26_disabledOk then
                SCRIPT_26_disableInfo = nil
            end
        end

        if SCRIPT_27_disableInfo then
            local SCRIPT_27_disabledOk = autoAssemble(script27, SCRIPT_27_disableInfo)
            if SCRIPT_27_disabledOk then
                SCRIPT_27_disableInfo = nil
            end
        end

        if SCRIPT_28_disableInfo then
            local SCRIPT_28_disabledOk = autoAssemble(script28, SCRIPT_28_disableInfo)
            if SCRIPT_28_disabledOk then
                SCRIPT_28_disableInfo = nil
            end
        end
    end
end





-- Define global variables to store disable info
local SCRIPT_29_disableInfo, SCRIPT_30_disableInfo

function ToggleBox5Click(sender)

    local script29 = [[
{ Game   : BleachBraveSouls.exe          Bleach.Menus.QuestStageSelect.Prepare.View.QuestStageSelectPrepareView.UpdateBoostApUi+1BC
  Version:
  Date   : 2024-05-25
  Author : Mohammed

  This script does blah blah blah
}

define(address,Bleach.Menus.QuestStageSelect.Prepare.View.QuestStageSelectPrepareView.UpdateBoostApUi+1BC)


[ENABLE]

assert(address,bytes)
alloc(newmem,$1000,Bleach.Menus.QuestStageSelect.Prepare.View.QuestStageSelectPrepareView.UpdateBoostApUi+1BC)

label(code)
label(return)

newmem:
  movzx edx,byte ptr [rdi+00000210]
  mov [rdi+00000060],#10                                        //Bleach.Model.CoQuestBattle.CoQuestBattleFinishResponse.get_Level
  jmp return
code:
  movzx edx,byte ptr [rdi+00000210]
  jmp return

address:
  jmp newmem
  nop 2
return:

[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Menus.QuestStageSelect.Prepare.View.QuestStageSelectPrepareView.UpdateBoostApUi+1BC:
movzx edx,byte ptr [rdi+00000210]
//Alt: db 0F B6 97 10 02 00 00
    ]]

    local script30 = [[
[ENABLE]
{$Lua}
if syntaxcheck then return end
-- Play the loading sound when enabled
playSound(findTableFile('buttonpress.wav'))
{$Asm}

[DISABLE]
{$Lua}
if syntaxcheck then return end
{$Asm}
    ]]

    -- Check if ToggleBox5 is checked
    if sender.Checked then
        -- Enable scripts
        local SCRIPT_29_enabledOk
        SCRIPT_29_enabledOk, SCRIPT_29_disableInfo = autoAssemble(script29)
        if not SCRIPT_29_enabledOk then
            local message = "Error enabling script 29"
            messageDialog(message, mtWarning, mbOK)
        end

        local SCRIPT_30_enabledOk
        SCRIPT_30_enabledOk, SCRIPT_30_disableInfo = autoAssemble(script30)
        if not SCRIPT_30_enabledOk then
            local message = "Error enabling script 30"
            messageDialog(message, mtWarning, mbOK)
        end

    else
        -- Disable scripts
        if SCRIPT_29_disableInfo then
            local SCRIPT_29_disabledOk = autoAssemble(script29, SCRIPT_29_disableInfo)
            if SCRIPT_29_disabledOk then
                SCRIPT_29_disableInfo = nil
            end
        end

        if SCRIPT_30_disableInfo then
            local SCRIPT_30_disabledOk = autoAssemble(script30, SCRIPT_30_disableInfo)
            if SCRIPT_30_disabledOk then
                SCRIPT_30_disableInfo = nil
            end
        end
    end
end




local SCRIPT_31_disableInfo, SCRIPT_32_disableInfo
local timerScript31

function ToggleBox6Click(sender)

    local script31 = [[
{ Game   : BleachBraveSouls.exe          Bleach.Menus.QuestStageSelect.Prepare.View.QuestStageSelectPrepareView.UpdateBoostApUi+1BC
  Version:
  Date   : 2024-05-25
  Author : Mohammed

  This script does blah blah blah
}

define(address,Bleach.Menus.QuestStageSelect.Prepare.View.QuestStageSelectPrepareView.UpdateBoostApUi+1BC)


[ENABLE]

assert(address,bytes)
alloc(newmem,$1000,Bleach.Menus.QuestStageSelect.Prepare.View.QuestStageSelectPrepareView.UpdateBoostApUi+1BC)

label(code)
label(return)

newmem:
  movzx edx,byte ptr [rdi+00000210]
  mov [rdi+00000060],#5                                        //Bleach.Model.CoQuestBattle.CoQuestBattleFinishResponse.get_Level
  jmp return
code:
  movzx edx,byte ptr [rdi+00000210]
  jmp return

address:
  jmp newmem
  nop 2
return:

[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Menus.QuestStageSelect.Prepare.View.QuestStageSelectPrepareView.UpdateBoostApUi+1BC:
movzx edx,byte ptr [rdi+00000210]
//Alt: db 0F B6 97 10 02 00 00
]]

    local script32 = [[
[ENABLE]
{$Lua}
if syntaxcheck then return end
-- Play the loading sound when enabled
playSound(findTableFile('buttonpress.wav'))
{$Asm}

[DISABLE]
{$Lua}
if syntaxcheck then return end
{$Asm}
]]


     -- Check if ToggleBox6 is checked
    if sender.Checked then
        -- Enable script31
        local SCRIPT_31_enabledOk
        SCRIPT_31_enabledOk, SCRIPT_31_disableInfo = autoAssemble(script31)
        if not SCRIPT_31_enabledOk then
            local message = "Error enabling script 31"
            messageDialog(message, mtWarning, mbOK)
            return
        end
        -- Enable script32
        local SCRIPT_32_enabledOk
        SCRIPT_32_enabledOk, SCRIPT_32_disableInfo = autoAssemble(script32)
        if not SCRIPT_32_enabledOk then
            local message = "Error enabling script 32"
            messageDialog(message, mtWarning, mbOK)
        end

    else
        -- Disable script31 immediately if unchecked
        if SCRIPT_31_disableInfo then
            autoAssemble(script31, SCRIPT_31_disableInfo)
            SCRIPT_31_disableInfo = nil
        end

        -- Disable script32 immediately if unchecked
        if SCRIPT_32_disableInfo then
            autoAssemble(script32, SCRIPT_32_disableInfo)
            SCRIPT_32_disableInfo = nil
        end

        -- Stop and destroy the timer if it's running
        if timerScript31 then
            timerScript31.destroy()
            timerScript31 = nil
        end
    end
end






local SCRIPT_32_disableInfo, SCRIPT_33_disableInfo, SCRIPT_34_disableInfo
local timerScript32, timerScript33

function ToggleBox7Click(sender)

local script32 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat
alloc(newmem,2048,Bleach.Model.QuestRestrictionModel.IsElementRestriction+157)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
xor al,al
jne Bleach.Model.QuestRestrictionModel.IsElementRestriction+168
inc ebx

exit:
jmp returnhere

Bleach.Model.QuestRestrictionModel.IsElementRestriction+157:
jmp newmem
nop
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Model.QuestRestrictionModel.IsElementRestriction+157:
xor al,al
jne Bleach.Model.QuestRestrictionModel.IsElementRestriction+168
inc ebx
//Alt: db 84 C0 75 06 FF C3
    ]]


local script33 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat
alloc(newmem,2048,Bleach.Model.QuestRestrictionModel.IsLinkSlotLevelRestrictionzMaster+CD)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
xor al,dl
jne Bleach.Model.QuestRestrictionModel.IsLinkSlotLevelRestrictionzMaster+301

exit:
jmp returnhere

Bleach.Model.QuestRestrictionModel.IsLinkSlotLevelRestrictionzMaster+CD:
jmp newmem
nop 3
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Model.QuestRestrictionModel.IsLinkSlotLevelRestrictionzMaster+CD:
xor al,dl
jne Bleach.Model.QuestRestrictionModel.IsLinkSlotLevelRestrictionzMaster+301
//Alt: db 84 D0 0F 85 1D 02 00 00
    ]]


local script34 = [[
[ENABLE]
{$Lua}
if syntaxcheck then return end
-- Play the loading sound when enabled
playSound(findTableFile('buttonpress.wav'))
{$Asm}

[DISABLE]
{$Lua}
if syntaxcheck then return end
{$Asm}
    ]]


    -- Check if ToggleBox7 is checked
    if sender.Checked then
        -- Enable script32
        local SCRIPT_32_enabledOk
        SCRIPT_32_enabledOk, SCRIPT_32_disableInfo = autoAssemble(script32)
        if not SCRIPT_32_enabledOk then
            local message = "Error enabling script 32"
            messageDialog(message, mtWarning, mbOK)
            return
        end

        -- Start a timer to disable script32 after 1 second
        timerScript32 = createTimer()
        timerScript32.Interval = 1000 -- 1 second
        timerScript32.OnTimer = function(timer)
            if SCRIPT_32_disableInfo then
                autoAssemble(script32, SCRIPT_32_disableInfo)
                SCRIPT_32_disableInfo = nil
            end
            timer.destroy() -- Destroy the timer after execution
        end
        timerScript32.Enabled = true

        -- Enable script33
        local SCRIPT_33_enabledOk
        SCRIPT_33_enabledOk, SCRIPT_33_disableInfo = autoAssemble(script33)
        if not SCRIPT_33_enabledOk then
            local message = "Error enabling script 33"
            messageDialog(message, mtWarning, mbOK)
            return
        end

        -- Start a timer to disable script33 after 1 second
        timerScript33 = createTimer()
        timerScript33.Interval = 1000 -- 1 second
        timerScript33.OnTimer = function(timer)
            if SCRIPT_33_disableInfo then
                autoAssemble(script33, SCRIPT_33_disableInfo)
                SCRIPT_33_disableInfo = nil
            end
            timer.destroy() -- Destroy the timer after execution
        end
        timerScript33.Enabled = true

        -- Enable script34
        local SCRIPT_34_enabledOk
        SCRIPT_34_enabledOk, SCRIPT_34_disableInfo = autoAssemble(script34)
        if not SCRIPT_34_enabledOk then
            local message = "Error enabling script 34"
            messageDialog(message, mtWarning, mbOK)
        end

    else
        -- Disable script32 immediately if unchecked
        if SCRIPT_32_disableInfo then
            autoAssemble(script32, SCRIPT_32_disableInfo)
            SCRIPT_32_disableInfo = nil
        end

        -- Disable script33 immediately if unchecked
        if SCRIPT_33_disableInfo then
            autoAssemble(script33, SCRIPT_33_disableInfo)
            SCRIPT_33_disableInfo = nil
        end

        -- Disable script34 immediately if unchecked
        if SCRIPT_34_disableInfo then
            autoAssemble(script34, SCRIPT_34_disableInfo)
            SCRIPT_34_disableInfo = nil
        end

        -- Stop and destroy the timers if they're running
        if timerScript32 then
            timerScript32.destroy()
            timerScript32 = nil
        end

        if timerScript33 then
            timerScript33.destroy()
            timerScript33 = nil
        end
    end
end



local SCRIPT_35_disableInfo, SCRIPT_36_disableInfo, SCRIPT_37_disableInfo, SCRIPT_38_disableInfo, SCRIPT_39_disableInfo
local timerScript37, timerScript38, timerScript39

function ToggleBox8Click(sender)

    local script35 = [[
define(address,Bleach.Games.QuestBattle.Result.QuestResultViewController.Update+31F)

[ENABLE]

assert(address,bytes)
alloc(newmem,$1000,Bleach.Games.QuestBattle.Result.QuestResultViewController.Update+31F)

label(code)
label(return)

newmem:
  call Bleach.Games.QuestBattle.Result.QuestResultViewController.OnButtonRetry
  nop
  jmp return

code:
  call UnityEngine.MonoBehaviour.StartCoroutine
  jmp return

address:
  jmp newmem
return:

[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Result.QuestResultViewController.Update+31F:
call UnityEngine.MonoBehaviour.StartCoroutine
//Alt: db E8 3C 3C 96 02
]]

    local script36 = [[
[ENABLE]
{$Lua}
if syntaxcheck then return end
-- Play the loading sound when enabled
playSound(findTableFile('buttonpress.wav'))
{$Asm}

[DISABLE]
{$Lua}
if syntaxcheck then return end
{$Asm}
]]

    local script37 = [[
[ENABLE]
{$Lua}
if syntaxcheck then return end
-- Play the loading sound when enabled
playSound(findTableFile('buttonpress.wav'))
{$Asm}

[DISABLE]
{$Lua}
if syntaxcheck then return end
{$Asm}
]]

    local script38 = [[
[ENABLE]
{$Lua}
if syntaxcheck then return end
-- Play the loading sound when enabled
playSound(findTableFile('buttonpress.wav'))
{$Asm}

[DISABLE]
{$Lua}
if syntaxcheck then return end
{$Asm}
]]

    local script38 = [[
[ENABLE]
{$Lua}
if syntaxcheck then return end
-- Play the loading sound when enabled
playSound(findTableFile('buttonpress.wav'))
{$Asm}

[DISABLE]
{$Lua}
if syntaxcheck then return end
{$Asm}
]]


    -- Check if ToggleBox8 is checked
    if sender.Checked then
        -- Enable script35
        local SCRIPT_35_enabledOk
        SCRIPT_35_enabledOk, SCRIPT_35_disableInfo = autoAssemble(script35)
        if not SCRIPT_35_enabledOk then
            return
        end

        -- Enable script36
        local SCRIPT_36_enabledOk
        SCRIPT_36_enabledOk, SCRIPT_36_disableInfo = autoAssemble(script36)
        if not SCRIPT_36_enabledOk then
            return
        end

        -- Enable script37
        local SCRIPT_37_enabledOk
        SCRIPT_37_enabledOk, SCRIPT_37_disableInfo = autoAssemble(script37)
        if not SCRIPT_37_enabledOk then
            return
        end

        -- Start a timer to disable script37 after 1 second
        timerScript37 = createTimer()
        timerScript37.Interval = 1000 -- 1 second
        timerScript37.OnTimer = function(timer)
            if SCRIPT_37_disableInfo then
                autoAssemble(script37, SCRIPT_37_disableInfo)
                SCRIPT_37_disableInfo = nil
            end
            timer.destroy() -- Destroy the timer after execution
        end
        timerScript37.Enabled = true

        -- Enable script38
        local SCRIPT_38_enabledOk
        SCRIPT_38_enabledOk, SCRIPT_38_disableInfo = autoAssemble(script38)
        if not SCRIPT_38_enabledOk then
            return
        end

        -- Start a timer to disable script38 after 1 second
        timerScript38 = createTimer()
        timerScript38.Interval = 1000 -- 1 second
        timerScript38.OnTimer = function(timer)
            if SCRIPT_38_disableInfo then
                autoAssemble(script38, SCRIPT_38_disableInfo)
                SCRIPT_38_disableInfo = nil
            end
            timer.destroy() -- Destroy the timer after execution
        end
        timerScript38.Enabled = true

        -- Enable script39
        local SCRIPT_39_enabledOk
        SCRIPT_39_enabledOk, SCRIPT_39_disableInfo = autoAssemble(script39)
        if not SCRIPT_39_enabledOk then
            return
        end

        -- Start a timer to disable script39 after 1 second
        timerScript39 = createTimer()
        timerScript39.Interval = 1000 -- 1 second
        timerScript39.OnTimer = function(timer)
            if SCRIPT_39_disableInfo then
                autoAssemble(script39, SCRIPT_39_disableInfo)
                SCRIPT_39_disableInfo = nil
            end
            timer.destroy() -- Destroy the timer after execution
        end
        timerScript39.Enabled = true

    else
        -- Disable script35 immediately if unchecked
        if SCRIPT_35_disableInfo then
            autoAssemble(script35, SCRIPT_35_disableInfo)
            SCRIPT_35_disableInfo = nil
        end

        -- Disable script36 immediately if unchecked
        if SCRIPT_36_disableInfo then
            autoAssemble(script36, SCRIPT_36_disableInfo)
            SCRIPT_36_disableInfo = nil
        end

        -- Disable script37 immediately if unchecked
        if SCRIPT_37_disableInfo then
            autoAssemble(script37, SCRIPT_37_disableInfo)
            SCRIPT_37_disableInfo = nil
        end

        -- Disable script38 immediately if unchecked
        if SCRIPT_38_disableInfo then
            autoAssemble(script38, SCRIPT_38_disableInfo)
            SCRIPT_38_disableInfo = nil
        end

        -- Disable script39 immediately if unchecked
        if SCRIPT_39_disableInfo then
            autoAssemble(script39, SCRIPT_39_disableInfo)
            SCRIPT_39_disableInfo = nil
        end

        -- Stop and destroy the timers if they're running
        if timerScript37 then
            timerScript37.destroy()
            timerScript37 = nil
        end

        if timerScript38 then
            timerScript38.destroy()
            timerScript38 = nil
        end

        if timerScript39 then
            timerScript39.destroy()
            timerScript39 = nil
        end
    end
end




local SCRIPT_40_disableInfo, SCRIPT_41_disableInfo
local timerScript40

function ToggleBox9Click(sender)

    local script40 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat              Bleach.Games.QuestBattle.Characters.AbilityEnhancement.IsEvadeInvalidProb
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.IsEvadeInvalidProb)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
ret
nop
nop
nop
nop


exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.IsEvadeInvalidProb:
jmp newmem
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.IsEvadeInvalidProb:
mov [rsp+08],rbx
//Alt: db 48 89 5C 24 08
]]

    local script41 = [[
[ENABLE]
{$Lua}
if syntaxcheck then return end
-- Play the loading sound when enabled
playSound(findTableFile('buttonpress.wav'))
{$Asm}

[DISABLE]
{$Lua}
if syntaxcheck then return end
{$Asm}
]]

  -- Check if ToggleBox9 is checked
    if sender.Checked then
        -- Enable script40
        local SCRIPT_40_enabledOk
        SCRIPT_40_enabledOk, SCRIPT_40_disableInfo = autoAssemble(script40)
        if not SCRIPT_40_enabledOk then
            local message = "Error enabling script 40"
            messageDialog(message, mtWarning, mbOK)
            return
        end

        -- Enable script41
        local SCRIPT_41_enabledOk
        SCRIPT_41_enabledOk, SCRIPT_41_disableInfo = autoAssemble(script41)
        if not SCRIPT_41_enabledOk then
            local message = "Error enabling script 41"
            messageDialog(message, mtWarning, mbOK)
            return
        end

    else
        -- Disable script40 immediately if unchecked
        if SCRIPT_40_disableInfo then
            autoAssemble(script40, SCRIPT_40_disableInfo)
            SCRIPT_40_disableInfo = nil
        end

        -- Disable script41 immediately if unchecked
        if SCRIPT_41_disableInfo then
            autoAssemble(script41, SCRIPT_41_disableInfo)
            SCRIPT_41_disableInfo = nil
        end
    end
end




local SCRIPT_42_disableInfo, SCRIPT_43_disableInfo
local timerScript42

function ToggleBox10Click(sender)

    local script42 = [[
{$lua}
if syntaxcheck then return end
[ENABLE]
COOPRAIDNOCD = "Bleach.Games.Common.FloatTimer.IsEnd"
writeBytes(COOPRAIDNOCD, 0xF3, 0x0F, 0x11, 0x6E, 0x1C)
[DISABLE]
writeBytes(COOPRAIDNOCD, 0xF3, 0x0F, 0x10, 0x46, 0x1C)
]]

    local script43 = [[
[ENABLE]
{$Lua}
if syntaxcheck then return end
-- Play the loading sound when enabled
playSound(findTableFile('buttonpress.wav'))
{$Asm}

[DISABLE]
{$Lua}
if syntaxcheck then return end
{$Asm}
]]


    -- Check if ToggleBox10 is checked
    if sender.Checked then
        -- Enable script42
        local SCRIPT_42_enabledOk
        SCRIPT_42_enabledOk, SCRIPT_42_disableInfo = autoAssemble(script42)
        if not SCRIPT_42_enabledOk then
            local message = "Error enabling script 42"
            messageDialog(message, mtWarning, mbOK)
            return
        end

        -- Enable script43
        local SCRIPT_43_enabledOk
        SCRIPT_43_enabledOk, SCRIPT_43_disableInfo = autoAssemble(script43)
        if not SCRIPT_43_enabledOk then
            local message = "Error enabling script 43"
            messageDialog(message, mtWarning, mbOK)
            return
        end

    else
        -- Disable script42 immediately if unchecked
        if SCRIPT_42_disableInfo then
            autoAssemble(script42, SCRIPT_42_disableInfo)
            SCRIPT_42_disableInfo = nil
        end

        -- Disable script43 immediately if unchecked
        if SCRIPT_43_disableInfo then
            autoAssemble(script43, SCRIPT_43_disableInfo)
            SCRIPT_43_disableInfo = nil
        end
    end
end








local SCRIPT_44_disableInfo, SCRIPT_45_disableInfo, SCRIPT_46_disableInfo
local SCRIPT_47_disableInfo, SCRIPT_48_disableInfo, SCRIPT_49_disableInfo, SCRIPT_50_disableInfo
local SCRIPT_51_disableInfo, SCRIPT_52_disableInfo, SCRIPT_53_disableInfo, SCRIPT_54_disableInfo


function ToggleBox11Click(sender)

    local script44 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat      Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRcvDmgInvalidProb
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRcvDmgInvalidProb)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al
exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRcvDmgInvalidProb:
jmp newmem
nop 3
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRcvDmgInvalidProb:
sub rsp,08
mov eax,00000000
add rsp,08
ret
ret
add [rax],al
add [rax],al
//Alt: db 48 83 EC 38 48 8B 41 28
]]

    local script45 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat                 Bleach.Games.Common.Masters.PlayableMaster..ctor+50
alloc(newmem,2048,Bleach.Games.Common.Masters.PlayableMaster..ctor+50)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
mov [rdi+3C],8000000
mov eax,[rbx+000000E8]

exit:
jmp returnhere

Bleach.Games.Common.Masters.PlayableMaster..ctor+50:
jmp newmem
nop 4
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.Common.Masters.PlayableMaster..ctor+50:
mov [rdi+3C],eax
mov eax,[rbx+000000E8]
//Alt: db 89 47 3C 8B 83 E8 00 00 00
]]

    local script46 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat     Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBadStInvalidProb
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBadStInvalidProb)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBadStInvalidProb:
jmp newmem
nop 3
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBadStInvalidProb:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

//Alt: db 48 83 EC 38 48 8B 41 28
]]

    local script47 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat    Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRedAttackCrossProb
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRedAttackCrossProb)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRedAttackCrossProb:
jmp newmem
nop 3
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRedAttackCrossProb:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

//Alt: db 48 83 EC 38 48 8B 41 28
]]

    local script48 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat     Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBlueAttackCrossProb
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBlueAttackCrossProb)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBlueAttackCrossProb:
jmp newmem
nop 3
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBlueAttackCrossProb:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

//Alt: db 48 83 EC 38 48 8B 41 28
]]


    local script49 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat    Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsHitHiddenEnemyProb
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsHitHiddenEnemyProb)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsHitHiddenEnemyProb:
jmp newmem
nop 3
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsHitHiddenEnemyProb:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

//Alt: db 48 83 EC 38 48 8B 41 28
]]


    local script50 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.CharaBase.UpdateCheckCollision+15D)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access           Bleach.Games.QuestBattle.Characters.CharaBase.UpdateCheckCollision+15D
//place your code here

originalcode:
mov [rcx+48],01 //ShapeType (Attack type)
mov [rcx+4C],(float)1000 //ShapeRadius (Radius)
mov [rcx+50],(float)360 //ShapeAngle (Direction (360 - in all directions))
mov ecx,[rcx+48]
sub ecx,01

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.CharaBase.UpdateCheckCollision+15D:
jmp newmem
nop
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.CharaBase.UpdateCheckCollision+15D:
mov ecx,[rcx+48]
sub ecx,01
//Alt: db 8B 49 48 83 E9 01
]]


    local script51 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat
alloc(newmem,2048,BulletControl.SetUp+16B)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access         BulletControl.SetUp+16B
//place your code here

originalcode:
mov [rdx+6C],02 //ProjectileType (Attack type)
mov [rdx+70],(float)1000 //ProjectileWidth (Attack width)
mov [rdx+78],(float)1000 //ProjectileLength (Attack range)
mov [rdx+84],(float)1000 //ProjectileImpactRadius (Attack radius)
mulss xmm1,[rdx+74]

exit:
jmp returnhere

BulletControl.SetUp+16B:
jmp newmem
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
BulletControl.SetUp+16B:
mulss xmm1,[rdx+74]
//Alt: db F3 0F 59 4A 74
]]


    local script52 = [[
///////////////
// ENABLE
///////////////

[ENABLE]

// ---------- HOOK 1 ----------
alloc(newmem1,2048,Bleach.Games.Common.Characters.Attack.FightingAttackBehaviour.CullingCircle+45)             //Bleach.Games.Common.Characters.Attack.FightingAttackBehaviour.CullingCircle+45
label(return1)
label(originalcode1)
label(exit1)

newmem1:

originalcode1:
    mov [rbx+60],(float)500000      // Shape Radius            Bleach.Games.Common.Characters.Status.StatusRevivalTimerBehaviour.set_Time
    mov [rbx+64],(float)360         // Shape Angle             Bleach.Games.QuestBattle.Animations.MotionEvent.set_VariationIndex
    mov rcx,[rbx+18]
    test rcx,rcx

exit1:
    jmp return1

Bleach.Games.Common.Characters.Attack.FightingAttackBehaviour.CullingCircle+45:
    jmp newmem1
    nop 2
return1:

// ---------- HOOK 2 ----------                          Bleach.Games.Common.Characters.Attack.FightingAttackBehaviour.CullingCircle+77
alloc(newmem2,2048,Bleach.Games.Common.Characters.Attack.FightingAttackBehaviour.CullingCircle+77)
label(return2)
label(originalcode2)
label(exit2)

newmem2:

originalcode2:
    mov [rbx+6C],(float)900000          // Length          Bleach.Games.QuestBattle.Animations.MotionEvent.set_AdventAnimationLoop
    mov [rbx+68],(float)900000          // Width           Bleach.Games.Common.Masters.CharacterAttackMaster.get_ReadyTime
    mov rcx,[rbx+18]
    test rcx,rcx

exit2:
    jmp return2

Bleach.Games.Common.Characters.Attack.FightingAttackBehaviour.CullingCircle+77:
    jmp newmem2
    nop 2
return2:



///////////////
// DISABLE
///////////////

[DISABLE]

// --- Restore Hook 1 ---
dealloc(newmem1)
Bleach.Games.Common.Characters.Attack.FightingAttackBehaviour.CullingCircle+45:
    mov rcx,[rbx+18]
    test rcx,rcx

// --- Restore Hook 2 ---
dealloc(newmem2)
Bleach.Games.Common.Characters.Attack.FightingAttackBehaviour.CullingCircle+77:
    mov rcx,[rbx+18]
    test rcx,rcx
]]


    local script53 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat    Bleach.Games.QuestBattle.Characters.AbilityEnhancement.IsDyingSurvivalProb
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.IsDyingSurvivalProb)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.IsDyingSurvivalProb:
jmp newmem
nop
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.IsDyingSurvivalProb:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al
//Alt: db 40 53 48 83 EC 30
]]


    local script54 = [[
[ENABLE]
{$Lua}
if syntaxcheck then return end
-- Play the loading sound when enabled
playSound(findTableFile('buttonpress.wav'))
{$Asm}

[DISABLE]
{$Lua}
if syntaxcheck then return end
{$Asm}
]]


    -- Check if ToggleBox11 is checked
    if sender.Checked then
        -- Enable script44
        local SCRIPT_44_enabledOk
        SCRIPT_44_enabledOk, SCRIPT_44_disableInfo = autoAssemble(script44)
        if not SCRIPT_44_enabledOk then
            return
        end

        -- Enable script45
        local SCRIPT_45_enabledOk
        SCRIPT_45_enabledOk, SCRIPT_45_disableInfo = autoAssemble(script45)
        if not SCRIPT_45_enabledOk then
            return
        end

        -- Enable script46
        local SCRIPT_46_enabledOk
        SCRIPT_46_enabledOk, SCRIPT_46_disableInfo = autoAssemble(script46)
        if not SCRIPT_46_enabledOk then
            return
        end

        -- Enable script47
        local SCRIPT_47_enabledOk
        SCRIPT_47_enabledOk, SCRIPT_47_disableInfo = autoAssemble(script47)
        if not SCRIPT_47_enabledOk then
            return
        end

        -- Enable script48
        local SCRIPT_48_enabledOk
        SCRIPT_48_enabledOk, SCRIPT_48_disableInfo = autoAssemble(script48)
        if not SCRIPT_48_enabledOk then
            return
        end

        -- Enable script49
        local SCRIPT_49_enabledOk
        SCRIPT_49_enabledOk, SCRIPT_49_disableInfo = autoAssemble(script49)
        if not SCRIPT_49_enabledOk then
            return
        end

        -- Enable script50
        local SCRIPT_50_enabledOk
        SCRIPT_50_enabledOk, SCRIPT_50_disableInfo = autoAssemble(script50)
        if not SCRIPT_50_enabledOk then
            return
        end

        -- Enable script51
        local SCRIPT_51_enabledOk
        SCRIPT_51_enabledOk, SCRIPT_51_disableInfo = autoAssemble(script51)
        if not SCRIPT_51_enabledOk then
            return
        end

        -- Enable script52
        local SCRIPT_52_enabledOk
        SCRIPT_52_enabledOk, SCRIPT_52_disableInfo = autoAssemble(script52)
        if not SCRIPT_52_enabledOk then
            return
        end

        -- Enable script53
        local SCRIPT_53_enabledOk
        SCRIPT_53_enabledOk, SCRIPT_53_disableInfo = autoAssemble(script53)
        if not SCRIPT_53_enabledOk then
            return
        end

        -- Enable script54
        local SCRIPT_54_enabledOk
        SCRIPT_54_enabledOk, SCRIPT_54_disableInfo = autoAssemble(script54)
        if not SCRIPT_54_enabledOk then
            return
        end

    else
        -- Disable script44
        if SCRIPT_44_disableInfo then
            autoAssemble(script44, SCRIPT_44_disableInfo)
            SCRIPT_44_disableInfo = nil
        end

        -- Disable script45
        if SCRIPT_45_disableInfo then
            autoAssemble(script45, SCRIPT_45_disableInfo)
            SCRIPT_45_disableInfo = nil
        end

        -- Disable script46
        if SCRIPT_46_disableInfo then
            autoAssemble(script46, SCRIPT_46_disableInfo)
            SCRIPT_46_disableInfo = nil
        end

        -- Disable script47
        if SCRIPT_47_disableInfo then
            autoAssemble(script47, SCRIPT_47_disableInfo)
            SCRIPT_47_disableInfo = nil
        end

        -- Disable script48
        if SCRIPT_48_disableInfo then
            autoAssemble(script48, SCRIPT_48_disableInfo)
            SCRIPT_48_disableInfo = nil
        end

        -- Disable script49
        if SCRIPT_49_disableInfo then
            autoAssemble(script49, SCRIPT_49_disableInfo)
            SCRIPT_49_disableInfo = nil
        end

        -- Disable script50
        if SCRIPT_50_disableInfo then
            autoAssemble(script50, SCRIPT_50_disableInfo)
            SCRIPT_50_disableInfo = nil
        end

        -- Disable script51
        if SCRIPT_51_disableInfo then
            autoAssemble(script51, SCRIPT_51_disableInfo)
            SCRIPT_51_disableInfo = nil
        end

        -- Disable script52
        if SCRIPT_52_disableInfo then
            autoAssemble(script52, SCRIPT_52_disableInfo)
            SCRIPT_52_disableInfo = nil
        end

        -- Disable script53
        if SCRIPT_53_disableInfo then
            autoAssemble(script53, SCRIPT_53_disableInfo)
            SCRIPT_53_disableInfo = nil
        end

        -- Disable script54
        if SCRIPT_54_disableInfo then
            autoAssemble(script54, SCRIPT_54_disableInfo)
            SCRIPT_54_disableInfo = nil
        end
    end
end











local SCRIPT_55_disableInfo, SCRIPT_56_disableInfo

function ToggleBox12Click(sender)
    local script55 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat                 Bleach.Games.Common.Masters.PlayableMaster..ctor+59
alloc(newmem,2048,Bleach.Games.Common.Masters.PlayableMaster..ctor+59)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
mov [rdi+40],9200
mov eax,[rbx+000000EC]

exit:
jmp returnhere

Bleach.Games.Common.Masters.PlayableMaster..ctor+59:
jmp newmem
nop 4
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.Common.Masters.PlayableMaster..ctor+59:
mov [rdi+40],eax
mov eax,[rbx+000000EC]
//Alt: db 89 47 40 8B 83 EC 00 00 00
    ]]

    local script56 = [[
    [ENABLE]
{$Lua}
if syntaxcheck then return end
-- Play the loading sound when enabled
playSound(findTableFile('buttonpress.wav'))
{$Asm}

[DISABLE]
{$Lua}
if syntaxcheck then return end
{$Asm}
    ]]

    -- Check if ToggleBox12 is checked
    if sender.Checked then
        -- Enable script55
        local SCRIPT_55_enabledOk
        SCRIPT_55_enabledOk, SCRIPT_55_disableInfo = autoAssemble(script55)
        if not SCRIPT_55_enabledOk then
            return
        end

        -- Enable script56
        local SCRIPT_56_enabledOk
        SCRIPT_56_enabledOk, SCRIPT_56_disableInfo = autoAssemble(script56)
        if not SCRIPT_56_enabledOk then
            return
        end

    else
        -- Disable script55
        if SCRIPT_55_disableInfo then
            autoAssemble(script55, SCRIPT_55_disableInfo)
            SCRIPT_55_disableInfo = nil
        end

        -- Disable script56
        if SCRIPT_56_disableInfo then
            autoAssemble(script56, SCRIPT_56_disableInfo)
            SCRIPT_56_disableInfo = nil
        end
    end
end













local SCRIPT_57_disableInfo, SCRIPT_58_disableInfo

function ToggleBox13Click(sender)
    local script57 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat    Bleach.Games.Guild.UI.GuildUIController.UpdateTimeCount+6
alloc(newmem,2048,Bleach.Games.Guild.UI.GuildUIController.UpdateTimeCount+6)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
xor rcx,rcx

exit:
jmp returnhere

Bleach.Games.Guild.UI.GuildUIController.UpdateTimeCount+6:
jmp newmem
nop 2
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.Guild.UI.GuildUIController.UpdateTimeCount+6:
cmp byte ptr [rcx+30],00
mov rbx,rcx
//Alt: db 80 79 30 00 48 8B D9
    ]]

    local script58 = [[
    [ENABLE]
{$Lua}
if syntaxcheck then return end
-- Play the loading sound when enabled
playSound(findTableFile('buttonpress.wav'))
{$Asm}

[DISABLE]
{$Lua}
if syntaxcheck then return end
{$Asm}
    ]]

    -- Check if ToggleBox13 is checked
    if sender.Checked then
        -- Enable script57
        local SCRIPT_57_enabledOk
        SCRIPT_57_enabledOk, SCRIPT_57_disableInfo = autoAssemble(script57)
        if not SCRIPT_57_enabledOk then
            return
        end

        -- Enable script58
        local SCRIPT_58_enabledOk
        SCRIPT_58_enabledOk, SCRIPT_58_disableInfo = autoAssemble(script58)
        if not SCRIPT_58_enabledOk then
            return
        end

    else
        -- Disable script57
        if SCRIPT_57_disableInfo then
            autoAssemble(script57, SCRIPT_57_disableInfo)
            SCRIPT_57_disableInfo = nil
        end

        -- Disable script58
        if SCRIPT_58_disableInfo then
            autoAssemble(script58, SCRIPT_58_disableInfo)
            SCRIPT_58_disableInfo = nil
        end
    end
end











local SCRIPT_59_disableInfo, SCRIPT_60_disableInfo, SCRIPT_61_disableInfo, SCRIPT_62_disableInfo,
      SCRIPT_63_disableInfo, SCRIPT_64_disableInfo, SCRIPT_65_disableInfo, SCRIPT_66_disableInfo

function ToggleBox14Click(sender)
    local script59 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat      Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRcvDmgInvalidProb
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRcvDmgInvalidProb)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al
exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRcvDmgInvalidProb:
jmp newmem
nop 3
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRcvDmgInvalidProb:
sub rsp,08
mov eax,00000000
add rsp,08
ret
ret
add [rax],al
add [rax],al
//Alt: db 48 83 EC 38 48 8B 41 28
    ]]

    local script60 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat    Bleach.Games.QuestBattle.Characters.AbilityEnhancement.IsDyingSurvivalProb
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.IsDyingSurvivalProb)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.IsDyingSurvivalProb:
jmp newmem
nop
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.IsDyingSurvivalProb:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al
//Alt: db 40 53 48 83 EC 30
    ]]

    local script61 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat    Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsHitHiddenEnemyProb
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsHitHiddenEnemyProb)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsHitHiddenEnemyProb:
jmp newmem
nop 3
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsHitHiddenEnemyProb:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

//Alt: db 48 83 EC 38 48 8B 41 28
    ]]

    local script62 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat     Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBlueAttackCrossProb
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBlueAttackCrossProb)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBlueAttackCrossProb:
jmp newmem
nop 3
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBlueAttackCrossProb:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

//Alt: db 48 83 EC 38 48 8B 41 28
    ]]

    local script63 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat    Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRedAttackCrossProb
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRedAttackCrossProb)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRedAttackCrossProb:
jmp newmem
nop 3
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsRedAttackCrossProb:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

//Alt: db 48 83 EC 38 48 8B 41 28
    ]]


    local script64 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat     Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBadStInvalidProb
alloc(newmem,2048,Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBadStInvalidProb)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

exit:
jmp returnhere

Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBadStInvalidProb:
jmp newmem
nop 3
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.QuestBattle.Characters.AbilityEnhancement.get_IsBadStInvalidProb:
sub rsp,08
mov eax,00000001
add rsp,08
ret
ret
add [rax],al
add [rax],al

//Alt: db 48 83 EC 38 48 8B 41 28
    ]]

    local script65 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat                 Bleach.Games.Common.Masters.PlayableMaster..ctor+50
alloc(newmem,2048,Bleach.Games.Common.Masters.PlayableMaster..ctor+50)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
mov [rdi+3C],8000000
mov eax,[rbx+000000E8]

exit:
jmp returnhere

Bleach.Games.Common.Masters.PlayableMaster..ctor+50:
jmp newmem
nop 4
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.Common.Masters.PlayableMaster..ctor+50:
mov [rdi+3C],eax
mov eax,[rbx+000000E8]
//Alt: db 89 47 3C 8B 83 E8 00 00 00
    ]]

    local script66 = [[
{$lua}
if syntaxcheck then return end

-- Define the address only once
COOPRAIDNOCD = "Bleach.Games.Common.FloatTimer.IsEnd"

[ENABLE]
-- Write new bytes
writeBytes(COOPRAIDNOCD, 0xF3, 0x0F, 0x11, 0x6E, 0x1C)

-- Play sound
playSound(findTableFile('buttonpress.wav'))

[DISABLE]
-- Restore original bytes
writeBytes(COOPRAIDNOCD, 0xF3, 0x0F, 0x10, 0x46, 0x1C)
]]


    -- Check if ToggleBox14 is checked
    if sender.Checked then
        -- Enable script59
        local SCRIPT_59_enabledOk
        SCRIPT_59_enabledOk, SCRIPT_59_disableInfo = autoAssemble(script59)
        if not SCRIPT_59_enabledOk then
            return
        end

        -- Enable script60
        local SCRIPT_60_enabledOk
        SCRIPT_60_enabledOk, SCRIPT_60_disableInfo = autoAssemble(script60)
        if not SCRIPT_60_enabledOk then
            return
        end

        -- Enable script61
        local SCRIPT_61_enabledOk
        SCRIPT_61_enabledOk, SCRIPT_61_disableInfo = autoAssemble(script61)
        if not SCRIPT_61_enabledOk then
            return
        end

        -- Enable script62
        local SCRIPT_62_enabledOk
        SCRIPT_62_enabledOk, SCRIPT_62_disableInfo = autoAssemble(script62)
        if not SCRIPT_62_enabledOk then
            return
        end

        -- Enable script63
        local SCRIPT_63_enabledOk
        SCRIPT_63_enabledOk, SCRIPT_63_disableInfo = autoAssemble(script63)
        if not SCRIPT_63_enabledOk then
            return
        end

        -- Enable script64
        local SCRIPT_64_enabledOk
        SCRIPT_64_enabledOk, SCRIPT_64_disableInfo = autoAssemble(script64)
        if not SCRIPT_64_enabledOk then
            return
        end

        -- Enable script65
        local SCRIPT_65_enabledOk
        SCRIPT_65_enabledOk, SCRIPT_65_disableInfo = autoAssemble(script65)
        if not SCRIPT_65_enabledOk then
            return
        end

        -- Enable script66
        local SCRIPT_66_enabledOk
        SCRIPT_66_enabledOk, SCRIPT_66_disableInfo = autoAssemble(script66)
        if not SCRIPT_66_enabledOk then
            return
        end

    else
        -- Disable script59
        if SCRIPT_59_disableInfo then
            autoAssemble(script59, SCRIPT_59_disableInfo)
            SCRIPT_59_disableInfo = nil
        end

        -- Disable script60
        if SCRIPT_60_disableInfo then
            autoAssemble(script60, SCRIPT_60_disableInfo)
            SCRIPT_60_disableInfo = nil
        end

        -- Disable script61
        if SCRIPT_61_disableInfo then
            autoAssemble(script61, SCRIPT_61_disableInfo)
            SCRIPT_61_disableInfo = nil
        end

        -- Disable script62
        if SCRIPT_62_disableInfo then
            autoAssemble(script62, SCRIPT_62_disableInfo)
            SCRIPT_62_disableInfo = nil
        end

        -- Disable script63
        if SCRIPT_63_disableInfo then
            autoAssemble(script63, SCRIPT_63_disableInfo)
            SCRIPT_63_disableInfo = nil
        end

        -- Disable script64
        if SCRIPT_64_disableInfo then
            autoAssemble(script64, SCRIPT_64_disableInfo)
            SCRIPT_64_disableInfo = nil
        end

        -- Disable script65
        if SCRIPT_65_disableInfo then
            autoAssemble(script65, SCRIPT_65_disableInfo)
            SCRIPT_65_disableInfo = nil
        end

        -- Disable script66
        if SCRIPT_66_disableInfo then
            autoAssemble(script66, SCRIPT_66_disableInfo)
            SCRIPT_66_disableInfo = nil
        end
    end
end






local SCRIPT_67_disableInfo
local SCRIPT_68_disableInfo

-- Script definitions
local script67 = [[
{$lua}
[ENABLE]
writeFloat('["UnityPlayer.dll"+01CADC78]+FC', 2)
[DISABLE]
writeFloat('["UnityPlayer.dll"+01CADC78]+FC', 1)
]]

local script68 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat                UnityEngine.Time.set_timeScale
alloc(newmem,2048,UnityEngine.Time.set_timeScale)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
ret

exit:
jmp returnhere

UnityEngine.Time.set_timeScale:
jmp newmem
nop 9
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
UnityEngine.Time.set_timeScale:
ret
//Alt: db 48 83 EC 38 48 8B 05 7D C4 5E 01
]]

-- Function to enable scripts
local function enableScripts()
    -- Enable script67
    local SCRIPT_67_enabledOk
    SCRIPT_67_enabledOk, SCRIPT_67_disableInfo = autoAssemble(script67)
    if not SCRIPT_67_enabledOk then
        local message = "Error enabling script 67"
        messageDialog(message, mtWarning, mbOK)
        return false
    end

    -- Enable script68
    local SCRIPT_68_enabledOk
    SCRIPT_68_enabledOk, SCRIPT_68_disableInfo = autoAssemble(script68)
    if not SCRIPT_68_enabledOk then
        local message = "Error enabling script 68"
        messageDialog(message, mtWarning, mbOK)
        return false
    end

    return true
end

-- Function to disable scripts
local function disableScripts()
    -- Disable script67 if it was previously enabled
    if SCRIPT_67_disableInfo then
        autoAssemble(script67, SCRIPT_67_disableInfo)
        SCRIPT_67_disableInfo = nil
    end

    -- Disable script68 if it was previously enabled
    if SCRIPT_68_disableInfo then
        autoAssemble(script68, SCRIPT_68_disableInfo)
        SCRIPT_68_disableInfo = nil
    end
end

-- ToggleBox15 click handler
function ToggleBox15Click(sender)
    -- Check if ToggleBox15 is checked
    if sender.Checked then
        -- Enable scripts
        enableScripts()
    else
        -- Disable scripts
        disableScripts()
    end
end










local SCRIPT_69_disableInfo
local SCRIPT_70_disableInfo

-- Script definitions
local script69 = [[
{$lua}
[ENABLE]
writeFloat('["UnityPlayer.dll"+01CADC78]+FC', 4)
[DISABLE]
writeFloat('["UnityPlayer.dll"+01CADC78]+FC', 1)
]]

local script70 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat                UnityEngine.Time.set_timeScale
alloc(newmem,2048,UnityEngine.Time.set_timeScale)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
ret

exit:
jmp returnhere

UnityEngine.Time.set_timeScale:
jmp newmem
nop 9
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
UnityEngine.Time.set_timeScale:
ret
//Alt: db 48 83 EC 38 48 8B 05 7D C4 5E 01
]]

-- Function to enable scripts
local function enableScripts()
    -- Enable script69
    local SCRIPT_69_enabledOk
    SCRIPT_69_enabledOk, SCRIPT_69_disableInfo = autoAssemble(script69)
    if not SCRIPT_69_enabledOk then
        local message = "Error enabling script 69"
        messageDialog(message, mtWarning, mbOK)
        return false
    end

    -- Enable script70
    local SCRIPT_70_enabledOk
    SCRIPT_70_enabledOk, SCRIPT_70_disableInfo = autoAssemble(script70)
    if not SCRIPT_70_enabledOk then
        local message = "Error enabling script 70"
        messageDialog(message, mtWarning, mbOK)
        return false
    end

    return true
end

-- Function to disable scripts
local function disableScripts()
    -- Disable script69 if it was previously enabled
    if SCRIPT_69_disableInfo then
        autoAssemble(script69, SCRIPT_69_disableInfo)
        SCRIPT_69_disableInfo = nil
    end

    -- Disable script70 if it was previously enabled
    if SCRIPT_70_disableInfo then
        autoAssemble(script70, SCRIPT_70_disableInfo)
        SCRIPT_70_disableInfo = nil
    end
end

-- ToggleBox16 click handler (renamed to ToggleBox17 for clarity)
function ToggleBox16Click(sender)
    -- Check if ToggleBox17 is checked
    if sender.Checked then
        -- Enable scripts
        enableScripts()
    else
        -- Disable scripts
        disableScripts()
    end
end








local SCRIPT_71_disableInfo
local SCRIPT_72_disableInfo

-- Script definitions
local script71 = [[
{$lua}
[ENABLE]
writeFloat('["UnityPlayer.dll"+01CADC78]+FC', 6)
[DISABLE]
writeFloat('["UnityPlayer.dll"+01CADC78]+FC', 1)
]]

local script72 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat                UnityEngine.Time.set_timeScale
alloc(newmem,2048,UnityEngine.Time.set_timeScale)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
ret

exit:
jmp returnhere

UnityEngine.Time.set_timeScale:
jmp newmem
nop 9
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
UnityEngine.Time.set_timeScale:
ret
//Alt: db 48 83 EC 38 48 8B 05 7D C4 5E 01
]]

-- Function to enable scripts
local function enableScripts()
    -- Enable script71
    local SCRIPT_71_enabledOk
    SCRIPT_71_enabledOk, SCRIPT_71_disableInfo = autoAssemble(script71)
    if not SCRIPT_71_enabledOk then
        local message = "Error enabling script 71"
        messageDialog(message, mtWarning, mbOK)
        return false
    end

    -- Enable script72
    local SCRIPT_72_enabledOk
    SCRIPT_72_enabledOk, SCRIPT_72_disableInfo = autoAssemble(script72)
    if not SCRIPT_72_enabledOk then
        local message = "Error enabling script 72"
        messageDialog(message, mtWarning, mbOK)
        return false
    end

    return true
end

-- ToggleBox18 click handler
function ToggleBox17Click(sender)
    -- Check if ToggleBox18 is checked
    if sender.Checked then
        -- Enable scripts
        enableScripts()
    else
        -- Disable scripts
        if SCRIPT_71_disableInfo then
            autoAssemble(script71, SCRIPT_71_disableInfo)
            SCRIPT_71_disableInfo = nil
        end
        if SCRIPT_72_disableInfo then
            autoAssemble(script72, SCRIPT_72_disableInfo)
            SCRIPT_72_disableInfo = nil
        end
    end
end











local SCRIPT_73_disableInfo
local SCRIPT_74_disableInfo

-- Script definitions
local script73 = [[
{$lua}
[ENABLE]
writeFloat('["UnityPlayer.dll"+01CADC78]+FC', 8)
[DISABLE]
writeFloat('["UnityPlayer.dll"+01CADC78]+FC', 1)
]]

local script74 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat                UnityEngine.Time.set_timeScale
alloc(newmem,2048,UnityEngine.Time.set_timeScale)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
ret

exit:
jmp returnhere

UnityEngine.Time.set_timeScale:
jmp newmem
nop 9
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
UnityEngine.Time.set_timeScale:
ret
//Alt: db 48 83 EC 38 48 8B 05 7D C4 5E 01
]]

-- Function to enable scripts
local function enableScripts()
    -- Enable script73
    local SCRIPT_73_enabledOk
    SCRIPT_73_enabledOk, SCRIPT_73_disableInfo = autoAssemble(script73)
    if not SCRIPT_73_enabledOk then
        local message = "Error enabling script 73"
        messageDialog(message, mtWarning, mbOK)
        return false
    end

    -- Enable script74
    local SCRIPT_74_enabledOk
    SCRIPT_74_enabledOk, SCRIPT_74_disableInfo = autoAssemble(script74)
    if not SCRIPT_74_enabledOk then
        local message = "Error enabling script 74"
        messageDialog(message, mtWarning, mbOK)
        return false
    end

    return true
end

-- ToggleBox19 click handler
function ToggleBox18Click(sender)
    -- Check if ToggleBox19 is checked
    if sender.Checked then
        -- Enable scripts
        enableScripts()
    else
        -- Disable scripts
        if SCRIPT_73_disableInfo then
            autoAssemble(script73, SCRIPT_73_disableInfo)
            SCRIPT_73_disableInfo = nil
        end
        if SCRIPT_74_disableInfo then
            autoAssemble(script74, SCRIPT_74_disableInfo)
            SCRIPT_74_disableInfo = nil
        end
    end
end













local SCRIPT_75_disableInfo
local SCRIPT_76_disableInfo

-- Script definitions
local script75 = [[
{$lua}
[ENABLE]
writeFloat('["UnityPlayer.dll"+01CADC78]+FC', 12)
[DISABLE]
writeFloat('["UnityPlayer.dll"+01CADC78]+FC', 1)
]]

local script76 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat                UnityEngine.Time.set_timeScale
alloc(newmem,2048,UnityEngine.Time.set_timeScale)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
ret

exit:
jmp returnhere

UnityEngine.Time.set_timeScale:
jmp newmem
nop 9
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
UnityEngine.Time.set_timeScale:
ret
//Alt: db 48 83 EC 38 48 8B 05 7D C4 5E 01
]]

-- Function to enable scripts
local function enableScripts()
    -- Enable script75
    local SCRIPT_75_enabledOk
    SCRIPT_75_enabledOk, SCRIPT_75_disableInfo = autoAssemble(script75)
    if not SCRIPT_75_enabledOk then
        local message = "Error enabling script 75"
        messageDialog(message, mtWarning, mbOK)
        return false
    end

    -- Enable script76
    local SCRIPT_76_enabledOk
    SCRIPT_76_enabledOk, SCRIPT_76_disableInfo = autoAssemble(script76)
    if not SCRIPT_76_enabledOk then
        local message = "Error enabling script 76"
        messageDialog(message, mtWarning, mbOK)
        return false
    end

    return true
end

-- ToggleBox20 click handler
function ToggleBox19Click(sender)
    -- Check if ToggleBox20 is checked
    if sender.Checked then
        -- Enable scripts
        enableScripts()
    else
        -- Disable scripts
        if SCRIPT_75_disableInfo then
            autoAssemble(script75, SCRIPT_75_disableInfo)
            SCRIPT_75_disableInfo = nil
        end
        if SCRIPT_76_disableInfo then
            autoAssemble(script76, SCRIPT_76_disableInfo)
            SCRIPT_76_disableInfo = nil
        end
    end
end











local SCRIPT_77_disableInfo
local SCRIPT_78_disableInfo

-- Script definitions
local script77 = [[
{$lua}
[ENABLE]
writeFloat('["UnityPlayer.dll"+01CADC78]+FC', 20)
[DISABLE]
writeFloat('["UnityPlayer.dll"+01CADC78]+FC', 1)
]]

local script78 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat                UnityEngine.Time.set_timeScale
alloc(newmem,2048,UnityEngine.Time.set_timeScale)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
ret

exit:
jmp returnhere

UnityEngine.Time.set_timeScale:
jmp newmem
nop 9
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
UnityEngine.Time.set_timeScale:
ret
//Alt: db 48 83 EC 38 48 8B 05 7D C4 5E 01
]]

-- Function to enable scripts
local function enableScripts()
    -- Enable script77
    local SCRIPT_77_enabledOk
    SCRIPT_77_enabledOk, SCRIPT_77_disableInfo = autoAssemble(script77)
    if not SCRIPT_77_enabledOk then
        local message = "Error enabling script 77"
        messageDialog(message, mtWarning, mbOK)
        return false
    end

    -- Enable script78
    local SCRIPT_78_enabledOk
    SCRIPT_78_enabledOk, SCRIPT_78_disableInfo = autoAssemble(script78)
    if not SCRIPT_78_enabledOk then
        local message = "Error enabling script 78"
        messageDialog(message, mtWarning, mbOK)
        return false
    end

    return true
end

-- ToggleBox21 click handler
function ToggleBox20Click(sender)
    -- Check if ToggleBox21 is checked
    if sender.Checked then
        -- Enable scripts
        enableScripts()
    else
        -- Disable scripts
        if SCRIPT_77_disableInfo then
            autoAssemble(script77, SCRIPT_77_disableInfo)
            SCRIPT_77_disableInfo = nil
        end
        if SCRIPT_78_disableInfo then
            autoAssemble(script78, SCRIPT_78_disableInfo)
            SCRIPT_78_disableInfo = nil
        end
    end
end







local SCRIPT_79_disableInfo
local SCRIPT_80_disableInfo

-- Script definitions
local script79 = [[
{$lua}
[ENABLE]
writeFloat('["UnityPlayer.dll"+01CADC78]+FC', 30)
[DISABLE]
writeFloat('["UnityPlayer.dll"+01CADC78]+FC', 1)
]]

local script80 = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat                UnityEngine.Time.set_timeScale
alloc(newmem,2048,UnityEngine.Time.set_timeScale)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
ret

exit:
jmp returnhere

UnityEngine.Time.set_timeScale:
jmp newmem
nop 9
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
UnityEngine.Time.set_timeScale:
ret
//Alt: db 48 83 EC 38 48 8B 05 7D C4 5E 01
]]

-- Function to enable scripts
local function enableScripts()
    -- Enable script79
    local SCRIPT_79_enabledOk
    SCRIPT_79_enabledOk, SCRIPT_79_disableInfo = autoAssemble(script79)
    if not SCRIPT_79_enabledOk then
        local message = "Error enabling script 79"
        messageDialog(message, mtWarning, mbOK)
        return false
    end

    -- Enable script80
    local SCRIPT_80_enabledOk
    SCRIPT_80_enabledOk, SCRIPT_80_disableInfo = autoAssemble(script80)
    if not SCRIPT_80_enabledOk then
        local message = "Error enabling script 80"
        messageDialog(message, mtWarning, mbOK)
        return false
    end

    return true
end

-- ToggleBox21 click handler
function ToggleBox21Click(sender)
    -- Check if ToggleBox21 is checked
    if sender.Checked then
        -- Enable scripts
        enableScripts()
    else
        -- Disable scripts
        if SCRIPT_79_disableInfo then
            autoAssemble(script79, SCRIPT_79_disableInfo)
            SCRIPT_79_disableInfo = nil
        end
        if SCRIPT_80_disableInfo then
            autoAssemble(script80, SCRIPT_80_disableInfo)
            SCRIPT_80_disableInfo = nil
        end
    end
end



















local SCRIPT_81_disableInfo, SCRIPT_86_disableInfo

-- Script definitions
local script81 = [[
{$lua}
if syntaxcheck then return end

[ENABLE]
speedhack_setSpeed(3)

[DISABLE]
speedhack_setSpeed(1)
]]

local script86 = [[
[ENABLE]
{$Lua}
if syntaxcheck then return end
-- Play the loading sound when enabled
playSound(findTableFile('buttonpress.wav'))
{$Asm}

[DISABLE]
{$Lua}
if syntaxcheck then return end
{$Asm}
]]

-- Function to enable script81
local function enableScript81()
    local enabledOk
    enabledOk, SCRIPT_81_disableInfo = autoAssemble(script81)
    if not enabledOk then
        local message = "Error enabling script 81"
        messageDialog(message, mtWarning, mbOK)
        return false
    end
    return true
end

-- Function to disable script81
local function disableScript81()
    if SCRIPT_81_disableInfo then
        autoAssemble(script81, SCRIPT_81_disableInfo)
        SCRIPT_81_disableInfo = nil
    end
end

-- Function to enable script86
local function enableScript86()
    local enabledOk
    enabledOk, SCRIPT_86_disableInfo = autoAssemble(script86)
    if not enabledOk then
        local message = "Error enabling script 86"
        messageDialog(message, mtWarning, mbOK)
        return false
    end
    return true
end

-- Function to disable script86
local function disableScript86()
    if SCRIPT_86_disableInfo then
        autoAssemble(script86, SCRIPT_86_disableInfo)
        SCRIPT_86_disableInfo = nil
    end
end

-- ToggleBox22 click handler
function ToggleBox22Click(sender)
    if sender.Checked then
        -- Enable scripts
        enableScript81()
        enableScript86()
    else
        -- Disable scripts
        disableScript81()
        disableScript86()
    end
end









local SCRIPT_82_disableInfo, SCRIPT_85_disableInfo

-- Script definitions
local script82 = [[
{$lua}
if syntaxcheck then return end

[ENABLE]
speedhack_setSpeed(5)

[DISABLE]
speedhack_setSpeed(1)
]]

local script85 = [[
[ENABLE]
{$Lua}
if syntaxcheck then return end
-- Play the loading sound when enabled
playSound(findTableFile('buttonpress.wav'))
{$Asm}

[DISABLE]
{$Lua}
if syntaxcheck then return end
{$Asm}
]]

-- Function to enable script82
local function enableScript82()
    local enabledOk
    enabledOk, SCRIPT_82_disableInfo = autoAssemble(script82)
    if not enabledOk then
        local message = "Error enabling script 82"
        messageDialog(message, mtWarning, mbOK)
        return false
    end
    return true
end

-- Function to disable script82
local function disableScript82()
    if SCRIPT_82_disableInfo then
        autoAssemble(script82, SCRIPT_82_disableInfo)
        SCRIPT_82_disableInfo = nil
    end
end

-- Function to enable script85
local function enableScript85()
    local enabledOk
    enabledOk, SCRIPT_85_disableInfo = autoAssemble(script85)
    if not enabledOk then
        local message = "Error enabling script 85"
        messageDialog(message, mtWarning, mbOK)
        return false
    end
    return true
end

-- Function to disable script85
local function disableScript85()
    if SCRIPT_85_disableInfo then
        autoAssemble(script85, SCRIPT_85_disableInfo)
        SCRIPT_85_disableInfo = nil
    end
end

-- ToggleBox23 click handler
function ToggleBox23Click(sender)
    if sender.Checked then
        -- Enable scripts
        enableScript82()
        enableScript85()
    else
        -- Disable scripts
        disableScript82()
        disableScript85()
    end
end








local SCRIPT_83_disableInfo, SCRIPT_84_disableInfo

-- Script definitions
local script83 = [[
{$lua}
if syntaxcheck then return end

[ENABLE]
speedhack_setSpeed(10)

[DISABLE]
speedhack_setSpeed(1)
]]

local script84 = [[
[ENABLE]
{$Lua}
if syntaxcheck then return end
-- Play the loading sound when enabled
playSound(findTableFile('buttonpress.wav'))
{$Asm}

[DISABLE]
{$Lua}
if syntaxcheck then return end
{$Asm}
]]

-- Function to enable script83
local function enableScript83()
    local enabledOk
    enabledOk, SCRIPT_83_disableInfo = autoAssemble(script83)
    if not enabledOk then
        local message = "Error enabling script 83"
        messageDialog(message, mtWarning, mbOK)
        return false
    end
    return true
end

-- Function to disable script83
local function disableScript83()
    if SCRIPT_83_disableInfo then
        autoAssemble(script83, SCRIPT_83_disableInfo)
        SCRIPT_83_disableInfo = nil
    end
end

-- Function to enable script84
local function enableScript84()
    local enabledOk
    enabledOk, SCRIPT_84_disableInfo = autoAssemble(script84)
    if not enabledOk then
        local message = "Error enabling script 84"
        messageDialog(message, mtWarning, mbOK)
        return false
    end
    return true
end

-- Function to disable script84
local function disableScript84()
    if SCRIPT_84_disableInfo then
        autoAssemble(script84, SCRIPT_84_disableInfo)
        SCRIPT_84_disableInfo = nil
    end
end

-- ToggleBox24 click handler
function ToggleBox24Click(sender)
    if sender.Checked then
        -- Enable scripts
        enableScript83()
        enableScript84()
    else
        -- Disable scripts
        disableScript83()
        disableScript84()
    end
end








-- Create a reference to the cheat table record
local memrec = nil

-- Your auto assembler script
local script = [[
[ENABLE]
//code from here to '[DISABLE]' will be used to enable the cheat    Bleach.Games.Guild.UI.GuildUIController.UpdateTimeCount+6
alloc(newmem,2048,Bleach.Games.Guild.UI.GuildUIController.UpdateTimeCount+6)
label(returnhere)
label(originalcode)
label(exit)

newmem: //this is allocated memory, you have read,write,execute access
//place your code here

originalcode:
xor rcx,rcx

exit:
jmp returnhere

Bleach.Games.Guild.UI.GuildUIController.UpdateTimeCount+6:
jmp newmem
nop 2
returnhere:




[DISABLE]
//code from here till the end of the code will be used to disable the cheat
dealloc(newmem)
Bleach.Games.Guild.UI.GuildUIController.UpdateTimeCount+6:
cmp byte ptr [rcx+30],00
mov rbx,rcx
//Alt: db 80 79 30 00 48 8B D9
]]

-- Create the memory record in the cheat table
memrec = getAddressList().createMemoryRecord()
memrec.setType(vtAutoAssembler)
memrec.Script = script
memrec.Active = false  -- start disabled

-- Hotkey function (toggle)
createHotkey(function()
    memrec.Active = not memrec.Active
end, VK_F2)





