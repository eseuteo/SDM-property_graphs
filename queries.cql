// 1) Find the h-indexes of the authors in your graph (see
// https://en.wikipedia.org/wiki/H-index, for a definition of the h-index metric).

MATCH (a:Author)-[w:Writes]->(a:Article)<-[c:Cites]-(a2:Article)
WITH a.name AS author_name, a.name AS article_title, count(c) AS num_citations
ORDER BY author_name, num_citations DESC
WITH author_name, collect(num_citations) AS citations
[i ]
UNWIND range(0, size(citations)-1) AS citations_size WITH author_name,
    CASE
        WHEN citations[citations_size] <= (citations_size + 1)
            THEN citations[citations_size] 
            ELSE (citations_size + 1)
    END AS journal_index
RETURN author_name, MAX(journal_index) AS h_index



// 2) Find the top 3 most cited papers of each conference. 

MATCH ()-[c:Cites]->(a:Article)-[:Presented_In]->(cw:`Conference/Workshop`)
WITH cw.name as ConferenceName, a.title as ArticleTitle, count(c) as ArticleCitations
ORDER BY ConferenceName, ArticleCitations DESC
WITH ConferenceName, collect(ArticleTitle)[0..3] as MostCitedArticles
RETURN ConferenceName, MostCitedArticles


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
WITH j.journal AS journal_name, p.year AS journal_year, count(a2) AS citations, count(p) AS num_articles
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










