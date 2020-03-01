from base64 import b64decode, b64encode, decodestring




encoded_img = open('encoded.txt','rb').read()
print(encoded_img)

imgdata = b64decode(encoded_img + "=====")
filename = 'some_image.jpg'  # I assume you have a way of picking unique filenames
with open(filename, 'wb') as f:
        f.write(imgdata)
