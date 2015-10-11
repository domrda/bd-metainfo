import psycopg2
from tablemetainfo import MetaInformationForTable

class MetaInformation(object):
    def __init__(self, db):
        self.name = db
        conn = psycopg2.connect("dbname=" + db + " user=postgres")
        cur = conn.cursor()
        names_of_tables = self.get_tables_name(cur)
        self.tables = self.get_tables(cur, names_of_tables)

    def get_tables_name(self, cur):
        sql = "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_type='BASE TABLE';"
        cur.execute(sql)
        return [item for sublist in cur.fetchall() for item in sublist]

    def get_tables(self, cur, names_of_tables):
        tables = []
        for name in names_of_tables:
            tables.append(MetaInformationForTable(name, cur))
        return tables
