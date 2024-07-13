Remove-Item -Path "D:\Users\moksh\AppData\Local\Docker\VolumeData\mongo\*" -Recurse -Force

# Create the directory for MongoDB data
New-Item -Path "D:\Users\moksh\AppData\Local\Docker\VolumeData\mongo" -ItemType Directory -Force

# Generate the keyfile if it doesn't exist
$keyfilePath = "D:\Users\moksh\AppData\Local\Docker\VolumeData\mongo\mongo.keyfile"
if (-Not (Test-Path $keyfilePath)) {
    $randomBytes = New-Object Byte[] 741
    [System.Security.Cryptography.RandomNumberGenerator]::Fill($randomBytes)
    $keyfileContent = [Convert]::ToBase64String($randomBytes)
    [System.IO.File]::WriteAllText("D:\tmp\mongo.keyfile", $keyfileContent)
    Set-ItemProperty -Path "D:\tmp\mongo.keyfile" -Name IsReadOnly -Value $true
    Move-Item -Path "D:\tmp\mongo.keyfile" -Destination $keyfilePath
}

# Copy the mongod.conf file to the data directory
Copy-Item -Path "mongod.conf" -Destination "D:\Users\moksh\AppData\Local\Docker\VolumeData\mongo\mongod.conf" -Force
# Copy-Item -Path "mongod-windows.conf" -Destination "D:\Users\moksh\AppData\Local\Docker\VolumeData\mongo\mongod.conf" -Force

$dockerComposeFile = "mongo-compose-windows.yml"

# Set the name of your MongoDB container
$containerName = "mongo"

# Start MongoDB using Docker Compose
docker-compose -f $dockerComposeFile up -d --build

# Wait for MongoDB to initialize
Start-Sleep -Seconds 30

# MongoDB replica set initiation code
$replicaSetCode = @"
rs.initiate({
  _id: 'rs0',
  members: [
    { _id: 0, host: 'localhost:27017' }
  ]
});
"@

# Use docker exec to execute the MongoDB shell with the configuration file
docker exec -it $containerName mongosh -u root -p root --authenticationDatabase admin --eval $replicaSetCode

# Additional optional step to check the replica set status
$replicaSetStatus = docker exec -it $containerName mongosh -u root -p root --authenticationDatabase admin --eval "rs.status()"
Write-Output $replicaSetStatus
