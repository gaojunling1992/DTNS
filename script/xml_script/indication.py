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
			for child2 in child.findall('{http://www.drugbank.ca}indication'):
					indication = child2.text
					print drug_id,indication

