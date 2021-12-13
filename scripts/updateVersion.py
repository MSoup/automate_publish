#!/usr/bin/env python

import re
import sys

# fileName should be the absolute path of the yaml you wish to edit
def writeNewVersion(fileName):
  f = open(fileName, mode='rt') 

  data = f.read()
  p = "(version: )(\d+.\d+.\d+.)(\d+)"

  result = re.search(p,data)

  try: 
    type(result[0]) == str
  except:
    print("Fatal error: version: #.#.#+XX Not found in pubspec")
    exit(1)

  versionPlusOne = str(int(result.group(3)) + 1)

  f.close()

  f = open(fileName, "wt")
  data = data.replace(result[0], result.group(1) + result.group(2) + versionPlusOne)
  
  f.write(data)

  f.close()

  print("Before", result[0])
  print("After", result.group(1) + result.group(2) + versionPlusOne)
  return {"response": "success"}

try: 
    writeNewVersion(sys.argv[1])
except IndexError:
    print("Supply a filepath. Terminating...")
    exit(2)