#!/bin/bash

./bin/neo4j-admin import    --ignore-missing-nodes=true  \
                            --database=sdm-lab1  \
                            --delimiter ";"  \
                            --array-delimiter "|" \
                            --id-type=INTEGER  \
                            --nodes:Article="/home/ricardohb/Documents/SDM/SDM-property_graphs/data/data_to_populate/article_node.csv"  \
                            --nodes:Author="/home/ricardohb/Documents/SDM/SDM-property_graphs/data/data_to_populate/author_node.csv"  \
                            --nodes:Conference/Workshop="/home/ricardohb/Documents/SDM/SDM-property_graphs/data/data_to_populate/conference_workshop_node.csv" \
                            --nodes:Journal="/home/ricardohb/Documents/SDM/SDM-property_graphs/data/data_to_populate/journal_node.csv"  \
                            --nodes:Keyword="/home/ricardohb/Documents/SDM/SDM-property_graphs/data/data_to_populate/keyword_node.csv" \
                            --nodes:Review="/home/ricardohb/Documents/SDM/SDM-property_graphs/data/data_to_populate/review_node.csv" \
                            --nodes:Affiliation="/home/ricardohb/Documents/SDM/SDM-property_graphs/data/data_to_populate/affiliation_node.csv" \
                            --relationships:Cites="/home/ricardohb/Documents/SDM/SDM-property_graphs/data/data_to_populate/cites_relationship.csv" \
                            --relationships:Has_Keyword="/home/ricardohb/Documents/SDM/SDM-property_graphs/data/data_to_populate/has_keyword_relationship.csv"  \
                            --relationships:Presented_In="/home/ricardohb/Documents/SDM/SDM-property_graphs/data/data_to_populate/presented_in_relationship.csv" \
                            --relationships:Published_In="/home/ricardohb/Documents/SDM/SDM-property_graphs/data/data_to_populate/published_in_relationship.csv"  \
                            --relationships:Written_By="/home/ricardohb/Documents/SDM/SDM-property_graphs/data/data_to_populate/writes_relationship.csv" \
                            --relationships:Makes="/home/ricardohb/Documents/SDM/SDM-property_graphs/data/data_to_populate/makes_relationship.csv" \
                            --relationships:About="/home/ricardohb/Documents/SDM/SDM-property_graphs/data/data_to_populate/about_relationship.csv" \
                            --relationships:Belongs="/home/ricardohb/Documents/SDM/SDM-property_graphs/data/data_to_populate/belongs_relationship.csv"
