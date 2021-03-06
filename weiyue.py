from flask import Blueprint, g, current_app, jsonify, request
import jwt
import uuid
import os

from database import db, to_json, User, 违约认定人工审核表, 客户表, 违约风险原因表, V_违约认定审核总信息

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
    elif (applyForm.审核状态 == "审核通过" or applyForm.审核状态 == "审核未通过"):
        return {'status': '该申请已完成处理, 需要修改违约状态请使用重生功能!'}, None
    else:
        return {'status': 'success'}, applyForm


@weiyue.route('/apply', methods=['POST'])
def new():
    customid = request.form.get("customid", type=str, default=None)
    outLevel = request.form.get("outLevel", type=int, default='0')
    reasonid = request.form.get("reason", type=int, default=None)
    dangerLevel = request.form.get("dangerLevel", type=int, default='1')
    info = request.form.get("info", type=str, default=None)
    checkResult = checkCustomExist(customid)
    if not(checkResult['status'] == 'success'):
        return checkResult
    applyForm = 违约认定人工审核表(违约审核编号=os.urandom(8).hex(),客户号=customid, 违约原因编号=reasonid,
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
    id = request.form.get("id", type=str, default=None)
    checkResult, applyForm = getApplyForm(id)
    if not(checkResult['status'] == 'success'):
        return checkResult
    if not(passed == "审核通过" or passed == "审核未通过"):
        return {"status": "请选择审核通过与否!"}
    setattr(applyForm, '审核状态', passed)
    setattr(applyForm, '认定人', g.user.username)
    try:
        # db.session.update(applyForm)
        try:
            db.session.update(applyForm)
        except:
            pass
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


@weiyue.route('/reason', methods=['POST'])
def reason():
    enable = request.form.get("enable", type=int, default=None)
    if enable is None:
        try:
            reasons = 违约风险原因表.query.all()
        except Exception as e:
            print(e)
            return {'status': f'数据库连接失败,请联系管理员!'}
    else:
        try:
            db.session.flush()
            reasons = 违约风险原因表.query.filter_by(是否启用=enable)
        except Exception as e:
            print(e)
        return {'status': f'数据库连接失败,请联系管理员!'}

    return jsonify(to_json(reasons))


@weiyue.route('/change_reason', methods=['POST'])
def cgreason():
    enable = request.form.get("enable", type=int, default=None)
    reasonid = request.form.get("reasonid", type=int, default=None)
    if enable is None:
        try:
            db.session.flush()
            reasons = 违约风险原因表.query.all()
        except Exception as e:
            print(e)
            return {'status': f'数据库连接失败,请联系管理员!'}
    else:
        try:
            reasons = 违约风险原因表.query.get(reasonid)
            setattr(reasons, '是否启用', enable)
            try:
                try:
                    db.session.update(reasons)
                except:
                    pass
                db.session.commit()
                # db.session.flush()
            except Exception as e:
                print(e)
                return {'status': f'数据库连接失败,请联系管理员!'}
        except Exception as e:
            print(e)
            return {'status': '没有这个风险'}
        return {'status': 'success'}
    return jsonify(to_json(reasons))


@weiyue.route('/records', methods=['POST'])
def showWeiyueRecords():
    passQuery = request.form.get("passed", type=str, default=None)
    print(passQuery)
    if not passQuery:
        try:
            db.session.flush()
            db.session.commit()
            records = V_违约认定审核总信息.query.all()
        except Exception as e:
            print(e)
            return {'status': f'数据库连接失败,请联系管理员!'}
    else:
        try:
            db.session.flush()
            db.session.commit()
            records = V_违约认定审核总信息.query.filter_by(审核状态=passQuery)
        except Exception as e:
            print(e)
            return {'status': f'数据库连接失败,请联系管理员!'}

    return jsonify(to_json(records))


@weiyue.after_request
def add_header(response):
    response.headers['Access-Control-Allow-Origin'] = '*'
    return response