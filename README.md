# SDM-property_graphs
Repository for SDM Lab 1

test.py, helloworld.py and a2_instantiating.py contain just some code to try the python neo4j driver functionalities.

### A. Modeling, Loading, Evolving

#### A.1. Modeling
Modeling was done taking into account both the description provided and the queries that have to be done in section B.

![Schema](schema.jpeg)

#### A.2. Instantiating/Loading

In order to load the data in the graph database, first we needed the data. In order to obtain it, an xml file was downloaded from https://dblp.org/xml/release/, with its corresponding dtd file.

The files downloaded were:
- `dblp-2019-11-01.xml.gz` 
- `dblp-2017-08-29.dtd`

Once downloaded, we needed to generate csv files suitable to be loaded to the graph database. We made use of the script available here https://github.com/ThomHurks/dblp-to-csv

CSVs need preprocessing. Besides, information (instances) are missing for some of the nodes modelled in section A.1 (v.g.: reviewed_by, Keyword, has, cites, presented_in, Conference). Different approaches were followed for obtaining that data.
- reviewed_by --> randomly generated
- Keyword --> randomly generated
- has --> randomly generated
- cites --> randomly generated
- presented_in --> part of if obtained from `output_proceedings.csv`, part randomly generated
- Conference --> obtained from `output_proceedings.csv`

Once having the csvs, the bash script populate.sh will be used to load the data in the database.


