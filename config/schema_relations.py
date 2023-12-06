# Open both files
with open("prisma/schema.prisma", "r") as schema_file, open(
    "./schema_odaclient.prisma", "r"
) as odaclient_file:
    schema_lines = schema_file.readlines()
    odaclient_lines = odaclient_file.readlines()

# Create a new list to store the updated schema lines
updated_schema_lines = []

# Create a dictionary to store the relations from the odaclient file
relations = {}
model_names = {}
model_contents = {}

# Extract the relations and model names from the odaclient file
inside_model = False
for line in odaclient_lines:
    if line.startswith("model"):
        model_name = line.split()[1]
        relations[model_name] = []
        model_names[model_name.lower()] = model_name  # Store the original model name
        model_contents[model_name] = []
        inside_model = True
    elif line.strip() == "}":
        inside_model = False
    elif inside_model:
        model_contents[model_name].append(line.strip())

inside_model = False
# Iterate over the lines in the schema file
for i in range(len(schema_lines)):
    # If the line starts with 'model', it's a model definition
    if schema_lines[i].startswith("model"):
        # Split the line into words
        words = schema_lines[i].split()

        # The second word is the model name
        model_name = words[1]
        original_model_name = model_name

        # If the model name exists in the odaclient file, use it
        if model_name.lower() in model_names:
            original_model_name = model_name
            model_name = model_names[model_name.lower()]

        # Add the updated line to the new list
        updated_schema_lines.append(" ".join([words[0], model_name] + words[2:]) + "\n")

        if original_model_name != model_name:
            # Add the @@map directive to map the model to the original table name
            updated_schema_lines.append(f'  @@map("{original_model_name}")\n')

        if model_name in model_contents:
            # Add the model contents from the odaclient file
            for line in model_contents[model_name]:
                updated_schema_lines.append("  " + line + "\n")

        # If the model has relations defined in the odaclient file, add them
        if model_name in relations:
            for relation in relations[model_name]:
                updated_schema_lines.append("  " + relation + "\n")

    else:
        # If the line does not start with 'model', add it to the new list as is
        updated_schema_lines.append(schema_lines[i])

# Write the updated lines back to the schema file
with open("prisma/schema.prisma", "w") as schema_file:
    schema_file.writelines(updated_schema_lines)
