class MetaInformationForTable(object):
    def __init__(self, table_name, cur):
        self.name = table_name
        self.name_and_type = self.get_columns_name_and_type_from_table(table_name, cur)
        self.pks = self.get_pk_from_table(table_name, cur)

    # attname   |      format_type
    # ----------+------------------------
    #  shop_id  | integer
    #  email    | character varying(255)
    #  name     | character varying(255)
    def get_columns_name_and_type_from_table(self, table_name, cur):
        schema_name = 'public.' + table_name
        sql = "SELECT a.attname, format_type(a.atttypid, a.atttypmod) " \
              "FROM   pg_attribute a " \
              "WHERE  a.attnum > 0 " \
              "AND    NOT a.attisdropped " \
              "AND    a.attrelid = %s::regclass; "
        cur.execute(sql, (schema_name,))
        return cur.fetchall()

    #  column_name | ordinal_position
    # -------------+------------------
    #  name        |                1
    #  email       |                2
    def get_pk_from_table(self, table_name, cur):
        sql = "SELECT kcu.column_name, kcu.ordinal_position " \
              "FROM   information_schema.table_constraints AS tc " \
              "JOIN   information_schema.key_column_usage AS kcu " \
              "ON     tc.constraint_name = kcu.constraint_name " \
              "WHERE  constraint_type = 'PRIMARY KEY' " \
              "AND    tc.table_name=%s;"
        cur.execute(sql, (table_name,))
        return cur.fetchall()