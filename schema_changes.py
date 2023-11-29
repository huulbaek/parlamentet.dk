# Open both files
with open("prisma/schema.prisma", "r") as schema_file, open(
    "prisma/schema_odaclient.prisma", "r"
) as odaclient_file:
    schema_lines = schema_file.readlines()
    odaclient_lines = odaclient_file.readlines()

# Create a new list to store the updated schema lines
updated_schema_lines = []

# Create a list to store the model names in the schema file
schema_model_names = [
    line.split()[1].lower() for line in schema_lines if line.startswith("model")
]

# Iterate over the lines in the schema file
for i in range(len(schema_lines)):
    # If the line starts with 'model', it's a model definition
    if schema_lines[i].startswith("model"):
        # Split the line into words
        words = schema_lines[i].split()

        # The second word is the model name
        model_name = words[1]

        # Find the corresponding line in the odaclient file
        for j in range(len(odaclient_lines)):
            if (
                odaclient_lines[j].startswith("model")
                and odaclient_lines[j].split()[1].lower() == model_name.lower()
            ):
                # The model name in the odaclient file is the capitalized version
                capitalized_model_name = odaclient_lines[j].split()[1]

                # Replace the model name in the schema file with the capitalized version
                updated_line = schema_lines[i].replace(
                    model_name, capitalized_model_name
                )

                # Add the @@map attribute to map the capitalized model name to the original table name
                updated_line += f'  @@map("{model_name}")\n'

                # Add the relations from the odaclient file to the schema file
                k = j + 1
                while (
                    not odaclient_lines[k].startswith("model")
                    and k < len(odaclient_lines) - 1
                ):
                    if odaclient_lines[k].strip().endswith("[]"):
                        updated_line += "  " + odaclient_lines[k].strip() + "\n"
                    k += 1

                # Add the updated line to the new list
                updated_schema_lines.append(updated_line)
                break
    else:
        # If the line does not start with 'model', add it to the new list as is
        updated_schema_lines.append(schema_lines[i])

# Write the updated lines to a new file
with open("prisma/merged.prisma", "w") as schema_file:
    schema_file.writelines(updated_schema_lines)
