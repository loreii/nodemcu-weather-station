if adc.force_init_mode(adc.INIT_ADC)
then
  node.restart()
  return -- don't bother continuing, the restart is scheduled
end


v = adc.read(0)
pressure = 1.80845*v + 175.926
print("val " .. (v*0.00322265625).."V pressure "..pressure.."mBar")

-- from datasheet
-- Vout = Vs* (.009*P-.095) Â± Error 
-- Vs = 5.1 Vdc
