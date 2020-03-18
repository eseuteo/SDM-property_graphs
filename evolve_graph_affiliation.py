import universities
import random
from neo4j import GraphDatabase

uni = universities.API()
all_universities = uni.get_all()
universities_list = list(all_universities)
reduced_list = [random.choice(universities_list) for i in range(200)]
names_list = [item.name for item in reduced_list]

driver = GraphDatabase.driver(
    uri="bolt://localhost:7687",
    encrypted = False, 
    max_connection_lifetime=30 * 60,
    max_connection_pool_size=150, 
    connection_acquisition_timeout=2 * 60,
    connection_timeout=3,
    max_retry_time=1)

session = driver.session()

cqlAuthorsQuery          = "MATCH (a:Author) RETURN a"
result = session.run(cqlAuthorsQuery)
print("Finished query")

for item in result.values():
    author = item[0]["author"]
    cqlAffiliationQuery =   "MATCH (a:Author) WHERE a.author = \"" + author + "\" SET a.affiliation = \"" + random.choice(names_list) + "\""
    session.run(cqlAffiliationQuery)
