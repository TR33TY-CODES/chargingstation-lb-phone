Hello everyone!

Today, I want to introduce a new script for FiveM that I developed for the QBCore framework. Originally, this script was meant just for my server, but I decided to share it with the community. Why not spread some good?

Script Features
Charging Zones: You can set up specific zones in the config.lua where your character can charge their phone with a charging cable. The zones are defined using the PolyZone library, which allows you to create custom zones in the game world.
In-Vehicle Charging: If your character has a charging cable, they can also charge their phone while driving in a vehicle.

Important Notes
To ensure the script works correctly, you need to consider two things:
Install PolyZone: Since the script uses the PolyZone library, make sure that PolyZone is installed and properly configured on your server.
Item Entry: You must add the item charging_cable to qb-core/shared/items.lua. Without this entry, the charging cable will not be recognized in the game, and the charging functionality won't work.

Customization
The script is fully editable. Feel free to modify it as you wish or even rewrite it for ESX if you'd like. There are no restrictions, so go wild!

No Support
Please note that I do not provide support for this script. It's just a little project I wanted to share. If you like it and can use it, that's great! But I won't be answering technical questions or fixing issues.

Have fun with it!
