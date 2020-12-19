# This program does polling on the receive and transmit device registers
# on the MARS Keyboard and Display Simulator. Any input received from
# the simulated keyboard is echoed to the simulated display.
# (c) 2010, Warren Toomey, GPL3

		.data
recv_data:	.word 0xffff0004	# Register which holds received chars
recv_ctrl:	.word 0xffff0000	# Register which indicates when data is available
send_data:	.word 0xffff000c	# Register which holds data to send
send_ctrl:	.word 0xffff0008	# Register which indicates when data can be sent


	.text
main:	lw	$t0, recv_data		# Set up 4 registers to have the addresses
	lw	$t1, recv_ctrl		# of the device's read and write registers
	lw	$t2, send_data
	lw	$t3, send_ctrl

readloop: lw $t5, ($t1)			# Check the receive control register
	  beq $t5, $0, readloop		# Loop back while it is zero
	  lw $t5, ($t0)			# Read the character in the receive register

	  move $a0, $t5                 # Debug, print out the character as an integer
	  li $v0, 1
	  syscall

writeloop: lw $t6, ($t3)		# See if we can write a character now
	   bne $t6, 1, writeloop	# Not zero, so not yet, loop back
	   sw $t5, ($t2)		# Yes we can, so put the char to write in the send register
	   b readloop			# and loop back to do it all again
