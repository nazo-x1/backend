from flask import Blueprint, current_app, g, request
from database import db, User
import sqlalchemy

import jwt
import re
import os

user = Blueprint('user', __name__, url_prefix='/user')

@user.route('/new', methods=['POST'])
def new():
    try:
        username = request.form.get("username", type=str, default=None)
        password = request.form.get("password", type=str, default=None)
    except Exception as e:
        return {'status': f'parameter error:{e}'}, 400
    if len(username) > 16 or len(password) > 16:
        return {'status': 'username/password too long'}
    if re.match("^[\w_-]+$", username) is None:
        return {'status': 'invalid username'}


    try:
        user = User.query.filter_by(username=username).first()
        if user is not None:
            return {'status': 'username already used'}
    except Exception as e:
        # raise e
        print(e)
        return {'status': 'db error 1'}

    user = User(username=username, password=password, random=os.urandom(8).hex())

    try:
        db.session.add(user)
        db.session.commit()
    except Exception as e:
        print(e)
        return {'status': 'db error 2'}

    return {'status': 'success'}

@user.route('/login', methods=['POST'])
def login():
    try:
        username = request.form.get("username", type=str, default=None)
        password = request.form.get("password", type=str, default=None)
    except KeyError:
        return {'status': 'parameter error'}, 400

    user = User.query.filter_by(username=username, password=password).first()
    if user is None:
        return {'status': 'login failed'}
    return {'status':'success', 'token': jwt.encode({'username':username}, current_app.config['JWT_SECRET_KEY'], algorithm='HS256')}
