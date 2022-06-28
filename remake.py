from flask import Blueprint, g, current_app, jsonify, request
import jwt
import uuid
import os

from database import db,V_违约重生审核,重生原因表,违约认定人工审核表

remake = Blueprint('remake', __name__, url_prefix='/remake')

@weiyue.before_request
def getApplyForm(ApplyFormid):
    try:
        applyForm = 违约认定人工审核表.query.get(ApplyFormid)
    except Exception as e:
        print(e)
        return {'status': f'数据库连接失败,请联系管理员!'}, None

    if (applyForm is None):
        return {'status': "不存在的申请!"}, None
    elif (applyForm.审核状态 == "true" or applyForm.审核状态 == "false"):
        return {'status': '该申请已完成处理'}, None
    else:
        return {'status': 'success'}, applyForm


@weiyue.route('/apply', methods=['POST'])
def showReasons():
    try:
        reasons = 重生原因表.query.all()
    except Exception as e:
        print(e)
        return {'status': f'数据库连接失败,请联系管理员!'}

    if (reasons is None):
        return {}
    else:
        return jsonify(json_list = 重生原因表.query.all())

def showWeiyueList():
    try:
        customs = 违约认定人工审核表.query.all()
    except Exception as e:
        print(e)
        return {'status': f'数据库连接失败,请联系管理员!'}

    if (customs is None):
        return {}
    else:
        return jsonify(json_list = 违约认定人工审核表.query.all())

def new():
    remakeReason = request.form.get("remakeReason", type=int, default=None)
    weiyueid = request.form.get("weiyueid", type=int, default=None)

    applyForm = 重生人工审核表(重生原因编号=remakeReason, 违约原因编号=weiyueid, 重生申请时间="", 审核状态="", 负责人="")
    try:
        db.session.add(applyForm)
        db.session.commit()
    except Exception as e:
        print(e)
        return {'status': f'db error'}
    return {'status': f'success'}


@weiyue.route('/verify', methods=['POST'])
def showRemakeList():
    try:
        reasons = V_违约重生审核.query.all()
    except Exception as e:
        print(e)
        return {'status': f'数据库连接失败,请联系管理员!'}

    if (reasons is None):
        return {}
    else:
        return jsonify(json_list = V_违约重生审核.query.all())

def verify():
    passed = request.form.get("passed", type=str, default='').lower()
    id = request.form.get("id", type=int, default=None)

    checkResult, applyForm = getApplyForm(id)
    if not(checkResult['status'] == 'success'):
        return checkResult
    if not(passed == "true" or passed == "false"):
        return {"status":"请选择审核通过与否!"}
    setattr(applyForm, '审核状态', passed)
    setattr(applyForm, '负责人', g.user.username)
    try:
        # db.session.add(applyForm)
        db.session.commit()
    except Exception as e:
        print(e)
        return {'status': f'db error'}

    return {'status': f'success'}


