#####################################################################
# CSC258H5S Fall 2020 Assembly Final Project
# University of Toronto, St. George
#
# Student: Jeffrey Wong
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 512
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestone is reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1/2/3/4/[5] (choose the one the applies)
#
# Which approved additional features have been implemented?
# (See the assignment handout for the list of additional features)
# 1. Game over / retry (Milestone 4)
# 2. Scoreboard (Milestone 4)
# 3. Fancier graphics (Milestone 5)
# 4. More platforms (Milestone 5)
# 5. Sound Effects (Milestone 5)
# 6. Dynamic on-screen notifications (Milestone 5)
#
# Any additional information that the TA needs to know: N/A
#
#####################################################################
.data
	bufferAddress: .word 0x10003000										# Buffer address
	displayAddress: .word 0x10008000
	doodlerOutlineColor: .word 0x000000									# Doodler Outline Color
	doodlerColor: .word 0x6FB407										# Doodler Inner Color
	doodlerEyeColor: .word 0xffffff										# Doodler Eye Color
	
	platformLocationConst: .word 7860, 6676, 5444, 4392, 3368, 2376, 1284					# Constant Array for Platform Locations (Do not change)
	platformLocation: .word 7860, 6676, 5444, 4392, 3368, 2376, 1284  					# Array of platform location(can change)
	platformColorsConst: .word 0x00ac00, 0x00ac00, 0x00ac00, 0x67abea, 0x00ac00, 0x943aab, 0x986f22		# Constant Array for Platform Colors (Do not change)
	platformColors: .word 0x00ac00, 0x00ac00, 0x00ac00, 0x67abea, 0x00ac00, 0x943aab, 0x986f22		# Array of platform colors (can change)
	backgroundColor: .word 0xF1E3AC										# Background color
	textColor: .word 0x00B1AE										# Text color 
	scoreBackground: .word 0x00004E										# Scoreboard background color							
		
	endMessage: .asciiz "Play again?"
	
.text
j initialLoadIn		# Jump to Game Main Loop Function
######################################################
# Fill Screen with Background Function
######################################################
backgroundFillInit:
	lw $t0, bufferAddress			# $t0 stores the base address for display
	lw $s0, backgroundColor 		# $s0 stores the background color code
	addi $t1, $t0, 9472			# max location (bottom right)

backgroundFillLoop:
	beq $t0, $t1, backgroundFillExit
	sw $s0, 0($t0) 				# paint the pixels with background color
	addi $t0, $t0, 4
	j backgroundFillLoop

backgroundFillExit:
	li $t0, 0				# reset $t0 register
	li $t1, 0				# reset $t1 register
	jr $ra
	
######################################################
# Draw Platform Function
# $a0 => screen display address of leftmost pixel
# $a1 => platform's color
######################################################
drawPlatform:
	sw $a1, 0($a0)
	add $a0, $a0, 4
	sw $a1, 0($a0)
	add $a0, $a0, 4
	sw $a1, 0($a0)
	add $a0, $a0, 4
	sw $a1, 0($a0)
	add $a0, $a0, 4
	sw $a1, 0($a0)
	add $a0, $a0, 4
	sw $a1, 0($a0)
	add $a0, $a0, 4
	sw $a1, 0($a0)
	add $a0, $a0, 124
	sw $a1, 0($a0)
	add $a0, $a0, -4
	sw $a1, 0($a0)
	add $a0, $a0, -4
	sw $a1, 0($a0)
	add $a0, $a0, -4
	sw $a1, 0($a0)
	add $a0, $a0, -4
	sw $a1, 0($a0)
	jr $ra

######################################################
# Get Display Address Function
# $a0 -> x-coord
# $a1 -> y-coord
######################################################
getDisplayAddress:
	lw $t0, bufferAddress
	mul $t1, $a1, 128	
	mul $t2, $a0, 4
	add $t3, $t1, $t2
	add $v0, $t0, $t3
	jr $ra
	
