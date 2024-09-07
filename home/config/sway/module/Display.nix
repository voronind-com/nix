{ ... }: {
	text = ''
		# Example configuration:
		#
		#   output HDMI-A-1 resolution 1920x1080 position 1920,0
		#
		# You can get the names of your outputs by running: swaymsg -t get_outputs
		output * scale 1
		output "Huawei Technologies Co., Inc. ZQE-CBA 0xC080F622" pos 0,1080
		output "ASUSTek COMPUTER INC ASUS VA24E R2LMTF127165" mode 1920x1080@74.986Hz transform 180 pos 780,0
	'';
}
