# -----------------------------------------------------------------------------
# FSK-III FPGA Constraints
# -----------------------------------------------------------------------------

set_property BITSTREAM.CONFIG.UNUSEDPIN PULLDOWN [current_design]

# -----------------------------------------------------------------------------
# Global Clock
# -----------------------------------------------------------------------------
#set_property PACKAGE_PIN R4 [get_ports {SYS_CLK_100M}]
#set_property IOSTANDARD LVCMOS33 [get_ports {SYS_CLK_100M}]
#create_clock -period 10.000 [get_ports {SYS_CLK_100M}]   ;# 100 MHz


# -----------------------------------------------------------------------------
# Reset Switch
# -----------------------------------------------------------------------------
#set_property PACKAGE_PIN U7 [get_ports {SYS_RSTB}]
#set_property IOSTANDARD LVCMOS33 [get_ports {SYS_RSTB}]


# -----------------------------------------------------------------------------
# DIP Switch (SW1 ~ SW16)
# -----------------------------------------------------------------------------
#set_property PACKAGE_PIN J4  [get_ports {SW1}]
#set_property PACKAGE_PIN L3  [get_ports {SW2}]
#set_property PACKAGE_PIN K3  [get_ports {SW3}]
#set_property PACKAGE_PIN M2  [get_ports {SW4}]
#set_property PACKAGE_PIN K6  [get_ports {SW5}]
#set_property PACKAGE_PIN J6  [get_ports {SW6}]
#set_property PACKAGE_PIN L5  [get_ports {SW7}]
#set_property PACKAGE_PIN L4  [get_ports {SW8}]
#set_property PACKAGE_PIN R19 [get_ports {SW9}]
#set_property PACKAGE_PIN V19 [get_ports {SW10}]
#set_property PACKAGE_PIN T20 [get_ports {SW11}]
#set_property PACKAGE_PIN U20 [get_ports {SW12}]
#set_property PACKAGE_PIN V20 [get_ports {SW13}]
#set_property PACKAGE_PIN T21 [get_ports {SW14}]
#set_property PACKAGE_PIN U21 [get_ports {SW15}]
#set_property PACKAGE_PIN V22 [get_ports {SW16}]

#set_property IOSTANDARD LVCMOS15 [get_ports {SW1 SW2 SW3 SW4 SW5 SW6 SW7 SW8}]
#set_property IOSTANDARD LVCMOS33 [get_ports {SW9 SW10 SW11 SW12 SW13 SW14 SW15 SW16}]


# -----------------------------------------------------------------------------
# Push Button Switch
# -----------------------------------------------------------------------------
#set_property PACKAGE_PIN M20 [get_ports {PB1}]
set_property PACKAGE_PIN N20 [get_ports {b}]
#set_property PACKAGE_PIN M21 [get_ports {PB3}]
set_property PACKAGE_PIN M22 [get_ports {a}]
#set_property PACKAGE_PIN N22 [get_ports {PB5}]

set_property IOSTANDARD LVCMOS33 [get_ports {a b}]


# -----------------------------------------------------------------------------
# Discrete LEDs (LED1 ~ LED16)
# -----------------------------------------------------------------------------
#set_property PACKAGE_PIN Y18  [get_ports {LED1}]
#set_property PACKAGE_PIN AA18 [get_ports {LED2}]
#set_property PACKAGE_PIN AB18 [get_ports {LED3}]
#set_property PACKAGE_PIN W19  [get_ports {LED4}]
#set_property PACKAGE_PIN Y19  [get_ports {LED5}]
#set_property PACKAGE_PIN AA19 [get_ports {LED6}]
#set_property PACKAGE_PIN W20  [get_ports {LED7}]
#set_property PACKAGE_PIN AA20 [get_ports {LED8}]
#set_property PACKAGE_PIN AB20 [get_ports {LED9}]
#set_property PACKAGE_PIN W21  [get_ports {LED10}]
#set_property PACKAGE_PIN Y21  [get_ports {LED11}]
#set_property PACKAGE_PIN AA21 [get_ports {LED12}]
#set_property PACKAGE_PIN AB21 [get_ports {LED13}]
#set_property PACKAGE_PIN W22  [get_ports {LED14}]
set_property PACKAGE_PIN Y22  [get_ports {s}]
set_property PACKAGE_PIN AB22 [get_ports {c}]

set_property IOSTANDARD LVCMOS33 [get_ports {s c}]


# -----------------------------------------------------------------------------
# 7-Segment Display
# -----------------------------------------------------------------------------

# Segment Lines
#set_property PACKAGE_PIN U17 [get_ports {SEGMENT_A}]
#set_property PACKAGE_PIN V17 [get_ports {SEGMENT_B}]
#set_property PACKAGE_PIN W17 [get_ports {SEGMENT_C}]
#set_property PACKAGE_PIN R18 [get_ports {SEGMENT_D}]
#set_property PACKAGE_PIN T18 [get_ports {SEGMENT_E}]
#set_property PACKAGE_PIN U18 [get_ports {SEGMENT_F}]
#set_property PACKAGE_PIN V18 [get_ports {SEGMENT_G}]
#set_property PACKAGE_PIN P19 [get_ports {SEGMENT_DP}]

# Digit Select
#set_property PACKAGE_PIN P14 [get_ports {SEG_DIG1}]
#set_property PACKAGE_PIN R14 [get_ports {SEG_DIG2}]
#set_property PACKAGE_PIN P15 [get_ports {SEG_DIG3}]
#set_property PACKAGE_PIN P16 [get_ports {SEG_DIG4}]
#set_property PACKAGE_PIN R16 [get_ports {SEG_DIG5}]
#set_property PACKAGE_PIN N17 [get_ports {SEG_DIG6}]
#set_property PACKAGE_PIN P17 [get_ports {SEG_DIG7}]
#set_property PACKAGE_PIN R17 [get_ports {SEG_DIG8}]

#set_property IOSTANDARD LVCMOS33 [get_ports {
#SEGMENT_A SEGMENT_B SEGMENT_C SEGMENT_D
#SEGMENT_E SEGMENT_F SEGMENT_G SEGMENT_DP
#SEG_DIG1 SEG_DIG2 SEG_DIG3 SEG_DIG4
#SEG_DIG5 SEG_DIG6 SEG_DIG7 SEG_DIG8
#}]
