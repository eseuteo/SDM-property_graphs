#!/bin/bash

./bin/neo4j-admin import    --skip-bad-relationships=true  \
                            --database=dblp2  \
                            --delimiter ";"  \
                            --array-delimiter "|"  \
                            --id-type=INTEGER  \
                            --nodes=Author="output_author.csv"  \
                            --nodes=Article="/Users/irinanazarchuk/Documents/uni/SDM/output_/output_article_header.csv, /Users/irinanazarchuk/Documents/uni/SDM/output_/output_article.csv"  \
                            --nodes=Conference-Workshop="path" \
                            --nodes=Keyword="path" \
                            --nodes=Topic="path" \
                            --nodes=Editor="output_editor.csv" \
                            --relationships=Cites="path" \
                            --relationships=Presented_In="path" \
                            --relationships=Writes="output_author_authored_by.csv" \
                            --relationships=Reviews="path" \
                            --relationships=Has="path"  \
                            --relationships=Published_In=""  \
                            --relationships=Relates_To=""  \
                            --relationships=Edited_By="output_editor_edited_by.csv"  \
