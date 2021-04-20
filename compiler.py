import pyodbc 

cnxn.setdecoding(pyodbc.SQL_WCHAR, encoding='utf-8')
cnxn.setencoding(encoding='utf-8')

conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=RON\SQLEXPRESS;'
                      'Database=TestDB;'
                      'Trusted_Connection=yes;')
 
cursor = conn.cursor()
cursor.execute('SELECT * FROM TestDB.dbo.Person')
 
for row in cursor:
    print(row)