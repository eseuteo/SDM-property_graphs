# SDM-property_graphs
Repository for SDM Lab 1

test.py, helloworld.py and a2_instantiating.py contain just some code to try the python neo4j driver functionalities.

### A. Modeling, Loading, Evolving

#### A.1. Modeling
This section was done in paper

#### A.2. Instantiating/Loading
In order to load the data in the graph database, first we needed the data. In order to obtain it, an xml file was downloaded from https://dblp.org/xml/release/, with its corresponding dtd file.
The files downloaded were:
```dblp-2019-11-01.xml.gz
dblp-2017-08-29.dtd```
Once downloaded, we needed to generate csv files suitable to be loaded to the graph database. We made use of the script available here https://github.com/ThomHurks/dblp-to-csv

Once having the csvs, the bash script populate.sh will be used to load the data in the database.

