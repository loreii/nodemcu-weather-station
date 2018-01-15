-- Setup I2C and load sensors data from 
-- Microchip TC74 id 0x48
-- AD7414 id 0x49
-- ADC0  MXP4115A  

sensor_delay_ms = 900000 -- 15min
-- pin configuration
id  = 0
sda = 7 
scl = 6

-- initialize i2c, set pin1 as sda, set pin2 as scl
i2c.setup(id, sda, scl, i2c.SLOW)

-- user defined function: read from reg_addr content of dev_addr
function read_reg(dev_addr, reg_addr)
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.TRANSMITTER)
    i2c.write(id, reg_addr)
    i2c.stop(id)
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.RECEIVER)
    c = i2c.read(id, 1)
    i2c.stop(id)
    return c
end
 

-- Blink using timer alarm --
timerId = 2 -- we have seven timers! 0..6
dly = 1000  -- milliseconds
ledPin = 4  -- GPIO2

gpio.mode(ledPin,gpio.OUTPUT)

ledState = 0

tmr.alarm( timerId, dly, 1, function()
  ledState = 1 - ledState;
  gpio.write(ledPin, ledState)
  
end)


-- start the infinite push loop 
tmr.alarm(1,sensor_delay_ms, 1, function() 
   if wifi.sta.getip()==nil then 
      print("New IP address is "..wifi.sta.getip()) 
      tmr.stop(1) 
      dofile("init.lua")
   else 
        -- get content of register
        t1 =string.byte( read_reg(0x48, 0x00))
        print("Ambient temperature : "..t1) 
        -- get content of register
        t2 =string.byte( read_reg(0x49, 0x00))
        print("Ambient temperature : "..t2) 
        
        -- read ADC and convert pressure from MXP4115A
        v = adc.read(0)
        pressure = math.floor(1.80845*v + 175.926)
        print("ADC " .. (v*0.00322265625).."V -- Pressure "..pressure.."mBar")
       
        -- send it online
        -- http://loreii.com:8080/put?t=19&p=0
        url="http://loreii.com:8080/put?t="..t1.."&t2="..t2.."&p="..pressure
        print(url)
        http.get(url, nil, function(code, data)
            if (code < 0) then
              print("HTTP request failed")
            else
              print(code, data)
            end
          end)
   end 
end)