######################################################
# Draw Doodler Function
# $a0 -> screen display address
# $a1 -> doodler's color code
######################################################
drawDoodler:
	lw $a1, doodlerOutlineColor
	sw $a1, ($a0)
	add $a0, $a0, -128
	sw $a1, ($a0)
	add $a0, $a0, -128
	sw $a1, ($a0)
	add $a0, $a0, -128
	sw $a1, ($a0)
	add $a0, $a0, -4
	sw $a1, ($a0)
	add $a0, $a0, -124
	sw $a1, ($a0)
	add $a0, $a0, -124
	sw $a1, ($a0)
	add $a0, $a0, 4
	sw $a1, ($a0)
	add $a0, $a0, 4
	sw $a1, ($a0)
	add $a0, $a0, 132
	sw $a1, ($a0)
	add $a0, $a0, 128
	sw $a1, ($a0)
	add $a0, $a0, 4
	sw $a1, ($a0)
	add $a0, $a0, 124
	sw $a1, ($a0)
	add $a0, $a0, 128
	sw $a1, ($a0)
	add $a0, $a0, 128
	sw $a1, ($a0)
	add $a0, $a0, -132
	sw $a1, ($a0)
	add $a0, $a0, -4
	sw $a1, ($a0)
	add $a0, $a0, -4
	sw $a1, ($a0)
	lw $a1, doodlerColor
	add $a0, $a0, -128
	sw $a1, ($a0)
	add $a0, $a0, 4
	sw $a1, ($a0)
	add $a0, $a0, 4
	sw $a1, ($a0)
	add $a0, $a0, -128
	sw $a1, ($a0)
	add $a0, $a0, -4
	sw $a1, ($a0)
	add $a0, $a0, -4
	sw $a1, ($a0)
	add $a0, $a0, -124
	sw $a1, ($a0)
	lw $a1 doodlerEyeColor
	add $a0, $a0, -4
	sw $a1, ($a0)
	add $a0, $a0, 8
	sw $a1, ($a0)
	add $a0, $a0, 500
	jr $ra

######################################################
# Get Keyboard Input Function
######################################################
getKeyboardInput:
	lw $t7, 0xffff0000
	beq $t7, 1, keyboard_input
	j exitCheckKeyboard
keyboard_input:
	lw $t6, 0xffff0004
	beq $t6, 106, respond_to_j
	beq $t6, 107, respond_to_k
	beq $t6, 115, respond_to_s	
	j exitCheckKeyboard
respond_to_j:
	add $v0, $zero, -1	# go left
	li $t7, 0
	li $t6, 0
	jr $ra
respond_to_k: 
	add $v0, $zero, 1	# go right
	li $t7, 0
	li $t6, 0
	jr $ra
respond_to_s:
	add $v0, $zero, 2	# start game
	jr $ra
exitCheckKeyboard:
	add $v0, $zero, 0	# stay same
	li $t7, 0
	li $t6, 0
	jr $ra
	
######################################################
# Shift Objects Down (acts like screen moving down)
######################################################
shiftDown:
	la $s5, platformLocation
	add $t0, $zero, $zero 		# $t0 holds 4*i; initially 0
	addi $t1, $zero, 28 		# $t1 holds 3*sizeof(int)
arrayLoopAgain:
	bge $t0, $t1, endAgain 		# branch if $t0 >= 12
	add $t3, $s5, $t0 		# $t3 holds addr(platformLocation[i])
	lw $t5, 0($t3) 			# $t5 = platformLocation[i]
	add $t5, $t5, 128		# shift platform location down one level
	sw $t5, 0($t3)			# draw onto screen
	addi $t0, $t0, 4 		# update offset in $t0
	j arrayLoopAgain
endAgain:
	jr $ra
	
######################################################
# Move Buffer Address to Main Display Address
######################################################
moveBufferToMainInit:
	add $t0, $zero, $zero
	addi $t1, $zero, 8192 
moveBuffToMainLoop:
	beq $t0, $t1, doneMoving
	add $t2, $t0, 0x10003000		# buffer display
	lw $t3, 0($t2)
	add $t2, $t0, 0x10008000		# actual display
	sw $t3, 0($t2)
	add $t0, $t0, 4
	j moveBuffToMainLoop
doneMoving:
	jr $ra
	
######################################################
# Move Platform Back Up 
######################################################
resetPlatform:
	la $s1, platformColors		# $s1 stores the platform colors for each platform
	la $s5, platformLocation
	add $t0, $zero, $zero 		# $t0 holds 4*i; initially 0
	addi $t1, $zero, 28 		# $t1 holds 3*sizeof(int)
platArrayLoop:
	bge $t0, $t1, movePlatEnd 	# branch if $t0 >= 400 
	add $t3, $s5, $t0 		# $t3 holds addr(platformLocation[i])
	add $t2, $s1, $t0
	lw $t5, 0($t3) 			# $t5 = platformLocation[i]
	lw $t4, 0($t2) 			# $t4 = platformColors[i]
	ble $t5, 8192, updateLoop
	# Get random number
	li $v0, 42
	li $a0, 0
	li $a1, 25
	syscall
	mul $t5, $a0, 4
	sw $t5, 0($t3)
	beq $t4, 0xF1E3AC, changeBackToBrown	# Branch if platform is brown
	j updateLoop
updateLoop:
	addi $t0, $t0, 4 # update offset in $t0
	j platArrayLoop
