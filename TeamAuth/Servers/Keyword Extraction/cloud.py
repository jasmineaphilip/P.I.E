from os import path
from wordcloud import WordCloud
import matplotlib.pyplot as plt

text = open(path.join('samplephrases.txt')).read()

wordcloud = WordCloud().generate(text)

wordcloud.to_file('wordcloud.jpg')

plt.imshow(wordcloud)

plt.axis("off")

plt.show()
