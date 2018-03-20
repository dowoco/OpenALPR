# OpenALPR
Automatic Number Plate Recognition related scripts for OpenALPR


install_OpenALPR_on_Pi.sh

This will install a working copy of OpenALPR with all its dependancies. It takes a long time for this to build all the source code.
I have built this on a the "2017-11-29-raspbian-stretch-lite" image and all wored fine.
This uses the newest version of the dependancies I could get to comile together.
leptonica-1.75.3, Tesseract-3.05.00 and OpenCV-3.4.0


show_plate_on_Pi_TFT.py

This also takes advantage of an installed camara to take pictures, processes them and display then on the TFT. The screen I have is a TFT screen attached to the GPIO pins. This code uses pyGame library to position the picture and recognised license plates. This code is not finished and in its RAW format. So use it with care and it may still have some bugs. You will need to create the following directory to hold you temporary picture from the camara that is being processed "/home/pi/alpr/images"


OpenALPR_on_Debian_Image.sh

Because the raspberry Pi was taking a very long time to comile and build the software. I created a Debian 8 VirtualBox image and tested my install scripts to speed tings up. This new script which I have not ported over to the PI has the newset version the "ffmpeg" library. This means the image processeing from a RSTP source is better. I also found the "ffmpeg" library that comes with OpenCV kept crashing when processing large streams. So this image has the leptonica-1.75.3, Tesseract-3.05.00 and OpenCV-3.4.0 plus ffmpeg-7:3.4.2-1

setup_debian_image.sh

I use this script to setup the Debian image to take advantage of any Backports I many need. It also runs the update and upgrade.