movePlatEnd:
	jr $ra
changeBackToBrown:
	li $t4, 0x986f22			# $t4 stores the color code of brown
	sw $t4, ($t2)				# Change platform color back to brown
	j updateLoop

######################################################
# Game Main Loop
######################################################
initialLoadIn:
	add $t9, $zero, $zero		# loop counter of jumping
	addi $t8, $zero, 14		# max height of jump
	
	addi $s6, $zero, 15		# initial Doodler X-coord (change each time move)
	addi $s7, $zero, 68		# initial Doodler Y-coord (change each time move)
	
	add $s4, $zero, $zero		# $s4 stores the score
	
	# Reset Platforms
	la $t0, platformLocation
	la $t1, platformLocationConst
	add $t3, $t0, 0 # $t3 holds addr(platformLocation[i])
	add $t2, $t1, 0 # $t2 holds addr(platformLocationConst[i])
	lw $t4, ($t2) # $t4 = platformLocationConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 4 # $t3 holds addr(platformLocation[i])
	add $t2, $t1, 4 # $t2 holds addr(platformLocationConst[i])
	lw $t4, 0($t2) # $t4 = platformLocationConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 8 # $t3 holds addr(platformLocation[i])
	add $t2, $t1, 8 # $t2 holds addr(platformLocationConst[i])
	lw $t4, 0($t2) # $t4 = platformLocationConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 12 # $t3 holds addr(platformLocation[i])
	add $t2, $t1, 12 # $t2 holds addr(platformLocationConst[i])
	lw $t4, 0($t2) # $t4 = platformLocationConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 16 # $t3 holds addr(platformLocation[i])
	add $t2, $t1, 16 # $t2 holds addr(platformLocationConst[i])
	lw $t4, 0($t2) # $t4 = platformLocationConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 20 # $t3 holds addr(platformLocation[i])
	add $t2, $t1, 20 # $t2 holds addr(platformLocationConst[i])
	lw $t4, 0($t2) # $t4 = platformLocationConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 24 # $t3 holds addr(platformLocation[i])
	add $t2, $t1, 24 # $t2 holds addr(platformLocationConst[i])
	lw $t4, 0($t2) # $t4 = platformLocationConst[i]
	sw $t4, ($t3)
	
	la $t0, platformColors
	la $t1, platformColorsConst
	add $t3, $t0, 0 # $t3 holds addr(platformColors[i])
	add $t2, $t1, 0 # $t2 holds addr(platformColorsConst[i])
	lw $t4, ($t2) # $t4 = platformColorsConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 4 # $t3 holds addr(platformColors[i])
	add $t2, $t1, 4 # $t2 holds addr(platformColorsConst[i])
	lw $t4, 0($t2) # $t4 = platformColorsConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 8 # $t3 holds addr(platformColors[i])
	add $t2, $t1, 8 # $t2 holds addr(platformColorsConst[i])
	lw $t4, 0($t2) # $t4 = platformColorsConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 12 # $t3 holds addr(platformColors[i])
	add $t2, $t1, 12 # $t2 holds addr(platformColorsConst[i])
	lw $t4, 0($t2) # $t4 = platformColorsConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 16 # $t3 holds addr(platformColors[i])
	add $t2, $t1, 16 # $t2 holds addr(platformColorsConst[i])
	lw $t4, 0($t2) # $t4 = platformColorsConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 20 # $t3 holds addr(platformColors[i])
	add $t2, $t1, 20 # $t2 holds addr(platformColorsConst[i])
	lw $t4, 0($t2) # $t4 = platformColorsConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 24 # $t3 holds addr(platformColors[i])
	add $t2, $t1, 24 # $t2 holds addr(platformColorsConst[i])
	lw $t4, 0($t2) # $t4 = platformColorsConst[i]
	sw $t4, ($t3)
	
	jal backgroundFillInit		# jump to function that fills background
	jal drawMenu			# jump to function that draws the menu
	
	jal moveBufferToMainInit	# jump to move pixels from buffer to main function
	
	jal getKeyboardInput		# jump to get keyboard input function
	beq $v0, 2, mainLoop
	j initialLoadIn
	
mainLoop: 
	# reset registers back to 0
	li $t0, 0
	li $t1, 0
	li $t2, 0
	li $t3, 0
	li $t4, 0
