from neo4j import GraphDatabase

def getResearchCommunities(session, keywords_list):
    researchCommunitiesQuery =  """ 
                                MATCH (a:Article)-[h:Has_Keyword]->(k:Keyword)
                                WHERE k.keyword IN """ + str(keywords_list) + """ 
                                RETURN collect(distinct a.title) as Research_community 
                                """
    researchCommunities = session.run(researchCommunitiesQuery)
    return researchCommunities

def getCommunityConferencesAndJournals(session, keywords_list):
    communityConferencesAndJournalsQuery =  """ 
                                            MATCH (ar1:Article)-[:Presented_In]->(cw1:`Conference/Workshop`)
                                            WITH cw1.name as Conference, count(ar1) as NumOfArticles
                                            MATCH (kw:Keyword)<-[:Has_Keyword]-(ar2:Article)-[:Presented_In]->(cw2:`Conference/Workshop`)
                                            WHERE kw.keyword IN """ + str(keywords_list) + """ AND Conference = cw2.name
                                            WITH count(ar2) as NumOfRelatedArticles, Conference, NumOfArticles
                                            WHERE (toFloat(NumOfRelatedArticles)/toFloat(NumOfArticles)) > 0.89
                                            RETURN Conference
                                            """
    communityConferencesAndJournals = session.run(communityConferencesAndJournalsQuery)
    return communityConferencesAndJournals


def getTopPapers(session, articles_list):
    topPapersQuery =    """ 
                        CALL algo.pageRank.stream('Article', 'Cites', {iterations:20, dampingFactor:0.85})
                        YIELD nodeId, score
                        WITH algo.getNodeById(nodeId).title AS page, score
                        WHERE page IN """ + str(articles_list) + """
                        RETURN page, score
                        ORDER BY score DESC
                        LIMIT 100
                        """
    topPapers = session.run(topPapersQuery)
    return topPapers

def getGurus(session, top100articles_list):
    gurusQuery =    """
                    Match(au:Author)<-[w:Written_By]->(ar:Article) 
                    WHERE ar.title IN """ + str(top100articles_list) + """ 
                    WITH au.author as Author, count(w)>=2 as `Articles from top 100 written`
                    RETURN Author, `Articles from top 100 written`
                    """

driver = GraphDatabase.driver(
    uri="bolt://localhost:7687",
    encrypted = False, 
    max_connection_lifetime=30 * 60,
    max_connection_pool_size=150, 
    connection_acquisition_timeout=2 * 60,
    connection_timeout=3,
    max_retry_time=1)

keywords_list = [
    "data management", "indexing", "data modeling",
    "big data", "data processing", "data storage",
    "data querying"
]

session = driver.session()

# query 1
research_communities = getResearchCommunities(session, keywords_list)

community_articles_list = []
for article in research_communities:
    for value in article["Research_community"]:
        community_articles_list.append(value.encode('utf-8'))

# query 2
communities_conferences = getCommunityConferencesAndJournals(session, keywords_list)
communities_conferences = [item[0] for item in communities_conferences.values()]

# query 3
top_100_papers = getTopPapers(session, community_articles_list)
print(top_100_papers)

# query 4
gurus = getGurus(session, top_100_papers)
