MATCH (:Article)-[r:Presented_In]->(:`Conference/Workshop`)
DELETE r

LOAD CSV WITH HEADERS FROM 'file:///presented_in_relationship.csv' as csvLine
FIELDTERMINATOR ';'
MATCH (a:Article),(cw:`Conference/Workshop`)
WHERE a.article = toInteger(csvLine.`:START_ID`) AND cw.conference = toInteger(csvLine.`:END_ID`)
CREATE (a)-[:Presented_In {venue: csvLine.`venue:string`, edition: csvLine.`edition:string`, period: csvLine.`period:string`}]->(cw)