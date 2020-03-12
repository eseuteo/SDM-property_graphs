#!/bin/bash

./bin/neo4j-admin import    --skip-bad-relationships=true  \
                            --database=sdm-lab1  \
                            --delimiter ";"  \
                            --array-delimiter "|" \
                            --id-type=INTEGER  \
                            --nodes=Article="../data/article_node.csv"  \
                            --nodes=Author="../data/author_node.csv"  \
                            --nodes=Conference/Workshop="../data/conference_workshop_node.csv" \
                            --nodes=Journal="../data/journal_node.csv"  \
                            --nodes=Keyword="../data/keyword_node.csv" \
                            --relationships=Cites="../data/cites_relationship.csv" \
                            --relationships=Has_Keyword="../data/has_keyword_relationship.csv"  \
                            --relationships=Presented_In="../data/presented_in_relationship.csv" \
                            --relationships=Published_In="../data/published_in_relationship.csv"  \
                            --relationships=Reviews="../data/reviews_relationship.csv" \
                            --relationships=Writes="../data/writes_relationship.csv" \
