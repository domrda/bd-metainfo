import tablemetainfo
import pygraphviz as pgv
from PIL import Image


def make_table_string(table_name, table_columns_triples):
    table_string = "<<TABLE BORDER=\"1\" CELLBORDER=\"0\" CELLSPACING=\"1\"> \
<TR><TD colspan=\"2\" BGCOLOR=\"lightgray\">" + table_name + "</TD></TR>"
    for triple in table_columns_triples:
        table_string = table_string + "<TR><TD PORT=\"" + triple[0] + "\">" + triple[0] + "</TD><TD> " + triple[1] + "</TD></TR>"
    table_string += "</TABLE>>"
    return table_string


def make_relation_string():
    pass


def create_graph(table_structs):
    G = pgv.AGraph(name='BD', rankdir="LR")
    G.node_attr['shape']='plaintext'
    for (table_name, columns, relations) in table_structs:
        label = make_table_string(table_name, columns)
        G.add_node(table_name, label=label)
    for (table_name, columns, relations) in table_structs:
        for (p_table_name, p_column_name, f_table_name, f_column_name) in relations:
            G.add_edge(p_table_name, f_table_name, tailport=p_column_name, headport=f_column_name)
    G.layout('dot')
    G.write('out.txt')
    G.draw('bd.png')
    Image.open("bd.png").show()

create_graph(tablemetainfo.collect_meta_information_from_db('bd'))