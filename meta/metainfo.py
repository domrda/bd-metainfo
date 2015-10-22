import psycopg2
from tablemetainfo import MetaInformationForTable

class MetaInformation(object):
    def __init__(self, db):
        self.name = db
        conn = psycopg2.connect("dbname=" + db + " user=postgres")
        cur = conn.cursor()
        names_of_tables = self.get_tables_name(cur)
        self.tables = self.get_tables(cur, names_of_tables)
        self.relations = self.get_relations(cur)

    def get_tables_name(self, cur):
        sql = "SELECT table_name " \
              "FROM   information_schema.tables " \
              "WHERE  table_schema='public' " \
              "AND    table_type='BASE TABLE';"
        cur.execute(sql)
        return [item for sublist in cur.fetchall() for item in sublist]

    def get_tables(self, cur, names_of_tables):
        tables = []
        for name in names_of_tables:
            tables.append(MetaInformationForTable(name, cur))
        return tables

#   constraint_name   | table_name | column_name | foreign_table_name | foreign_column_name | ordinal_position
# --------------------+------------+-------------+--------------------+---------------------+------------------
#  table1_field1_fkey | table1     | field1      | table2             | field1              |                1
#  table1_field1_fkey | table1     | field2      | table2             | field2              |                2
#  table1_field3_fkey | table1     | field3      | table2             | field2              |                1
#  table1_field3_fkey | table1     | field4      | table2             | field3              |                2
    def get_relations(self, cur):
        sql = "SELECT   c.constraint_name, " \
              "         x.table_name, " \
              "         x.column_name, " \
              "         y.table_name                 AS  foreign_table_name, " \
              "         y.column_name                AS foreign_column_name, " \
              "         x.ordinal_position " \
              "FROM     information_schema.referential_constraints         c " \
              "JOIN     information_schema.key_column_usage                x " \
              "ON       x.constraint_name  =  c.constraint_name " \
              "JOIN     information_schema.key_column_usage                y " \
              "ON       y.ordinal_position = x.position_in_unique_constraint " \
              "AND      y.constraint_name  =  c.unique_constraint_name " \
              "ORDER BY c.constraint_name, x.ordinal_position; "
        cur.execute(sql)
        return cur.fetchall()