movementUpLoop:
	beq $t9, $t8, movementDownLoop
	# Reset Background
	jal backgroundFillInit
	
	ble $s7, 36, shiftObj
	j platformInitUp
	shiftObj:
	jal shiftDown
	addi $s7, $s7, 1
	
	platformInitUp:	
	la $s1, platformColors			# $s1 stores the platform colors for each platform
	la $s5, platformLocation		# $s5 stores the platform locations in terms of pixels 
	add $t0, $zero, $zero 			# $t0 holds 4*i; initially 0
	addi $t1, $zero, 28 			# $t1 holds 7*sizeof(int)
	arrayLoopUp:
	bge $t0, $t1, END1 			# branch if $t0 >= 28 
	add $t3, $s5, $t0 			# $t3 holds addr(platformLocation[i])
	add $t2, $s1, $t0 			# $t2 holds addr(platformColors[i])
	lw $t5, 0($t3) 				# $t5 = platformLocation[i]
	lw $t4, 0($t2)				# $t4 = platformColors[i]
	beq $t4, 0x67abea, moveRightBlueUp
	finishMoveRightBlueUp:
	add $a0, $t5, 0x10003000 
	move $a1, $t4
	jal drawPlatform
	addi $t0, $t0, 4 			# update offset in $t0
	j arrayLoopUp
	
	moveRightBlueUp:
	addi $t5, $t5, 4
	div $t7, $t5, 128
	mfhi $t7
	beq $t7, 0, shiftBackUp1
	sw $t5, 0($t3)
	j finishMoveRightBlueUp
	
	shiftBackUp1:
	addi $t5, $t5, -128
	sw $t5, 0($t3)
	j finishMoveRightBlueUp
	
	END1:
	jal resetPlatform
	# Check Keyboard Input and Draw Doodle
	jal getKeyboardInput
	add $s6, $s6, $v0
	add $a0, $zero, $s6			# $a0 stores the current x-coord
	add $a1, $zero, $s7			# $a1 stores the current y-coord
	jal getDisplayAddress
	move $a0, $v0
	lw $a1,doodlerColor
	jal drawDoodler
	
	# Check Score Board and Change Accordingly
	add $a3, $s4, $zero
	jal calcScoreDisplay
	
	div $t1, $s4, 50
	mfhi $t1
	beq $t1, 49, drawDynamicWOW
	beq $t1, 25, drawDynamicNICE
	beq $t1, 10, drawDynamicPOG
	j continueFromDrawDynamicUp
	drawDynamicWOW:
	jal drawWOW
	j continueFromDrawDynamicUp
	drawDynamicPOG:
	jal drawPOG
	j continueFromDrawDynamicUp
	drawDynamicNICE:
	jal drawNICE
	j continueFromDrawDynamicUp
	
	continueFromDrawDynamicUp:
	li $v0, 32
	li $a0, 50
	syscall
	
	addi $t9, $t9, 1		# increment loop counter
	addi $s7, $s7, -1		# change y-coord to new location
	
	jal moveBufferToMainInit
	j movementUpLoop
	
