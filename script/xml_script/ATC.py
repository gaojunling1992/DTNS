import xml.etree.ElementTree as ET
import sys
reload(sys)
sys.setdefaultencoding( "utf-8" )
tree = ET.parse('full_database.xml')
root = tree.getroot()

for child in root:
	for child2 in child.findall('{http://www.drugbank.ca}drugbank-id'):
		if child2.get('primary'):
			drug_id = child2.text
	for child3 in child.findall('{http://www.drugbank.ca}atc-codes'):
		for child4 in child3.findall('{http://www.drugbank.ca}atc-code'):
			drug_code = child4.get('code')
			for child5 in child4.findall('{http://www.drugbank.ca}level'):
				aaa=child5.get('code')
				bbb=child5.text
				print drug_id+"\t"+drug_code+"\t"+aaa+"\t"+bbb


