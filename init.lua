--BASED ON NODEMCU BUILD : 
--NodeMCU custom build by frightanic.com
--    branch: master
--    commit: 5073c199c01d4d7bbbcd0ae1f761ecc4687f7217
--    SSL: false
--    modules: adc,bme280,enduser_setup,file,gpio,http,i2c,net,node,tmr,uart,websocket,wifi
-- build  built on: 2018-01-07 16:19
-- powered by Lua 5.1.4 on SDK 2.1.0(116b762)

-- boot it with ADC enable
if adc.force_init_mode(adc.INIT_ADC)
then
  node.restart()
  return 
end

dofile('boot.lua')
