from flask import Blueprint, g, current_app, jsonify, request
import jwt
import uuid
import os

from database import V_已启用的违约原因, V_违约认定审核信息查询, db, to_json, User, 违约认定人工审核表, 客户表, 违约风险原因表

weiyue = Blueprint('weiyue', __name__, url_prefix='/weiyue')


@weiyue.before_request
def verify_jwt():
    try:
        username = jwt.decode(request.form.get("token", type=str, default=None),
                              current_app.config['JWT_SECRET_KEY'], algorithms='HS256')['username']
    except Exception as e:
        return {'status': 'token error'}, 401
    try:
        g.user = User.query.get(username)
    except Exception as e:
        return {'status': 'user not exist'}, 401


def checkCustomExist(customid):
    try:
        custom = 客户表.query.get(customid)
    except Exception as e:
        print(e)
        return {'status': f'数据库连接失败,请联系管理员!'}

    if (custom is None):
        return {'status': "不存在的客户!"}
    elif (custom.违约情况 == 1):
        return {'status': '该客户已违约, 请勿额外申请'}
    else:
        return {'status': 'success'}


def getApplyForm(ApplyFormid):
    try:
        applyForm = 违约认定人工审核表.query.get(ApplyFormid)
    except Exception as e:
        print(e)
        return {'status': f'数据库连接失败,请联系管理员!'}, None

    if (applyForm is None):
        return {'status': "不存在的申请!"}, None
    elif (applyForm.审核状态 == "true" or applyForm.审核状态 == "false"):
        return {'status': '该申请已完成处理, 需要修改违约状态请使用重生功能!'}, None
    else:
        return {'status': 'success'}, applyForm


@weiyue.route('/apply', methods=['POST'])
def new():
    customid = request.form.get("customid", type=int, default=None)
    outLevel = request.form.get("outLevel", type=int, default='0')
    reason = request.form.get("reason", type=int, default=None)
    dangerLevel = request.form.get("dangerLevel", type=int, default='1')
    info = request.form.get("info", type=str, default=None)

    checkResult = checkCustomExist(customid)
    if not(checkResult['status'] == 'success'):
        return checkResult

    applyForm = 违约认定人工审核表(违约审核编号=os.urandom(8).hex(),客户号=customid, 违约原因编号=reason,
                          严重程度=dangerLevel, 认定人="", 外部最新等级=outLevel, 备注=info)
    try:
        db.session.add(applyForm)
        db.session.commit()
    except Exception as e:
        print(e)
        return {'status': f'db error'}

    return {'status': f'success'}


@weiyue.route('/verify', methods=['POST'])
def verify():
    passed = request.form.get("passed", type=str, default='').lower()
    id = request.form.get("id", type=int, default=None)

    checkResult, applyForm = getApplyForm(id)
    if not(checkResult['status'] == 'success'):
        return checkResult
    if not(passed == "true" or passed == "false"):
        return {"status": "请选择审核通过与否!"}
    setattr(applyForm, '审核状态', passed)
    setattr(applyForm, '认定人', g.user.username)
    try:
        db.session.update(applyForm)
        db.session.commit()
    except Exception as e:
        print(e)
        return {'status': f'db error'}

    return {'status': f'success'}


@weiyue.route('/custom', methods=['POST'])
def show():
    try:
        customs = 客户表.query.all()
    except Exception as e:
        print(e)
        return {'status': f'数据库连接失败,请联系管理员!'}

    return jsonify(to_json(customs))


@weiyue.route('/enabled_reason', methods=['POST'])
def en_reason():
    try:
        avaiblereasons = V_已启用的违约原因.query.all()
    except Exception as e:
        print(e)
        return {'status': f'数据库连接失败,请联系管理员!'}

    return jsonify(to_json(avaiblereasons))


@weiyue.route('/all_reason', methods=['POST'])
def all_reason():
    try:
        allreasons = 违约风险原因表.query.all()
    except Exception as e:
        print(e)
        return {'status': f'数据库连接失败,请联系管理员!'}

    return jsonify(to_json(allreasons))


@weiyue.route('/records', methods=['POST'])
def showWeiyueList():
    try:
        records = V_违约认定审核信息查询.query.all()
    except Exception as e:
        print(e)
        return {'status': f'数据库连接失败,请联系管理员!'}

    return jsonify(to_json(records))


@weiyue.after_request
def add_header(response):
    response.headers['Access-Control-Allow-Origin'] = '*'
    return response