import sys, os, pygame, picamera, time
from pygame.locals import *
from openalpr import Alpr

os.environ["SDL_FBDEV"] = "/dev/fb1"
#image-path = "/home/pi/mirror/SharedPictures"
#image-path = "/mnt/wdmycloud/Backup Dropbox/Camera Uploads"
imagepath = "/home/pi/alpr/images"
imagename = "img.jpg"

alpr= Alpr("gb",  "/etc/openalpr/openalpr.conf", "/usr/src/openalpr/runtime_data")

if not alpr.is_loaded():
   print("Error loading OpenALPR")
   sys.exit(1)

alpr.set_top_n(3)

camera = picamera.PiCamera()

pygame.init()

DISPLAYSURF = pygame.display.set_mode((320, 240), 0, 32)
pygame.mouse.set_visible(0)
pygame.display.set_caption('APLR')

## Draw background
black_square_that_is_the_size_of_the_screen = pygame.Surface(DISPLAYSURF.get_size())
black_square_that_is_the_size_of_the_screen.fill((0, 0, 0))
DISPLAYSURF.blit(black_square_that_is_the_size_of_the_screen, (0, 0))
pygame.display.update()

quit = False
while not quit:
    for event in pygame.event.get():
        #if event.type == QUIT:
        quit = True
        pygame.quit()
        sys.exit()
        
    ## Draw background
    black_square_that_is_the_size_of_the_screen = pygame.Surface(DISPLAYSURF.get_size())
    black_square_that_is_the_size_of_the_screen.fill((0, 0, 0))
    DISPLAYSURF.blit(black_square_that_is_the_size_of_the_screen, (0, 0))
    
            
    camera.capture(imagepath + imagename)
    results = alpr.recognize_file(imagepath + imagename)
    i = 0

    for plate in results['results']:
        
        for candidate in plate['candidates']:
            dtext = str(candidate['plate']) + " -- " + str(candidate['confidence'])           
            font = pygame.font.Font(None, 30)
            text = font.render(dtext, 1, (255, 255, 255))
            textpos = text.get_rect(center=(DISPLAYSURF.get_width()/2,170+i))
            DISPLAYSURF.blit(text, textpos)
            i += 28
            
            
    pic = pygame.image.load(imagepath + imagename)
    DISPLAYSURF.blit(pygame.transform.scale(pic, (DISPLAYSURF.get_width()-100, DISPLAYSURF.get_height()-100)), (0,0))

    pygame.display.update()

pygame.quit()
sys.exit()
