#!/bin/bash

./bin/neo4j-admin import    --ignore-missing-nodes=true  \
                            --database=sdm-lab1  \
                            --delimiter ";"  \
                            --array-delimiter "|" \
                            --id-type=INTEGER  \
                            --nodes:Article="$data_path/article_node.csv"  \
                            --nodes:Author="$data_path/author_node.csv"  \
                            --nodes:Conference/Workshop="$data_path/conference_workshop_node.csv" \
                            --nodes:Journal="$data_path/journal_node.csv"  \
                            --nodes:Keyword="$data_path/keyword_node.csv" \
                            --nodes:Review="$data_path/review_node.csv" \
                            --nodes:Affiliation="$data_path/affiliation_node.csv" \
                            --relationships:Cites="$data_path/cites_relationship.csv" \
                            --relationships:Has_Keyword="$data_path/has_keyword_relationship.csv"  \
                            --relationships:Presented_In="$data_path/presented_in_relationship.csv" \
                            --relationships:Published_In="$data_path/published_in_relationship.csv"  \
                            --relationships:Reviews="$data_path/reviews_relationship.csv" \
                            --relationships:Written_By="$data_path/writes_relationship.csv" \
                            --relationships:Makes="$data_path/makes_relationship.csv" \
                            --relationships:About="$data_path/about_relationship.csv" \
                            --relationships:Belongs="$data_path/belongs_relationship.csv"
