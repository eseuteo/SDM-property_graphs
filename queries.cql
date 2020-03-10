// 1) Find the h-indexes of the authors in your graph (see
// https://en.wikipedia.org/wiki/H-index, for a definition of the h-index metric).

MATCH (a:Article)


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

