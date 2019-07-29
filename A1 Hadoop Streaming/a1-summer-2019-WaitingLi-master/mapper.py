#!/usr/bin/env python
import sys
import re

pattern = re.compile(r'/[A-Z][a-z]{2}/\d{4}|/[A-Z][a-z]{3}/\d{4}')

month_map = {'Jan':'01',
             'Feb':'02',
             'Mar':'03',
             'Apr':'04',
             'May':'05',
             'Jun':'06',
             'Jul':'07',
             'Aug':'08',
             'Sept':'09',
             'Sep':'09',
             'Oct':'10',
             'Nov':'11',
             'Dec':'12'}

for line in sys.stdin:
    line = line.strip()
    try:
        month, year = re.findall(pattern,line)[0].split('/')[1:]
        month = month_map[month]
        print(year + '-' + month + '\t' + '1')
    except:
        continue


