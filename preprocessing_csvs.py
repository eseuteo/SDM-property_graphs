import pandas as pd
import numpy as np
import random
import re
import string

# Filtering articles file
articles = pd.read_csv('data/output/output_article.csv', sep=';', header=None, engine='c', dtype=str)
articles.columns = ["article:ID","author:string[]","author-aux:string","author-orcid:string[]","booktitle:string","cdate:date","cdrom:string","cite:string[]","cite-label:string[]","crossref:string","editor:string[]","editor-orcid:string","ee:string[]","ee-type:string[]","i:string[]","journal:string","key:string","mdate:date","month:string","note:string[]","note-type:string[]","number:string","pages:string","publisher:string","publtype:string","sub:string[]","sup:string[]","title:string","title-bibtex:string","tt:string[]","url:string","volume:string","year:int"]
articles_filtered = articles.filter(items=["article:ID","author:string[]","journal:string","mdate:date","month:string","number:string","pages:string","title:string","volume:string","year:int"])
articles_filtered['author:string[]'].replace('nan', np.nan, inplace=True)
articles_filtered = articles_filtered.dropna()
articles_filtered
articles_filtered.to_csv('articles.csv', index=False, sep=';')

# Loading authors
authors = pd.read_csv('data/output/output_author.csv', sep=';', engine='c', dtype=str)
print(authors)

# Obtaining a new df with the relationship "writes"
writes_relationship = pd.DataFrame([[authors.loc[authors['author:string'] == author], row['article:ID']] \
    for index, row in articles_filtered.iterrows() \
        for author in row['author:string[]'].split('|')])

writes_relationship.to_csv('writes_relationship.csv', header=[':START_ID',':END_ID'], sep=';', index=False)

# Randomly generating conferences based on conference names available in "Proceedings" csv
proceedings = pd.read_csv('data/output/output_proceedings.csv', sep=';', engine='c', header=None, dtype=str)
proceedings.columns = ["proceedings:ID","address:string","author:string","booktitle:string","cite:string[]","cite-label:string[]","editor:string[]","editor-orcid:string[]","ee:string[]","ee-type:string[]","i:string","isbn:string[]","isbn-type:string[]","journal:string","key:string","mdate:date","note:string[]","note-type:string","number:string","pages:string","publisher:string[]","publisher-href:string","publtype:string","series:string[]","series-href:string[]","sub:string","sup:string[]","title:string","url:string","volume:string","year:int"]
conference_info = proceedings['title:string']
conferences = [item for item in conference_info if len(item.split(',')) > 2]

conferences = [conference for conference in conferences if "conference" in conference.lower() or "symposium" in conference.lower() or "workshop" in conference.lower()]
conferences = [conference for conference in conferences if len(conference.split(',')) == 7]
conferences_df = pd.DataFrame([item.split(',') for item in conferences])
conferences_samples = conferences_df.sample(100)

conferences_names = [row.loc[0] for index, row in conferences_samples.iterrows()]
conferences_names = [re.sub('\d', '', item) for item in conferences_names]
conferences_names = [re.sub(' th ', '', item) for item in conferences_names]
conferences_names = [re.sub(' st ', '', item) for item in conferences_names]
conferences_names = [re.sub(' nd ', '', item) for item in conferences_names]
conferences_names = [re.sub('Proceedings of the ', '', item) for item in conferences_names]
conferences_names = [item.lstrip() for item in conferences_names]
df_conference_names = pd.DataFrame()
df_conference_names['name:string'] = conferences_names

ids = ['99345' + str(i).zfill(3) for i in range(100)]
df_conference_names['conference:ID'] = ids


