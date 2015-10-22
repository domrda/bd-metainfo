import psycopg2
from metainfo import MetaInformation

# dbs = ['bd', 'bd2']
dbs = ['quest']
repo = 'repo'
conn = psycopg2.connect("dbname=repo user=postgres")
cur = conn.cursor()
cur.execute("delete from bd")

for db in dbs:
    print db
    database_meta = MetaInformation(db)
    for table_meta in database_meta.tables:
        for (name, type) in table_meta.name_and_type:
            cur.execute("INSERT INTO bd (database_name, table_name, attr_name, attr_type) "
                        "VALUES(%s, %s, %s, %s)",
                        (database_meta.name, table_meta.name, name, type))
        for (name, pos) in table_meta.pks:
            cur.execute("UPDATE bd SET is_pk=%s, pos=%s "
                        "WHERE database_name=%s AND "
                        "table_name=%s AND "
                        "attr_name=%s",
                        (True, pos, database_meta.name, table_meta.name, name))
    for record in database_meta.relations:
        cur.execute("INSERT INTO relations (unique_name, tableA, fieldA, tableB, fieldB, pos) "
                    "VALUES (%s, %s, %s, %s, %s, %s)",
                    record)
        conn.commit()