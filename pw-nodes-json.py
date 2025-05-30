#!/usr/bin/env python3
import json
import subprocess
from subprocess import STDOUT

def run_pwcli():
    """run pw-cli to get nodes"""
    output = subprocess.check_output(["pw-cli", "ls", "Node"], stderr=STDOUT)
    return output

def parse_nodes(nodes_raw):
    nodes_lines = nodes_raw.decode().split("\n")

    nodes_list = []
    curr_node = []
    for line in nodes_lines:
        if "type PipeWire:" in line:
            if len(curr_node) > 0:
                nodes_list.append(curr_node)
            curr_node = [line]
        else:
            curr_node.append(line)
    nodes_list.append(curr_node)

    res_dict = {}
    for node in nodes_list:
        id_line = node[0]
        node_id = id_line.split(",")[0].split(" ")[1]
        res_dict[node_id] = {}
        for item in node[1:]:
            if "=" in item:
                label = item.split("=")[0].strip()
                value = item.split("=")[1].strip().strip('"')
                res_dict[node_id][label] = value
    return res_dict

if __name__ == "__main__":
    raw_nodes = run_pwcli()
    res = parse_nodes(raw_nodes)
    print(f"nodes found: {len(res)}")
    print(json.dumps(res, indent=4))
