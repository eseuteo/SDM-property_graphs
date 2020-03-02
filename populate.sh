#!/bin/bash

./bin/neo4j-admin import    --skip-bad-relationships=true  \
                            --database=dblp2  \
                            --delimiter ";"  \
                            --array-delimiter "|"  \
                            --id-type=INTEGER  \
                            --nodes=Author="/home/ricardohb/Documents/SDM/SDM-property_graphs/data/output_author.csv"  \
                            --nodes=Journal=""  \
                            --nodes=Article="/home/ricardohb/Documents/SDM/SDM-property_graphs/data/output_article_header.csv,/home/ricardohb/Documents/SDM/SDM-property_graphs/data/output_article.csv"  \
                            --nodes=Conference-Workshop="path" \
                            --nodes=Keyword="path" \
                            --relationships=Cites="path" \
                            --relationships=Presented_In="path" \
                            --relationships=Writes="path" \
                            --relationships=Reviews="path" \
                            --relationships=Has="path"  \
                            --relationships=Published_In=""  \
