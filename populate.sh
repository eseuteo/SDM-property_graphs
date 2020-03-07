#!/bin/bash

./bin/neo4j-admin import    --skip-bad-relationships=true  \
                            --database=sdm-lab1  \
                            --delimiter ";"  \
                            --array-delimiter "|" \
                            --id-type=INTEGER  \
                            --nodes=Article="<path-to-folder>/article_node.csv"  \
                            --nodes=Author="<path-to-folder>/author_node.csv"  \
                            --nodes=Conference/Workshop="<path-to-folder>/conference_workshop_node.csv" \
                            --nodes=Journal="<path-to-folder>/journal_node.csv"  \
                            --nodes=Keyword="<path-to-folder>/keyword_node.csv" \
                            --relationships=Cites="<path-to-folder>/cites_relationship.csv" \
                            --relationships=Has_Keyword="<path-to-folder>/has_keyword_relationship.csv"  \
                            --relationships=Presented_In="<path-to-folder>/presented_in_relationship.csv" \
                            --relationships=Published_In="<path-to-folder>/published_in_relationship.csv"  \
                            --relationships=Reviews="<path-to-folder>/reviews_relationship.csv" \
                            --relationships=Writes="<path-to-folder>/writes_relationship.csv" \
