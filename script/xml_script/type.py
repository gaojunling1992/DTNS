import xml.etree.ElementTree as ET
tree = ET.parse('full_database.xml')
root = tree.getroot()

for child in root:
	updated = child.get('updated')
	created = child.get('created')
	type = child.get('type')
	for child2 in child.findall('{http://www.drugbank.ca}drugbank-id'):
		if child2.get('primary'):
			drug_id = child2.text
			print drug_id,created,updated,type

