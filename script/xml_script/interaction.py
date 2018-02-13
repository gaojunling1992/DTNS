import xml.etree.ElementTree as ET
import sys
reload(sys)
sys.setdefaultencoding( "utf-8" )
tree = ET.parse('full_database.xml')
root = tree.getroot()

for child in root:
	for child1 in child.findall('{http://www.drugbank.ca}drugbank-id'):
		if child1.get('primary'):
			drug_id = child1.text
	for child2 in child.findall('{http://www.drugbank.ca}drug-interactions'):
		for child3 in child2.findall('{http://www.drugbank.ca}drug-interaction'):
			action_id = child3.find('{http://www.drugbank.ca}drugbank-id').text
			action_name = child3.find('{http://www.drugbank.ca}name').text
			action_description = child3.find('{http://www.drugbank.ca}description').text
			print drug_id+"\t"+action_id+"\t"+action_name+"\t"+action_description

