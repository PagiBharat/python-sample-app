from flask import Flask
from sqlalchemy import create_engine, text

app = Flask(__name__)

@app.route('/')
def index():
    engine = create_engine('mysql+pymysql://root:password@db:3306/mydatabase')
    connection = engine.connect()
    result = connection.execute(text("SELECT 1")).fetchall()
    return f"This is Sample Python Project Connected to the MySQL database! Result: {result}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
