from os import walk
import json

def update_timestamp (trace_file):
  absolute_path=path+"/"+trace_file
  file = open(absolute_path)
  data = json.load(file)

  nos=len(data["data"][0]["spans"])
  startTime = 1

  for span in range(nos):
    data["data"][0]["spans"][span]["startTime"]=startTime

  json_object = json.dumps(data, indent = 4)
  with open(absolute_path, "w") as outfile:
    outfile.write(json_object)


if __name__ == "__main__":
  path = "./src/main/resources/traces"
  trace_file_list = []
  for (dirpath, dirnames, filenames) in walk(path):
    trace_file_list = filenames
  for trace_file in trace_file_list:
    update_timestamp(trace_file)
    break