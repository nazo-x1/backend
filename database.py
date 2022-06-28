from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()

def to_json(all_vendors):
    v = [ ven.dobule_to_dict() for ven in all_vendors ]
    return v

class User(db.Model):
    username = db.Column(db.String(16), primary_key=True)
    password = db.Column(db.String(16))
    random = db.Column(db.String(16))
    def to_dict(self):
        model_dict = dict(self.__dict__)
        del model_dict['_sa_instance_state']
        return model_dict
    def dobule_to_dict(self):
        result = {}
        for key in self.__mapper__.c.keys():
            if getattr(self, key) is not None:
                result[key] = str(getattr(self, key))
            else:
                result[key] = getattr(self, key)
        return result
    db.to_dict = to_dict
    db.dobule_to_dict = dobule_to_dict

class 违约认定人工审核表(db.Model):
    # 违约认定人工审核（违约审核编号，客户号，违约编号，严重程度，认定人，认定申请时间，外部最新等级，备注，审核状态）
    违约审核编号 = db.Column(db.String(16), primary_key=True)
    客户号 = db.Column(db.String(16))
    违约原因编号 = db.Column(db.String(16))
    严重程度 = db.Column(db.String(2))
    认定人 = db.Column(db.String(128))
    认定申请时间 = db.Column(db.DateTime)
    外部最新等级 = db.Column(db.String(2))
    备注 = db.Column(db.String(512))
    审核状态 = db.Column(db.String(20))
    def to_dict(self):
        model_dict = dict(self.__dict__)
        del model_dict['_sa_instance_state']
        return model_dict
    def dobule_to_dict(self):
        result = {}
        for key in self.__mapper__.c.keys():
            if getattr(self, key) is not None:
                result[key] = str(getattr(self, key))
            else:
                result[key] = getattr(self, key)
        return result
    db.to_dict = to_dict
    db.dobule_to_dict = dobule_to_dict

class 客户表(db.Model):
    # 客户（客户号，客户名，性别，区域，行业，联系方式，集团 违约风险原因（违约编号，违约原因，是否启用）
    客户号 = db.Column(db.String(16), primary_key=True)
    客户名 = db.Column(db.String(128))
    性别 = db.Column(db.String(2))
    区域 = db.Column(db.String(50))
    行业 = db.Column(db.String(50))
    联系方式 = db.Column(db.String(20))
    集团 = db.Column(db.String(40))
    违约情况 = db.Column(db.Boolean)
    def to_dict(self):
        model_dict = dict(self.__dict__)
        del model_dict['_sa_instance_state']
        return model_dict
    def dobule_to_dict(self):
        result = {}
        for key in self.__mapper__.c.keys():
            if getattr(self, key) is not None:
                result[key] = str(getattr(self, key))
            else:
                result[key] = getattr(self, key)
        return result
    db.to_dict = to_dict
    db.dobule_to_dict = dobule_to_dict
    # def to_json(self):
    #     return {
    #         '客户号': self.客户号,
    #         '客户名': self.客户名,
    #         '性别': self.性别,
    #         '区域': self.区域,
    #         '行业': self.行业,
    #         '联系方式': self.联系方式,
    #         '集团': self.集团,
    #         '违约情况': self.违约情况,
    #     }

class 重生人工审核表(db.Model):
    重生审核编号 = db.Column(db.String(16), primary_key=True)
    重生原因编号 = db.Column(db.String(16))
    违约审核编号 = db.Column(db.String(16))
    重生申请时间 = db.Column(db.DateTime)
    审核状态 = db.Column(db.String(20))
    负责人 = db.Column(db.String(128))
    def to_dict(self):
        model_dict = dict(self.__dict__)
        del model_dict['_sa_instance_state']
        return model_dict
    def dobule_to_dict(self):
        result = {}
        for key in self.__mapper__.c.keys():
            if getattr(self, key) is not None:
                result[key] = str(getattr(self, key))
            else:
                result[key] = getattr(self, key)
        return result
    db.to_dict = to_dict
    db.dobule_to_dict = dobule_to_dict


