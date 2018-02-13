import xml.etree.ElementTree as ET
import sys
reload(sys)
sys.setdefaultencoding( "utf-8" )
tree = ET.parse('full_database.xml')
root = tree.getroot()

for child in root:
	drug_id=''
	groups=[]
	for child2 in child.findall('{http://www.drugbank.ca}drugbank-id'):
		if child2.get('primary'):
			drug_id = child2.text
			for child2 in child.findall('{http://www.drugbank.ca}categories'):
				for child3 in child2.findall('{http://www.drugbank.ca}category'):
					category = child3.find('{http://www.drugbank.ca}category').text
					category_id = child3.find('{http://www.drugbank.ca}mesh-id').text
					print drug_id,category_id,category

