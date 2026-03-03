json.extract! player, :id, :Player_ID, :First_Name, :Last_Name, :Current, :Bats, :Throws, :POS1, :POS2, :POS3, :Nickname, :Hometown, :Divorces, :DOB, :Height, :Weight, :Image, :uniform, :email
json.url player_url(player, format: :json)
