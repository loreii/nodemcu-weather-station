--Boot Registry

print('load telnet server module')
      dofile('telnet-server.lua')
      
print('load enduser server module')
      dofile('enduser.lua')    
      
print('load main module')
    dofile('main.lua')
    --dofile("mqtt.lua")
