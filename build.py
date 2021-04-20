import pyodbc
import os
import shortuuid
from random import randint
from time import sleep

print('ready for work!')

sqlAddr = os.getenv('SERVER', 'mariadb.sysbench')
db = os.getenv('DB', 'mariadb')
user = os.getenv('USER', 'sysbench')
password = os.getenv('PASS', 'sysbench')
myname = os.getenv('MYNAME', 'UNKNOWN')

conn = pyodbc.connect('Driver='CData ODBC Driver for MariaDB';'
                      'Server=${sqlAddr};'
                      'Database=${db};'
                      'uid=${user};'
                      'pwd=${password};'
                      'Trusted_Connection=yes;')

cursor = con.cursor()
cursor.execute('''
CREATE TABLE IF NOT EXISTS metroDemo (
    id serial PRIMARY KEY,
    submit_time DATETIME,
    complete_time DATETIME,
    source VARCHAR,
    logs VARCHAR,
    artifact VARCHAR
);

''')

print('Creating table if it does not exist yet')
con.commit()

cursor.execute('''
INSERT INTO metroDemo (id, submit_time, source)
       VALUES (%s,
               NOW(),
               "https://github.com/lavaliere/game-of-life",
);

''', [build_id], [build_id])

print('Adding build to the tracker')
con.commit()

# Random sleep to splay build times
sleep(randint(1, 5))

cmd = "mkdir -p /opt/builds/" +  build_id
os.system(cmd)
path = "/opt/builds/" +  build_id
os.chdir(path)
os.system("git clone https://github.com/lavaliere/game-of-life")
build_dir = path + game-of-life
os.chdir(build_dir)
os.system("mvn install")

cursor.execute('''
UPDATE metroDemo
    SET complete_time = NOW(),
        logs = 'view',
        artifact = 'download'
    WHERE
    id = %s;

''', [build_id])

print('jobs done!')
con.commit()

