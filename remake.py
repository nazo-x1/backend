from flask import Blueprint, g, current_app, jsonify, request
import jwt
import uuid
import os

from database import User, db, V_重生审核, to_json, 违约认定人工审核表, 重生人工审核表, 重生原因表

remake = Blueprint('remake', __name__, url_prefix='/remake')


@remake.before_request
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


@remake.route('/reason', methods=['POST'])
def showReasons():
    try:
        db.session.flush()
        reasons = 重生原因表.query.all()
    except Exception as e:
        print(e)
        return {'status': f'数据库连接失败,请联系管理员!'}

    return jsonify(to_json(reasons))


@remake.route('/apply', methods=['POST'])
def new():
    weiyueid = request.form.get("id", type=str, default=None)
    remakeReasonid = request.form.get("reasonid", type=int, default=None)
    try:
        record = 违约认定人工审核表.query.get(weiyueid)
    except Exception as e:
        return {'status': '审核表不存在'}

    if not(record.审核状态 == "审核通过"):
        return {'status': '未被通过的违约申请无需重生'}

    applyForm = 重生人工审核表(重生审核编号=os.urandom(8).hex(),
                        重生原因编号=remakeReasonid, 违约审核编号=weiyueid)
    try:
        db.session.add(applyForm)
        db.session.commit()
    except Exception as e:
        print(e)
        return {'status': f'db error'}
    return {'status': f'success'}


@remake.route('/records', methods=['POST'])
def showRemakeRecords():
    passQuery = request.form.get("passed", type=str, default=None)
    if not passQuery:
        try:
            db.session.flush()
            records = V_重生审核.query.all()
        except Exception as e:
            print(e)
            return {'status': f'数据库连接失败,请联系管理员!'}
    else:
        try:
            db.session.flush()
            records = V_重生审核.query.filter_by(审核状态=passQuery)
        except Exception as e:
            print(e)
            return {'status': f'数据库连接失败,请联系管理员!'}
    return jsonify(to_json(records))


def getApplyForm(ApplyFormid):
    try:
        applyForm = 重生人工审核表.query.get(ApplyFormid)
    except Exception as e:
        print(e)
        return {'status': f'数据库连接失败,请联系管理员!'}, None

    if (applyForm is None):
        return {'status': "不存在的申请!"}, None
    elif (applyForm.审核状态 == "审核通过" or applyForm.审核状态 == "审核未通过"):
        return {'status': '该重生申请已完成处理, 需要修改违约状态请重新申请重生!'}, None
    else:
        return {'status': 'success'}, applyForm


@remake.route('/verify', methods=['POST'])
def verify():
    passed = request.form.get("passed", type=str, default='').lower()
    id = request.form.get("id", type=str, default=None)

    checkResult, applyForm = getApplyForm(id)
    if not(checkResult['status'] == 'success'):
        return checkResult
    if not(passed == "审核通过" or passed == "审核未通过"):
        return {"status": "请选择审核通过与否!"}
    setattr(applyForm, '审核状态', passed)
    setattr(applyForm, '负责人', g.user.username)
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


@remake.after_request
def add_header(response):
    response.headers['Access-Control-Allow-Origin'] = '*'
    return response