movementDownLoop:
	# Reset Background
	jal backgroundFillInit
	
	# Create Platforms
	platformInitDown:
	la $s1, platformColors			# $s1 stores the platform colors for each platform
	la $s5, platformLocation		# $s5 stores the platform locations in terms of pixels 
	add $t0, $zero, $zero 			# $t0 holds 4*i; initially 0
	addi $t1, $zero, 28 			# $t1 holds 3*sizeof(int)
	arrayLoopDown:
	bge $t0, $t1, END2 			# branch if $t0 >= 28 
	add $t3, $s5, $t0 			# $t3 holds addr(platformLocation[i])
	add $t2, $s1, $t0 			# $t2 holds addr(platformColors[i])
	lw $t5, 0($t3) 				# $t5 = platformLocation[i]
	lw $t4, 0($t2) 				# $t4 = platformColors[i]
	beq $t4, 0x67abea, moveRightBlueDown
	finishMoveRightBlueDown:
	add $a0, $t5, 0x10003000 
	move $a1, $t4				# $a1 now stores the color of platform
	jal drawPlatform
	addi $t0, $t0, 4 			# update offset in $t0
	j arrayLoopDown
	
	moveRightBlueDown:
	addi $t5, $t5, 4
	div $t7, $t5, 128
	mfhi $t7
	beq $t7, 0, shiftBackUp
	sw $t5, 0($t3)
	j finishMoveRightBlueDown
	
	shiftBackUp:
	addi $t5, $t5, -128
	sw $t5, 0($t3)
	j finishMoveRightBlueDown
	
	END2:
	# Check Keyboard Input and Draw Doodle
	jal getKeyboardInput
	add $s6, $s6, $v0
	add $a0, $zero, $s6			# $a0 stores the current x-coord
	add $a1, $zero, $s7			# $a1 stores the current y-coord
	jal getDisplayAddress
	move $a0, $v0
	lw $a1,doodlerColor
	jal drawDoodler
	move $s2, $a0				# $s2 now stores the display address position of Doodler
	
	# Check Score Board and Change Accordingly
	add $a3, $s4, 0				# $a3 stores score temporarily for function call
	jal calcScoreDisplay
	
	jal moveBufferToMainInit
	
	# Check Collision with Platforms
	add $s0, $s2, 144				# pixel below of right foot
	add $s1, $s2, 128				# pixel below of left foot
	lw $s3, ($s1)					# $s3 stores the color below right foot
	lw $s2, ($s0)					# $s2 stores the color below left foot
	beq $s3, 0x00ac00, moveToUp			# branch if below is green (platform)
	beq $s2, 0x00ac00, moveToUp			# branch if below is green (platform)
	beq $s3, 0x986f22, moveToUpBrown		# branch if below is brown (platform)
	beq $s2, 0x986f22, moveToUpBrown		# branch if below is brown (platform)
	beq $s3, 0x67abea, moveToUp			# branch if below is blue (platform)
	beq $s2, 0x67abea, moveToUp			# branch if below is blue (platform)
	beq $s3, 0x943aab, moveToUpPurple		# branch if below is blue (platform)
	beq $s2, 0x943aab, moveToUpPurple		# branch if below is blue (platform)
	j checkDead					# check if dead (go below screen)
	# If below is platform, move to movementUpLoop
	moveToUp:
	li $v0, 31
	li $a0, 79
	li $a1, 150
	li $a2, 7
	li $a3, 127
	syscall	
	addi $s4, $s4, 1				# increase score +1
	add $t9, $zero, $zero				# reset jump counter
	j movementUpLoop				# go to movementUpLoop
	
	moveToUpPurple:
	li $v0, 31
	li $a0, 79
	li $a1, 150
	li $a2, 7
	li $a3, 127
	syscall	
	addi $s4, $s4, 2				# increase score +2
	add $t9, $zero, $zero				# reset jump counter
	j movementUpLoop				# go to movementUpLoop
	
	moveToUpBrown:
	la $t7, platformColors				# $s1 stores the platform colors for each platform
	la $s5, platformLocation			# $s5 stores the platform locations in terms of pixels 
	add $t0, $zero, $zero 				# $t0 holds 4*i; initially 0
	addi $t1, $zero, 28 				# $t1 holds 3*sizeof(int)
	arrayLoopDownBrown:
	bge $t0, $t1, moveToUp 				# branch if $t0 >= 12 
	add $t3, $s5, $t0 				# $t3 holds addr(platformLocation[i])
	add $t2, $t7, $t0 				# $t2 holds addr(platformColors[i])
	lw $t5, 0($t3) 					# $t5 = platformLocation[i]
	lw $t4, 0($t2) 					# $t4 = platformColors[i]
	bne $t4, 0x986f22, arrayLoopDownBrownExit
	li $t4, 0xF1E3AC
	sw $t4, ($t2)
	j moveToUp
	arrayLoopDownBrownExit:
	addi $t0, $t0, 4 				# update offset in $t0
	j arrayLoopDownBrown
	
	checkDead:
	bge $s7, 66, Exit
	j continue
	
	continue:
	li $v0, 32
	li $a0, 50
	syscall
	
	addi $t9, $t9, 1
	addi $s7, $s7, 1				# change y-coord to new location
	j movementDownLoop
	
######################################################
# Draw GG!
######################################################
drawGG:
	lw $t0, bufferAddress
	li $t1, 0x000000
	addi $t0, $t0, 3760
	sw $t1, ($t0)
	addi $t0, $t0, -4
	sw $t1, ($t0)
	addi $t0, $t0, -4
	sw $t1, ($t0)
	addi $t0, $t0, -4
	sw $t1, ($t0)
	addi $t0, $t0, 128
	sw $t1, ($t0)
	addi $t0, $t0, 128
	sw $t1, ($t0)
	addi $t0, $t0, 128
	sw $t1, ($t0)
	addi $t0, $t0, 128
	sw $t1, ($t0)
	addi $t0, $t0, 128
	sw $t1, ($t0)
	addi $t0, $t0, 128
	sw $t1, ($t0)
	addi $t0, $t0, 4
	sw $t1, ($t0)
	addi $t0, $t0, 4
	sw $t1, ($t0)
	addi $t0, $t0, 4
	sw $t1, ($t0)
	addi $t0, $t0, -128
	sw $t1, ($t0)
	addi $t0, $t0, -128
	sw $t1, ($t0)
	addi $t0, $t0, -4
	sw $t1, ($t0)
	
	
	lw $t0, bufferAddress
	addi $t0, $t0, 3792
	sw $t1, ($t0)
	addi $t0, $t0, -4
	sw $t1, ($t0)
	addi $t0, $t0, -4
	sw $t1, ($t0)
	addi $t0, $t0, -4
	sw $t1, ($t0)
	addi $t0, $t0, 128
	sw $t1, ($t0)
	addi $t0, $t0, 128
	sw $t1, ($t0)
	addi $t0, $t0, 128
	sw $t1, ($t0)
	addi $t0, $t0, 128
	sw $t1, ($t0)
	addi $t0, $t0, 128
	sw $t1, ($t0)
	addi $t0, $t0, 128
	sw $t1, ($t0)
	addi $t0, $t0, 4
	sw $t1, ($t0)
	addi $t0, $t0, 4
	sw $t1, ($t0)
	addi $t0, $t0, 4
	sw $t1, ($t0)
	addi $t0, $t0, -128
	sw $t1, ($t0)
	addi $t0, $t0, -128
	sw $t1, ($t0)
	addi $t0, $t0, -4
	sw $t1, ($t0)
	
	jr $ra

