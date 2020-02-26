from xml.etree import ElementTree
import os
import csv

xml_file = open('dblp.xml')
tree = ElementTree.parse(xml_file)

bulk_data = open('bulk_data.csv', 'w', newline='\n', encoding='utf-8')
csvwriter = csv.writer(bulk_data)

root = tree.getroot()

for author_data in root.findall('author'):
    print(author_data)