import mysql.connector
import os
import shortuuid
from random import randint
from time import sleep

print('ready for work!')

host = os.getenv('SERVER', 'mariadb.sysbench')
db = os.getenv('DB', 'mariadb')
user = os.getenv('DBUSER', 'sysbench')
password = os.getenv('PASS', 'sysbench')
myname = os.getenv('MYNAME', 'UNKNOWN')
build_id = os.getenv('BUILD_ID', shortuuid.uuid())

db = mysql.connector.connect(
    host = host,
    user = user,
    passwd = password,
    database = db
)

cursor = db.cursor()
create_tbl = """CREATE TABLE IF NOT EXISTS metroDemo (
    id serial PRIMARY KEY,
    submit_time DATETIME,
    complete_time DATETIME,
    source TEXT,
    logs TEXT,
    artifact TEXT
)
"""
cursor.execute(create_tbl)
print('Creating table if it does not exist yet')
db.commit()


add_build = """
INSERT INTO metroDemo (id, submit_time, source)
       VALUES (%s,
               NOW(),
               "https://github.com/lavaliere/game-of-life",
)
"""
cursor.execute(add_build,(build_id))
print('Adding build to the tracker')
db.commit()


# Random sleep to splay build times
sleep(randint(1, 5))


# Build some software!
cmd = "mkdir -p /opt/builds/" +  build_id
os.system(cmd)
path = "/opt/builds/" +  build_id
os.chdir(path)
os.system("git clone https://github.com/lavaliere/game-of-life")
build_dir = path + game-of-life
os.chdir(build_dir)
os.system("mvn install")



update_build = """
UPDATE metroDemo
    SET complete_time = NOW(),
        logs = 'view',
        artifact = 'download'
    WHERE
    id = %s
"""
cursor.execute(update_build,(build_id))
print('jobs done!')
db.commit()