######################################################
# Terminate Program (Exit)
######################################################
Exit:
	li $v0, 31
	li $a0, 35
	li $a1, 400
	li $a2, 7
	li $a3, 127
	syscall	
	# Add GG! Right here
	jal backgroundFillInit
	jal drawGG
	jal moveBufferToMainInit
	la $a0, endMessage
	li $v0, 50 
	syscall		
	beq $a0, 0, resetPlatforms
	beq $a0, 1, resetToInitialLoadIn
	
	resetPlatforms:
	# Reset Platforms
	la $t0, platformLocation
	la $t1, platformLocationConst
	add $t3, $t0, 0 # $t3 holds addr(platformLocation[i])
	add $t2, $t1, 0 # $t2 holds addr(platformLocationConst[i])
	lw $t4, ($t2) # $t4 = platformLocationConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 4 # $t3 holds addr(platformLocation[i])
	add $t2, $t1, 4 # $t2 holds addr(platformLocationConst[i])
	lw $t4, 0($t2) # $t4 = platformLocationConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 8 # $t3 holds addr(platformLocation[i])
	add $t2, $t1, 8 # $t2 holds addr(platformLocationConst[i])
	lw $t4, 0($t2) # $t4 = platformLocationConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 12 # $t3 holds addr(platformLocation[i])
	add $t2, $t1, 12 # $t2 holds addr(platformLocationConst[i])
	lw $t4, 0($t2) # $t4 = platformLocationConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 16 # $t3 holds addr(platformLocation[i])
	add $t2, $t1, 16 # $t2 holds addr(platformLocationConst[i])
	lw $t4, 0($t2) # $t4 = platformLocationConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 20 # $t3 holds addr(platformLocation[i])
	add $t2, $t1, 20 # $t2 holds addr(platformLocationConst[i])
	lw $t4, 0($t2) # $t4 = platformLocationConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 24 # $t3 holds addr(platformLocation[i])
	add $t2, $t1, 24 # $t2 holds addr(platformLocationConst[i])
	lw $t4, 0($t2) # $t4 = platformLocationConst[i]
	sw $t4, ($t3)
	
	la $t0, platformColors
	la $t1, platformColorsConst
	add $t3, $t0, 0 # $t3 holds addr(platformColors[i])
	add $t2, $t1, 0 # $t2 holds addr(platformColorsConst[i])
	lw $t4, ($t2) # $t4 = platformColorsConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 4 # $t3 holds addr(platformColors[i])
	add $t2, $t1, 4 # $t2 holds addr(platformColorsConst[i])
	lw $t4, 0($t2) # $t4 = platformColorsConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 8 # $t3 holds addr(platformColors[i])
	add $t2, $t1, 8 # $t2 holds addr(platformColorsConst[i])
	lw $t4, 0($t2) # $t4 = platformColorsConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 12 # $t3 holds addr(platformColors[i])
	add $t2, $t1, 12 # $t2 holds addr(platformColorsConst[i])
	lw $t4, 0($t2) # $t4 = platformColorsConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 16 # $t3 holds addr(platformColors[i])
	add $t2, $t1, 16 # $t2 holds addr(platformColorsConst[i])
	lw $t4, 0($t2) # $t4 = platformColorsConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 20 # $t3 holds addr(platformColors[i])
	add $t2, $t1, 20 # $t2 holds addr(platformColorsConst[i])
	lw $t4, 0($t2) # $t4 = platformColorsConst[i]
	sw $t4, ($t3)
	add $t3, $t0, 24 # $t3 holds addr(platformColors[i])
	add $t2, $t1, 24 # $t2 holds addr(platformColorsConst[i])
	lw $t4, 0($t2) # $t4 = platformColorsConst[i]
	sw $t4, ($t3)
	
	add $t9, $zero, $zero		# loop counter of jumping
	addi $t8, $zero, 14		# max height of jump
	addi $s6, $zero, 15		# initial Doodler X-coord (change each time move)
	addi $s7, $zero, 68		# initial Doodler Y-coord (change each time move)
	add $s4, $zero, $zero		# $s4 stores the score
	j movementUpLoop
	
	resetToInitialLoadIn:
	jal backgroundFillInit
	j initialLoadIn
	
	terminate:
	li $v0, 10 # terminate the program gracefully
	syscall	

