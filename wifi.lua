-- Wifi static setup

wifi.setmode(wifi.STATION)
ssid='MB'
password= '******'

station_cfg={}
station_cfg.ssid=ssid
station_cfg.pwd=password
station_cfg.save=true
wifi.sta.config(station_cfg)
wifi.sta.connect()

tmr.alarm(1,2000, 1, function() 
   if wifi.sta.getip()==nil then 
      print(" Wait for IP --> "..wifi.sta.status()) 
   else 
      print("New IP address is "..wifi.sta.getip()) 
      tmr.stop(1) 
      dofile("boot.lua")
   end 
end)

print('init.lua ready') 
--if file.open("list_AP.lua") then
--  print(file.read())
--  file.close()
--end

function listap(t)
    for k,v in pairs(t) do
        print(k.." : "..v)
    end
end
wifi.sta.getap(listap)

print(wifi.sta.getapinfo())
print(wifi.sta.getconfig())
