import pandas as pd
import numpy as np

# Filtering articles file
articles = pd.read_csv('data/output/output_article.csv', sep=';', header=None, engine='c', dtype=str)
articles.columns = ["article:ID","author:string[]","author-aux:string","author-orcid:string[]","booktitle:string","cdate:date","cdrom:string","cite:string[]","cite-label:string[]","crossref:string","editor:string[]","editor-orcid:string","ee:string[]","ee-type:string[]","i:string[]","journal:string","key:string","mdate:date","month:string","note:string[]","note-type:string[]","number:string","pages:string","publisher:string","publtype:string","sub:string[]","sup:string[]","title:string","title-bibtex:string","tt:string[]","url:string","volume:string","year:int"]
articles_filtered = articles.filter(items=["article:ID","author:string[]","journal:string","mdate:date","month:string","number:string","pages:string","title:string","volume:string","year:int"])
articles_filtered['author:string[]'].replace('nan', np.nan, inplace=True)
articles_filtered = articles_filtered.dropna()
articles_filtered
articles_filtered.to_csv('articles.csv', index=False, sep=';')

# Loading authors
# authors = pd.read_csv('data/output/output_author.csv', sep=';', engine='c', dtype=str)
# print(authors)

# Obtaining a new df with the relationship "writes"
# writes_relationship = pd.DataFrame([[authors.loc[authors['author:string'] == author], row['article:ID']] \
#     for index, row in articles_filtered.iterrows() \
#         for author in row['author:string[]'].split('|')])

# writes_relationship.to_csv('writes_relationship.csv', header=[':START_ID',':END_ID'], sep=';', index=False)



articles = pd.read_csv('articles.csv', sep=';', header=True, engine='c', dtype=str)
article_published_in_journal = pd.read_csv('data/output/output_journal_published_in.csv', sep=';', header=True, engine='c', dtype=str)
articles_volume = []
articles_year = []
for index, row in articles.iterrows():
    
articles_filtered = articles.filter(items=["article:ID","mdate:date","month:string","number:string","pages:string","title:string","volume:string","year:int"])
