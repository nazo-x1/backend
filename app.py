from flask import Flask
from weiyue import weiyue
from database import db
from user import user
import configs

app = Flask(__name__)
app.config.from_object(configs)
db.init_app(app)
app.register_blueprint(weiyue)
app.register_blueprint(user)


@app.route('/')
def index():
    try:
        engine = db.get_engine()
        conn = engine.connect()
        conn.close()  # 跟open函数一样，可以用with语句
        # with engine.connect() as conn:
        #	result = conn.execute('select 1')  #这两步打开数据库并且创建表
        #	print (result.fetchone()) #打印一条数据
    except Exception as e:
        print(e)
        return f"db connect failed\ndetails:\n{e}"
    return "hello, world"


# if __name__ == '__main__':
#     app.run()
