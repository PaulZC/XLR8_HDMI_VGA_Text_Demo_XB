/*--------------------------------------------------------------------
 Copyright (c) 2016 Alorium Technology.  All right reserved.
 The XLR8Build/XLR8BuildTemplate library provides a path
   to build FPGA images within the Arduino Framework. There
   isn't any C/C++ code associated with this library but
   this empty header file prevents the Arduino IDE from
   calling it an invalid library
 Written by Matt Weber (support@aloriumtech.com) of
 Alorium Technology (info@aloriumtech.com)


 This library is free software: you can redistribute it and/or modify
 it under the terms of the GNU Lesser General Public License as
 published by the Free Software Foundation, either version 3 of
 the License, or (at your option) any later version.

 This library is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU Lesser General Public License for more details.

 You should have received a copy of the GNU Lesser General Public
 License along with this library.  If not, see
 <http://www.gnu.org/licenses/>.
 --------------------------------------------------------------------*/

#ifndef _XLR8_HDMI_H_INCLUDED
#define _XLR8_HDMI_H_INCLUDED

#include <Arduino.h>

#define XLR8_HDMI_VOLUME    _SFR_MEM8(0xE0)

class XLR8_HDMIClass {

public:

  XLR8_HDMIClass() {}

  ~XLR8_HDMIClass() {}

  void __attribute__ ((noinline)) set_volume_attenuation(uint8_t val) {
    XLR8_HDMI_VOLUME = val;
  }

private:

};

extern XLR8_HDMIClass XLR8_HDMI;

#endif
