from neo4j import GraphDatabase

driver = GraphDatabase.driver(
    uri="bolt://localhost:7687",
    encrypted = False, 
    max_connection_lifetime=30 * 60,
    max_connection_pool_size=150, 
    connection_acquisition_timeout=2 * 60,
    connection_timeout=3,
    max_retry_time=1)

session = driver.session()
# 1) Find the h-indexes of the authors in your graph (see
# https://en.wikipedia.org/wiki/H-index, for a definition of the h-index metric).

query_1 = """
MATCH (au:Author)<-[:Written_By]-(ar1:Article)<-[:Cites]-(ar2:Article)
WITH au.author as Author, ar1.title as Article, count(ar2) as Citations
ORDER BY Citations DESC
WITH Author, collect(Citations) as Citations
UNWIND range(0, size(Citations)-1) as citations_size WITH Author,
CASE WHEN Citations[citations_size] <= (citations_size + 1)
    THEN Citations[citations_size]
    ELSE (citations_size + 1)
END as journal_index
RETURN Author, MAX(journal_index) as `H-Index`
"""

# 2) Find the top 3 most cited papers of each conference. 

query_2 = """
MATCH ()-[c:Cites]->(a:Article)-[:Presented_In]->(cw:`Conference/Workshop`)
WITH cw.name as ConferenceName, a as Article, count(c) as ArticleCitations
ORDER BY ConferenceName, ArticleCitations DESC
WITH ConferenceName, collect(Article.title)[0..3] as MostCitedArticles, collect(ArticleCitations)[0..3] as NumberOfCitations
RETURN ConferenceName, MostCitedArticles, NumberOfCitations
"""


# 3) For each conference find its community: i.e., those authors that have
# published papers on that conference in, at least, 4 different editions. 

query_3 = """
MATCH (au:Author)<-[w:Writes]-(ar:Article)-[p:Presented_In]->(cw:`Conference/Workshop`)
WITH cw.name as ConferenceName, p.edition as ConferenceEdition, au.author as Author
WITH ConferenceName, collect(distinct ConferenceEdition) as Editions, Author
WHERE size(Editions) >= 4
RETURN ConferenceName, collect(Author)
"""


# 4) Find the impact factors of the journals in your graph (see
# https://en.wikipedia.org/wiki/Impact_factor, for the definition of the impact
# factor).

query_4 = """
MATCH (j:Journal)<-[p:Published_In]-(a1:Article)<-[c:Cites]-(a2:Article)
WITH j.journal AS journal_name, p.year AS journal_year, count(a2) AS citations, count(p) AS num_articles
WHERE journal_year IN [(date().year-1), (date().year-2)]
RETURN journal_name, sum(citations)/sum(num_articles) AS impact_factor
ORDER BY impact_factor DESC
"""

result_query_1 = session.run(query_1)
print(result_query_1.values())

result_query_2 = session.run(query_2)
print(result_query_2.values())

result_query_3 = session.run(query_3)
print(result_query_2.values())

result_query_4 = session.run(query_4)
print(result_query_4.values())