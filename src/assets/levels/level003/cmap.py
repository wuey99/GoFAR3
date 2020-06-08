#----------------------------------------------------------------------------
import Image

def cmap ():
#----------------------------------------------------------------------------
	im = Image.open ("level-cx.png")
	cmap = open ("cmap.c", "w")

#----------------------------------------------------------------------------
	cmap.write ("var CMapArray:Array = [\n");

#----------------------------------------------------------------------------
	cells = 0

	for y in range(0, 960, 16):
		for x in range(0, 1280, 16):
        		color = im.getpixel ((x, y))
#			print ": ", color
# solid collision
			if color[0] == 255 and color[1] == 0 and color[2] == 0:
				cmap.write ("1")
# ladder top
			elif color[0] == 216 and color[1] == 252 and color[2] == 216:
				cmap.write ("2")
			elif color[0] == 186 and color[1] == 252 and color[2] == 186:
				cmap.write ("3")
			elif color[0] == 155 and color[1] == 252 and color[2] == 155:
				cmap.write ("4")
# ladder bottom
			elif color[0] == 232 and color[1] == 232 and color[2] == 255:
				cmap.write ("5")
			elif color[0] == 199 and color[1] == 200 and color[2] == 255:
				cmap.write ("6")
			elif color[0] == 166 and color[1] == 168 and color[2] == 255:
				cmap.write ("7")
			else:
				cmap.write ("0")

			if (y == 960-16 and x == 1280-16):
				pass
			else:
				cmap.write (",");

			if (x == 1280-16):
				cmap.write ("\n");

			cells += 1

#----------------------------------------------------------------------------
	print ": ", cells

	cmap.write ("];");

#----------------------------------------------------------------------------
	cmap.close ()

#----------------------------------------------------------------------------
cmap ()
