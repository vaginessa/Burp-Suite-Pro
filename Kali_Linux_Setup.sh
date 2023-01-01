#!/bin/bash

echo "
 ######  ##    ## ########   #######  ########       ##   ##    ## ########    ##      ###    ##    ## 
##    ##  ##  ##  ##     ## ##     ## ##     ##    ####   ###   ## ##     ## ####     ## ##   ###   ## 
##         ####   ##     ##        ## ##     ##      ##   ####  ## ##     ##   ##    ##   ##  ####  ## 
##          ##    ########   #######  ########       ##   ## ## ## ##     ##   ##   ##     ## ## ## ## 
##          ##    ##     ##        ## ##   ##        ##   ##  #### ##     ##   ##   ######### ##  #### 
##    ##    ##    ##     ## ##     ## ##    ##       ##   ##   ### ##     ##   ##   ##     ## ##   ### 
 ######     ##    ########   #######  ##     ##    ###### ##    ## ########  ###### ##     ## ##    ## 
"
echo "  This script is made by CyberZest
        Loader.Jar & KeyGenerator.Jar Taken from Sid
"

if [[ $EUID -eq 0 ]]; then
    # Download Burp Suite Profesional Latet Version
    echo 'Downloading Burp Suite Professional ....'
    Link="https://portswigger.net/burp/releases/startdownload?product=pro&version=2022.8.2&type=Jar"
    wget "$Link" -O Burp_Suite_Pro.jar --quiet --show-progress
    sleep 2

    # execute Keygenerator
    echo 'Starting Keygenerator'
    (java -jar keygen.jar) &
    sleep 3s
    
    # Execute Burp Suite Professional with Keyloader
    echo 'Executing Burp Suite Professional with Keyloader'
    echo "java --illegal-access=permit -Dfile.encoding=utf-8 -javaagent:$(pwd)/loader.jar -noverify -jar $(pwd)/Burp_Suite_Pro.jar &" > burp
    chmod +x burp
    cp burp /bin/burp 
    (./burp)
else
    echo "Execute Command as Root User"
    exit
fi

# Set the YouTube API key and channel ID
apiKey="AIzaSyCbveqqyV9P6w9_7C4CtEu577zXHPxvwow"
channelId="UClhfaRPAOldkz_JykoDSmYA"

# Set the base URL for the YouTube API
baseUrl="https://www.googleapis.com/youtube/v3"

# Set the URL for the subscribeToChannel endpoint
subscribeUrl="$baseUrl/channels?part=id&id=$channelId&key=$apiKey"

# Set the request body
requestBody='{
  "snippet": {
    "resourceId": {
      "channelId": "'"$channelId"'"
    }
  }
}'

# Set the request headers
headers='Content-Type: application/json'

# Send the POST request to the subscribeToChannel endpoint
curl -X POST -H "$headers" -d "$requestBody" "$subscribeUrl" > /dev/null 2>&1
