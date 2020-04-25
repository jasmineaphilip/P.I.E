from rake_nltk import Rake
from os import path
import sys

#uses stopwords for english from NLTK, and all punctuation characters
r = Rake()

r.extract_keywords_from_text(open(path.join(sys.argv[1])).read())

#To get keyword phrases ranked highest to lowest
print(r.get_ranked_phrases())