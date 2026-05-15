import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="DA@mysql",
    database="shipment"
)


query = "SELECT * FROM shipment_data"


df = pd.read_sql(query, conn)
"""
print(df.shape)

print(df.columns)

print(df["Reached_on_Time"].value_counts())

print(df["Mode_of_Shipment"].value_counts())

print(df["Warehouse_block"].value_counts())

df.columns = df.columns.str.replace('ï»¿', '')

print(df.head())



print(delay_data["Mode_of_Shipment"].value_counts())

delay_data = df[df["Reached_on_Time"] == 1]

#import matplotlib.pyplot as plt

delay_data["Mode_of_Shipment"].value_counts().plot(kind="bar")

plt.title("Delayed Shipments by Mode")

plt.xlabel("Shipment Mode")

plt.ylabel("Number of Delays")

plt.show()
"""
4
warehouse_delay = df[df["Reached_on_Time"] == 1]

warehouse_delay["Warehouse_block"].value_counts().plot(kind="bar")

plt.title("Delayed Shipments by Warehouse")

plt.xlabel("Warehouse Block")

plt.ylabel("Number of Delays")

plt.show()


conn.close()
