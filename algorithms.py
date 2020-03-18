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

page_rank_query =   """
                    CALL algo.pageRank.stream('Article', 'Cites', {iterations:20, dampingFactor:0.85})
                    YIELD nodeId, score
                    RETURN algo.getNodeById(nodeId).title AS page, score
                    ORDER BY score DESC
                    """

louvain_query = """
                CALL algo.louvain.stream('Article', 'Cites')
                YIELD nodeId, community
                RETURN collect(algo.getNodeById(nodeId).title) AS Articles, community
                ORDER BY community
                """

page_rank_result = session.run(page_rank_query)
print("PageRank results: ")
print(page_rank_result.values())

louvain_result = session.run(louvain_query)
print("Louvain results: ")
print(louvain_result.values())