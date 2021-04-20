import pyodbc
import os
from random import randint
from time import sleep

print('I am alive!')

sqlAddr = os.getenv('SERVER', 'maria.sysbenchgraph')
db = os.getenv('DB', 'test')
user = os.getenv('USER', 'sysbench')
password = os.getenv('PASS', 'sysbench')
myname = os.getenv('MYNAME', 'UNKNOWN')

cnxn.setdecoding(pyodbc.SQL_WCHAR, encoding='utf-8')
cnxn.setencoding(encoding='utf-8')

conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=${sqlAddr};'
                      'Database=${db};'
                      'uid=${user};'
                      'pwd=${password};'
                      'Trusted_Connection=yes;')

cursor = conn.cursor()
cursor.execute('''
CREATE TABLE IF NOT EXISTS metroDemo (
    Id TEXT PRIMARY KEY,
    Finished BOOL
);

''')

print('Creating table if it does not exist yet')
conn.commit()

cursor.execute('''
INSERT INTO metroDemo (Id, Finished)
VALUES
('${myname}', false),
''')
print('Adding my job to the list')
conn.commit()

print('I am tired, let me sleep a bit')
# Sleep for 10-30 seconds
sleep(randint(10, 30))

cursor.execute('''
UPDATE metroDemo
SET
    Finished = true
WHERE
    Id = '${myname}';
''')
print('I am done working')
conn.commit()