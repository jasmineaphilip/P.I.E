from os import path
from wordcloud import WordCloud
import matplotlib.pyplot as plt
from base64 import b64decode, b64encode

text = open(path.join('samplecloud.txt')).read()

wordcloud = WordCloud().generate(text)

wordcloud.to_file('wordcloud.jpg')

plt.imshow(wordcloud)

plt.axis("off")

plt.show()
