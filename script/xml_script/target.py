import xml.etree.ElementTree as ET
tree = ET.parse('full_database.xml')
root = tree.getroot()

for child in root:
	drug_id=''
	groups=[]
	for child2 in child.findall('{http://www.drugbank.ca}drugbank-id'):
		if child2.get('primary'):
			drug_id = child2.text
			for child2 in child.findall('{http://www.drugbank.ca}targets'):
				for child3 in child2.findall('{http://www.drugbank.ca}target'):
					for child4 in child3.findall('{http://www.drugbank.ca}polypeptide'):
						target = child4.get('id')
						print drug_id,target

