import psycopg2
from metainfo import MetaInformation

dbs = 'quest'
repo = 'repo'

# sql_prefix = 'select * from '
def find(sql_prefix, table1, table2):
    conn = psycopg2.connect("dbname=repo user=postgres")
    cur = conn.cursor()
    sql = sql_prefix + table1 + ' right join ' + table2 + ' on '
    cur.execute('SELECT   unique_name '
                'FROM     relations '
                'WHERE    tablea=%s AND tableb=%s '
                'OR       tableb=%s AND tablea=%s '
                'GROUP BY unique_name',
                (table1, table2, table2, table1))
    uniques = [item for sublist in cur.fetchall() for item in sublist]
    ons = []
    for key in uniques:
        cur.execute('SELECT   * '
                    'FROM     relations '
                    'WHERE    unique_name=%s ',
                    (key,))
        pairs = cur.fetchall()
        req = []
        for pair in pairs:
            req.append(pair[2] + '.' + pair[3] + '=' + pair[4] + '.' + pair[5])
        ons.append(req)
    conn = psycopg2.connect("dbname=quest user=postgres")
    cur = conn.cursor()
    for on in ons:
        req = sql + ' AND '.join(on)
        print req + ': '
        cur.execute(req, ())
        print cur.fetchall()
        print

sql_prefix = """select * from """
table1 = raw_input("Enter first table name: ")
table2 = raw_input("Enter second table name: ")
find(sql_prefix, table1, table2)