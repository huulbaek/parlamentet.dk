import xml.etree.ElementTree as ET

# Parse the XML file
tree = ET.parse('metadata.xml')
root = tree.getroot()

# XML namespaces
ns = {
    'edmx': 'http://schemas.microsoft.com/ado/2007/06/edmx',
    'edm': 'http://schemas.microsoft.com/ado/2009/11/edm'
}

# Helper function to convert EDM types to Prisma types
def edm_to_prisma_type(edm_type):
    return {
        'Edm.Int32': 'Int',
        'Edm.String': 'String',
        'Edm.Boolean': 'Boolean',
        'Edm.DateTime': 'DateTime'
    }.get(edm_type, 'String')  # Default to 'String' if type is unknown

# Helper function to get the primary key for an EntityType
def get_primary_key(entity_type):
    key = entity_type.find('edm:Key', ns)
    if key is not None:
        return key.find('edm:PropertyRef', ns).get('Name')
    return None

# Start of the Prisma schema
prisma_schema = """
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
  directUrl = env("DIRECT_URL")
}
"""

# Iterate over EntityTypes in the XML
for entity_type in root.findall(".//edm:EntityType", ns):
    model_name = entity_type.get('Name')
    primary_key = get_primary_key(entity_type)
    prisma_schema += f"\nmodel {model_name} {{\n"

    # Add primary key field
    if primary_key:
        prisma_schema += f"  {primary_key} Int @id @default(autoincrement())\n"

    # Iterate over properties of the EntityType
    for prop in entity_type.findall('edm:Property', ns):
        prop_name = prop.get('Name')
        if prop_name == primary_key:
            continue  # Skip primary key since it's already added
        prop_type = edm_to_prisma_type(prop.get('Type'))
        nullable = prop.get('Nullable', 'true') == 'true'
        prisma_schema += f"  {prop_name} {prop_type}{'?' if nullable else ''}\n"

    # Helper function to find association details by name
    def find_association(associations, name):
        for association in associations:
            if association.get('Name') == name:
                return association
        return None

    # Helper function to determine multiplicity and related type
    def get_association_details(association, role):
        for end in association.findall('edm:End', ns):
            if end.get('Role') == role:
                return end.get('Type').split('.')[-1], end.get('Multiplicity')
        return None, None

    # Get all Association elements for reference
    associations = root.findall(".//edm:Association", ns)

# Iterate over NavigationProperties for relations
    for nav_prop in entity_type.findall('edm:NavigationProperty', ns):
        rel_name = nav_prop.get('Name')
        relationship = nav_prop.get('Relationship').split('.')[-1]
        to_role = nav_prop.get('ToRole')
        from_role = nav_prop.get('FromRole')

        # Find the association details
        association = find_association(associations, relationship)
        if association is not None:
            related_type, multiplicity = get_association_details(association, to_role)

            # Determine the relation field and multiplicity in Prisma schema
            if multiplicity == '*':
                prisma_schema += f"  {rel_name} {related_type}[]\n"
            elif multiplicity == '0..1':
                prisma_schema += f"  {rel_name} {related_type}?\n"
            elif multiplicity == '1':
                prisma_schema += f"  {rel_name} {related_type}\n"
            else:
                # Handle other cases or throw an error
                pass


    prisma_schema += "}\n"

# Save the generated schema to a file
with open('schema_new.prisma', 'w') as file:
    file.write(prisma_schema)

print("Prisma schema generated successfully.")