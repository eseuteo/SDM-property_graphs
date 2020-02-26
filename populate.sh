#!/bin/bash

./bin/neo4j-admin import    --skip-bad-relationships=true  \
                            --database=dblp2  \
                            --delimiter ";"  \
                            --array-delimiter "|"  \
                            --id-type=INTEGER  \
                            --nodes=Author="path"  \
                            --nodes=Journal=""  \
                            --nodes=Article=""  \
                            --nodes=Conference-Workshop="path" \
                            --nodes=Keyword="path" \
                            --relationships=Cites="path" \
                            --relationships=Presented_In="path" \
                            --relationships=Writes="path" \
                            --relationships=Reviews="path" \
                            --relationships=Has="path"  \
                            --relationships=Published_In=""  \
