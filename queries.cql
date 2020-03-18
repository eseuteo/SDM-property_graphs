// 1) Find the h-indexes of the authors in your graph (see
// https://en.wikipedia.org/wiki/H-index, for a definition of the h-index metric).

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

// 2) Find the top 3 most cited papers of each conference. 

MATCH ()-[c:Cites]->(a:Article)-[:Presented_In]->(cw:`Conference/Workshop`)
WITH cw.name as ConferenceName, a as Article, count(c) as ArticleCitations
ORDER BY ConferenceName, ArticleCitations DESC
WITH ConferenceName, collect(Article.title)[0..3] as MostCitedArticles, collect(ArticleCitations)[0..3] as NumberOfCitations
RETURN ConferenceName, MostCitedArticles, NumberOfCitations


// 3) For each conference find its community: i.e., those authors that have
// published papers on that conference in, at least, 4 different editions. 

MATCH (au:Author)<-[w:Writes]-(ar:Article)-[p:Presented_In]->(cw:`Conference/Workshop`)
WITH cw.name as ConferenceName, p.edition as ConferenceEdition, au.author as Author
WITH ConferenceName, collect(distinct ConferenceEdition) as Editions, Author
WHERE size(Editions) >= 4
RETURN ConferenceName, collect(Author)


// 4) Find the impact factors of the journals in your graph (see
// https://en.wikipedia.org/wiki/Impact_factor, for the definition of the impact
// factor).

MATCH (j:Journal)<-[p:Published_In]-(a1:Article)<-[c:Cites]-(a2:Article)
WITH j.name AS journal_name, p.year AS journal_year, count(a2.name) AS citations, count(p) AS num_articles
WHERE journal_year IN [(date().year-1), (date().year-2)]
RETURN journal_name, sum(citations)/sum(num_articles) AS impact_factor
ORDER BY impact_factor DESC


// Algorithms
//
// PageRank

CALL algo.pageRank.stream('Article', 'Cites', {iterations:20, dampingFactor:0.85})
YIELD nodeId, score
RETURN algo.getNodeById(nodeId).title AS page, score
ORDER BY score DESC


// Recommender
//
// 1) The first thing to do is to find/define the research communities. A community is
// defined by a set of keywords. Assume that the database community is defined through
// the following keywords: data management, indexing, data modeling, big data, data
// processing, data storage and data querying.

MATCH (a:Article)-[h:Has_Keyword]->(k:Keyword)
WHERE k.name IN ["data management", "indexing", "indexing", data modeling", "big data", "data processing", "data storage", "data querying"]
RETURN collect(distinct a.title) as Research_community



// 3) Next, we want to identify the top papers of these conferences/journals. We need to
// find the papers with the highest page rank provided the number of citations from the
// papers of the same community (papers in the conferences/journals of the database
// community). As a result we would obtain (highlight), say, the top-100 papers of the
// conferences of the database community.

CALL algo.pageRank.stream('Article', 'Cites', {iterations:20, dampingFactor:0.85})
YIELD nodeId, score
WITH algo.getNodeById(nodeId).title AS page, score
WHERE page IN [$community_conference] // RESULT FROM 2nd query
RETURN page, score
ORDER BY score DESC
LIMIT 100










