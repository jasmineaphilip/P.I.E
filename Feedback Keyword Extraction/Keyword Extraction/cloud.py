from os import path
from wordcloud import WordCloud
import matplotlib.pyplot as plt

text = open(path.join('samplecloud.txt')).read()

wordcloud = WordCloud().generate(text)

plt.imshow(wordcloud)

plt.axis("off")

plt.show()