######################################################
# Create Score Display
######################################################
calcScoreDisplay:
	move $s5, $ra
	lw $t0, scoreBackground
	lw $t1, bufferAddress
	addi $t2, $zero, 0
	add $t2, $t2, $t1
	add $t3, $t1, 1020
	sw $t0, ($t2)
	scoreDisplayloop:
	beq $t2, $t3, branch
	add $t2, $t2, 4
	sw $t0, ($t2)
	j scoreDisplayloop
	branch:
	j calcScore
	return:
	li $a0, 0	# clear $a0
	li $a1, 0	# clear $a1
	li $a3, 0	# clear $a2
	jr $s5

######################################################
# Calculating Score to Display 
######################################################
calcScore:
lw $t0, textColor
add $s4, $zero, $a3	# constant register for score
add $t2, $zero, 100
add $t3, $zero, 10

div $t4, $s4, $t2	
mflo $t4		# $t4 stores the quotient of $s4/$t2(100) 
move $a3, $t4
add $t4, $zero, $zero
add $a1, $zero, 208
jal drawZero	
jal drawOne
jal drawTwo	
jal drawThree
jal drawFour	
jal drawFive
jal drawSix
jal drawSeven
jal drawEight
jal drawNine
add $t2, $zero, 100
add $t3, $zero, 10
div $t4, $s4, $t2	
mfhi $t4		# $t4 stores the remainder of $s4/$t2(100) 
div $t4, $t4, $t3	
mflo $t4
move $a3, $t4
add $a1, $zero, 224
jal drawZero	
jal drawOne
jal drawTwo	
jal drawThree
jal drawFour	
jal drawFive
jal drawSix
jal drawSeven
jal drawEight
jal drawNine
add $t2, $zero, 100
add $t3, $zero, 10
div $t4, $s4, $t3	
mfhi $t4
move $a3, $t4
add $a1, $zero, 240
jal drawZero	
jal drawOne
jal drawTwo	
jal drawThree
jal drawFour	
jal drawFive
jal drawSix
jal drawSeven
jal drawEight
jal drawNine
j return

drawOne:
	bne $a3, 1, drawOneExit
	add $t2, $zero, $a1
	add $t2, $t2, $t1
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
drawOneExit:
	jr $ra
	
drawTwo:
	bne $a3, 2, drawTwoExit
	add $t2, $zero, $a1
	add $t2, $t2, $t1
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 124
	sw $t0, ($t2)
	add $t2, $t2, 124
	sw $t0, ($t2) 
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2) 
drawTwoExit:
	jr $ra
	
drawThree:
	bne $a3, 3, drawThreeExit
	add $t2, $zero, $a1
	add $t2, $t2, $t1
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 124
	sw $t0, ($t2)
	add $t2, $t2, 132
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
drawThreeExit:
	jr $ra
	
drawFour:
	bne $a3, 4, drawFourExit
	add $t2, $zero, $a1
	add $t2, $t2, $t1
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
drawFourExit:
	jr $ra

drawFive:
	bne $a3, 5, drawFiveExit
	add $t2, $zero, $a1
	add $t2, $t2, $t1
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
drawFiveExit:
	jr $ra
	
drawSix:
	bne $a3, 6, drawSixExit
	add $t2, $zero, $a1
	add $t2, $t2, $t1
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
drawSixExit:
	jr $ra

drawSeven:
	bne $a3, 7, drawSevenExit
	add $t2, $zero, $a1
	add $t2, $t2, $t1
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
drawSevenExit:
	jr $ra
	
drawEight:
	bne $a3, 8, drawEightExit
	add $t2, $zero, $a1
	add $t2, $t2, $t1
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
drawEightExit:
	jr $ra

drawNine:
	bne $a3, 9, drawNineExit
	add $t2, $zero, $a1
	add $t2, $t2, $t1
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -128
	add $t2, $t2, 4
	add $t2, $t2, 4
	add $t2, $t2, 128
	add $t2, $t2, 128
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
drawNineExit:
	jr $ra
	
