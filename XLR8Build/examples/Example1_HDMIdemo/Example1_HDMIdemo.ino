/*
  HDMI Demo

  Runs on the Alorium Technologies Sno board

  Written by: Paul Clark
  Date: August 11th 2020

  This sets the volume attenuation for the sawtooth sound in the hdmi_demo
  0 = no attenuation (this will be REALLY loud!)
  9 = sensible attenuation
  16 = maximum attenuation (mute)

*/

#include "XLR8_HDMI.h"

void setup()
{

  XLR8_HDMI.set_volume_attenuation(9); // Set the volume attenuation

}

void loop()
{
  // Nothing to do here...
}
