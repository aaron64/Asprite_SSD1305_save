## SSD1305 Save Plugin for Aseprite

This is a plug in to save 1-bit images and animations as my custom hex file type for use in a SSD1305 OLED controller.

### Installation
Simply clone this repo in ~/.config/aseprite/scripts/

### How to use
Create an image with width and height < 256, set the color mode to grayscale. Any pixels with a value > 128 will be considered on and < 128 will be off. Then go to file -> scripts -> SSD1305_save and save the file where you want it.

Note: This filetype is my own implementation so don't expect the image to do much on any other software.

### Filetype
The file is a simple hex file with the following data layout:
0:     file type version (currently 0)
1:     image width
2:     image height
3:     number of frames
4-end: image data