drawZero:
	bne $a3, 0, drawZeroExit
	add $t2, $zero, $a1
	add $t2, $t2, $t1
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
drawZeroExit:
	jr $ra
	
######################################################
# Draw Main Menu
######################################################
drawMenu:
	lw $t0, textColor
	lw $t1, bufferAddress
	
	# D
	addi $t2, $zero, 1428
	add $t2, $t2, $t1
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, -124
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -132
	sw $t0, ($t2)
	
	# O
	add $t2, $t2, 12
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	
	# O
	add $t2, $t2, 12
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	
	# D
	add $t2, $t2, 12
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, -124
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -132
	sw $t0, ($t2)
	
	# L
	add $t2, $t2, 12
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	
	# E
	add $t2, $t2, -504
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 120
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 120
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	
	# J
	add $t2, $t2, 312
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	
	# U
	add $t2, $t2, -496
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	
	# M
	add $t2, $t2, 8
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, -512
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 132
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, -252
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)

	# P
	add $t2, $t2, -504
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, -512
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	
	# S
	addi $t2, $zero, 4364
	add $t2, $t2, $t1
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 120
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	
	# -
	add $t2, $t2, -240
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	
	# S
	add $t2, $t2, -248
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 120
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	
	# T
	addi $t2, $zero, 4408
	add $t2, $t2, $t1
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 124
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	
	# A
	add $t2, $t2, -496
	sw $t0, ($t2)
	add $t2, $t2, 124
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, -252
	sw $t0, ($t2)
	add $t2, $t2, -124
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	
	# R
	add $t2, $t2, -504
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 8
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -132
	sw $t0, ($t2)
	add $t2, $t2, -124
	sw $t0, ($t2)
	add $t2, $t2, -132
	sw $t0, ($t2)
	
	# T
	add $t2, $t2, 12
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 124
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	
	# J
	addi $t2, $zero, 5396
	add $t2, $t2, $t1
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	
	# -
	add $t2, $t2, -240
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	
	# L
	add $t2, $t2, -248
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	
	# E
	add $t2, $t2, -504
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 120
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 120
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	
	# F
	add $t2, $t2, -504
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 120
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 120
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	
	# T
	add $t2, $t2, -496
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 124
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	
	# K
	addi $t2, $zero, 6540
	add $t2, $t2, $t1
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 8
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -132
	sw $t0, ($t2)
	add $t2, $t2, -124
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	
	# -
	add $t2, $t2, 264
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	
	# R
	add $t2, $t2, -248
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 8
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -132
	sw $t0, ($t2)
	add $t2, $t2, -124
	sw $t0, ($t2)
	add $t2, $t2, -132
	sw $t0, ($t2)
	
	# I
	add $t2, $t2, 12
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)

	# G
	add $t2, $t2, -500
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 120
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 132
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, -124
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -4
	sw $t0, ($t2)
	
	# H
	add $t2, $t2, -244
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, -252
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	add $t2, $t2, 512
	sw $t0, ($t2)
	add $t2, $t2, -128
	sw $t0, ($t2)
	
	# T
	add $t2, $t2, -376
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 4
	sw $t0, ($t2)
	add $t2, $t2, 124
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	add $t2, $t2, 128
	sw $t0, ($t2)
	
	jr $ra

####################################################
# Dynamic Words
####################################################
drawWOW:
	lw $a0, textColor
	addi $t2, $zero, 132
	add $t2, $t2, 0x10003000
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, -124
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, 260
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	
	add $t2, $t2, 8
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, -4
	sw $a0, ($t2)
	
	add $t2, $t2, 12
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, -124
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, 260
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	jr $ra

drawPOG:
	lw $a0, textColor
	addi $t2, $zero, 132
	add $t2, $t2, 0x10003000
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, -512
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, -4
	sw $a0, ($t2)
	
	add $t2, $t2, -244
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, -4
	sw $a0, ($t2)
	
	add $t2, $t2, 12
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, -8
	sw $a0, ($t2)
	add $t2, $t2, -260
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	jr $ra

drawNICE:
	lw $a0, textColor
	addi $t2, $zero, 132
	add $t2, $t2, 0x10003000
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, -380
	sw $a0, ($t2)
	add $t2, $t2, 132
	sw $a0, ($t2)
	add $t2, $t2, 132
	sw $a0, ($t2)
	add $t2, $t2, 132
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	add $t2, $t2, -128
	sw $a0, ($t2)
	
	add $t2, $t2, 8
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	
	add $t2, $t2, -504
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, 120
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	
	add $t2, $t2, -504
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, 120
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, 120
	sw $a0, ($t2)
	add $t2, $t2, 128
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	add $t2, $t2, 4
	sw $a0, ($t2)
	jr $ra
