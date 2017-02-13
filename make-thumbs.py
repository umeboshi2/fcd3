import os, sys
import json
import subprocess

def resize_image(src, dest, size='1080x1920'):
    print "Resizing", src
    cmd = ['convert', '-resize', size, src, dest]
    #cmd = ['convert', '-thumbnail', src, dest]
    subprocess.check_call(cmd)

ml = json.load(file('phurls.json'))

#os.chdir('thumbs')
#for url in ml:
#    cmd = ['wget', url]
#    subprocess.check_call(cmd)

here = os.getcwd()
os.chdir('bpp')

new_thumbs = []
for url in ml:
    filename = os.path.basename(url)
    is_thumb = os.path.isfile(os.path.join('../thumbs', filename))
    if not is_thumb:
        print "filename is", filename
        print "Is thumb", is_thumb
        cmd = ['wget', url]
        subprocess.check_call(cmd)
        new_thumbs.append(filename)

os.chdir(here)

os.chdir('thumbs')
filenames = os.listdir('../bpp')
for fname in new_thumbs:
    src = os.path.join('../bpp', fname)
    dst = fname
    resize_image(src, dst, size='150x150')
    
os.chdir(here)
