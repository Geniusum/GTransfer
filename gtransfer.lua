-- Récupère l'ID de l'ordinateur de destination et le nom du fichier à transférer à partir des arguments de ligne de commande
local args = {...}
local destComputerID = tonumber(args[1])
local fileToTransfer = args[2]

-- Vérifie si les arguments sont valides
if not destComputerID or not fileToTransfer then
  print("Usage: gtransfer <destination computer id> <file to transfer>")
  return
end

-- Vérifie si le fichier à transférer existe
if not fs.exists(fileToTransfer) then
  print("Error: File does not exist")
  return
end

-- Ouvre une connexion avec l'ordinateur de destination
local destComputer = peripheral.wrap("top") -- Remplacez "top" par le nom de l'ordinateur de destination
local destFile = fs.open(fileToTransfer, "r")
local fileContent = destFile.readAll()

-- Envoie le contenu du fichier à l'ordinateur de destination
destComputer.invoke(destComputerID, "receiveFile", fileToTransfer, fileContent)

-- Ferme la connexion et le fichier
destFile.close()
print("File transfer complete!")
