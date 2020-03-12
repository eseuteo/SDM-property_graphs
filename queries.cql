// 1) Find the h-indexes of the authors in your graph (see
// https://en.wikipedia.org/wiki/H-index, for a definition of the h-index metric).

MATCH (a:Author)-[w:Writes]->(a:Article)<-[c:Cites]-(a2:Article)
WITH a.name AS author_name, a.name AS article_title, count(a2.name) AS num_citations
ORDER BY author_name, num_citations DESC
WITH author_name, collect(num_citations) AS citations
UNWIND range(0, size(citations)-1) AS position
    CASE
        WHEN citations[position] <= (position + 1)
            THEN citations[position]
            ELSE (position + 1)
    END AS journal_index
RETURN author_name, MAX(journal_index) AS h_index



// 2) Find the top 3 most cited papers of each conference. 

MATCH (:Article)-[c:cites]->(a:Article)-[:Presented_In]->(con:Conference_Workshop)
WHERE c.Type = "Conference"
ORDER BY count(c)
RETURN a
LIMIT 3


// 3) For each conference find its community: i.e., those authors that have
// published papers on that conference in, at least, 4 different editions. 

MATCH (au:Author)-[:writes]->(ar:Article)-[:published_in]->(c:Conference)
WHERE count(ar) >= 4
RETURN c, collect(au)


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
RETURN algo.getNodeById(node.Id).title AS page, score
ORDER BY score DESC
