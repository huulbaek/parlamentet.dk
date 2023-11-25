import psycopg2

# Define the mapping of special characters
char_map = {"æ": "ae", "ø": "oe", "å": "aa"}

# Connect to your PostgreSQL database
conn = psycopg2.connect(
    dbname="oda",
    user="postgres",
    password="root",
    host="localhost",
    port="5432",
)
print("Connected to database")

# Create a cursor object
cur = conn.cursor()

# Fetch all table names
cur.execute(
    """
    SELECT table_name
    FROM information_schema.tables
"""
)
tables = cur.fetchall()

# Iterate over all tables
for table in tables:
    table = table[0]
    new_table = table
    for old_char, new_char in char_map.items():
        new_table = new_table.replace(old_char, new_char)

    # Rename table
    if new_table != table:
        print(f'Renamed table "{table}" to "{new_table}"')
        cur.execute(f'ALTER TABLE "{table}" RENAME TO "{new_table}"')

    # Fetch all column names
    cur.execute(
        f"""
        SELECT column_name
        FROM information_schema.columns
        WHERE table_name = '{new_table}'
    """
    )
    columns = cur.fetchall()

    # Iterate over all columns
    for column in columns:
        column = column[0]
        new_column = column
        for old_char, new_char in char_map.items():
            new_column = new_column.replace(old_char, new_char)

        # Rename column
        if new_column != column:
            print(f"Renamed column {column} to {new_column} in table {new_table}")
            cur.execute(
                f'ALTER TABLE "{new_table}" RENAME COLUMN {column} TO {new_column}'
            )

# Commit the changes and close the connection
conn.commit()
cur.close()
conn.close()
