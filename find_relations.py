import re

# Read the Prisma schema file
with open("prisma/schema.prisma", "r") as file:
    schema = file.read()

# Split the schema into lines
lines = schema.split("\n")

# Initialize an empty list to hold the relations
relations = []

# Define the regular expression patterns
model_pattern = re.compile(r"model (\w+) {")
relation_pattern = re.compile(r"@relation\(fields: \[(\w+)\], references: \[(\w+)\]\)")

# Initialize variables
model_name = None
for line in lines:
    # If the line contains a model definition
    model_match = model_pattern.search(line)
    if model_match:
        model_name = model_match.group(1)

    # If the line contains a relation
    relation_match = relation_pattern.search(line)
    if relation_match and model_name:
        # Extract the foreign key and the parent model name
        foreign_key = relation_match.group(1)
        parent = relation_match.group(2)

        # Add the relation to the list
        relations.append(
            {"child": model_name, "parent": parent, "foreignKey": foreign_key}
        )

print(relations)
