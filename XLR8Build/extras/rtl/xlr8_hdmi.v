// File name: xlr8_hdmi.v
// Author:    Paul Clark
// Based on:  xlr8_wrap_template.v
// By:        Steve Phillips

module xlr8_hdmi  // NOTE: Change the module name to match your design
  #(
    // Parameter definitions. The ADDR parameters will be defined when
    // this module is instantiated.
    parameter VOLUME_ADDR = 0,      // Address of the register that will hold the volume attenuation value
    parameter WIDTH = 8
    )
   (
    // Input/Ouput definitions for the module. These are standard and
    // while other ports could be added, these are required.
    //  
    // Clock and Reset
    input        clk_pixel, // Pixel Clock
	 input        clk_audio, // Audio Clock
    input        rstn, //      Reset
    input        clken, //     Clock Enable
	 
    // I/O 
    input [7:0]  dbus_in, //   Data Bus Input
    output [7:0] dbus_out, //  Data Bus Output
    output       io_out_en, // IO Output Enable
	 
    output [2:0] datap,			// HDMI RGB Data Pins (+ve)
    output [2:0] datan,			// HDMI RGB Data Pins (-ve)
    output clkp,					// HDMI Clock (+ve)
    output clkn,					// HDMI Clock (-ve)
	 output heartbeat,			// Heartbeat
	 
    // DM
    input [7:0]  ramadr, //    RAM Address
    input        ramre, //     RAM Read Enable
    input        ramwe, //     RAM Write Enable
    input        dm_sel //    DM Select
    );
   
   //======================================================================
   // Interfaces to the user module:
   
	logic volume_sel;
	logic volume_we;
	logic volume_re;
	logic [WIDTH-1:0] volume_reg; // The register that will hold the red component of pixels that are on

   // End, interfaces
   //----------------------------------------------------------------------

   
   //======================================================================
   //  Control select
   //
   // For each register interface, do control select based on address
   assign volume_sel = dm_sel && (ramadr == VOLUME_ADDR);
   assign volume_we  = volume_sel && ramwe;
   assign volume_re  = volume_sel && ramre;
   
   // Mux the data and enable outputs
   assign dbus_out =  ({8{  volume_sel }} &  volume_reg );

   assign io_out_en = volume_re;

   // End, Control Select
   //----------------------------------------------------------------------
   

   //======================================================================
   // Load write data from AVR core into registers
   //
   // For data written from the AVR core to the user module, you may
   // want to register the value here so that it is held for reference
   // until the net update in value

   always @(posedge clk_pixel) begin
		if (clken && volume_we) begin
        volume_reg <= dbus_in[WIDTH-1:0];
      end
   end
   
   // End, Load write data
   //----------------------------------------------------------------------
   
   
   //======================================================================
   // Instantiate user module
   //
   // Below is an example instantiation of a simple user module. It
   // provides just enough I/O to demonstrate how the above logic is
   // connected.
   
   hdmi_demo hdmi_inst (
                    .CLK_PIXEL   (clk_pixel),
						  .CLK_AUDIO	(clk_audio),
						  .HDMI_TX     (datap),
	                 .HDMI_TX_N	(datan),
						  .HDMI_CLK		(clkp),
						  .HDMI_CLK_N	(clkn),
						  .VOLUME		(volume_reg),
						  .heartbeat	(heartbeat)
                    );
   
   // End, Instantiate user module
   //----------------------------------------------------------------------
   
endmodule

