# 违约客户管理系统

**ddl 29 日**

## 时间

| 时间点 | 事项                       |
| ------ | -------------------------- |
| 28     | 代码完成（本体）代码 ddl   |
| 29     | 文档完成（代码一定要完成） |
| 30     | 验收 ddl                   |



## 总功能

> 实现违约客户管理系统
>
> 具体为人工违约原因的维护，包括违约的原因和重生的原因。人工发起违约认定的申请，风控部门 进行审核，可以查询所有的待审核和已审核的违约客户信息的功能。违约的重生处理，最后违约按照行业、区域的统计

## 功能点

- [x] 违约风险原因维护（仅需完成数据库构建, 内置基本用户）

  > 违约原因数据维护，违约原因，是否启用，违约记录序号。

- [x] 违约认定申请（人工发起违约认定的申请）

  > 对潜在的违约客户进行人工认定申请，页面内容：客户名称、最新外部等级、违约原因、违约严重性（高、中、低）、备注信息。

- [x] 违约认定审核（风控部门进行审核）

  > 对人工认定申请的客户信息进行审核，进入违约认定审核页面，查询条件：客户名称、审核 状态（拒绝、同意），列表包含客户名称等主要信息。

- [x] 违约信息查询（所有的待审核和已审核的违约客户信息）

  > 对人工认定的信息进行查询，查询列表展示字段：违约客户、审核状态、认定违约原因、严 重程度、认定人 、认定申请时间、认定审核时等信息、最新外部等级。

- [ ] 发起违约重生

  > 对于之前认定为违约的客户，现在由于一些原因，可以进行重生（现在不违约了）。查询列表展示字段：违约客户、审核状态、认定违约原因、严重程度、认定人 、认定申请时间、认定审核时间、最新外部等级信息。选择某一条记录，进行违约重生，违约重生界面展示：违约客户、 认定违约原因、严重程度、认定人 、认定申请时间、最新外部等级、选择重生原因。

- [x] 违约重生(即对某一条信息进行重生消除对应用户违约标记)

  > 对应的部门负责人，对发起的违约重生客户进行审核，认定可以重生。界面展示：违约客户、 认定违约原因、严重程度、认定人 、认定申请时间、重生原因、最新外部等级信息

- [ ] 统计功能（数据可视化）

  > 违约按照行业、区域的统计

## 任务分配

前后端分离

前端

```
*** *** ***
```

后端

```
*** ***
```

测试

```
*** *** *** *** ***
```



### 前端需求点

- [ ] 页面设计
  - [x] 原因维护界面
  - [x] 违约认定申请页面
  - [x] 违约重生申请页面
  - [x] 违约认定审核页面
  - [x] 违约重生审核页面
  - [x] 违约信息查询页面
  - [ ] 统计页面
- [ ] api 调用
  - [x] 原因维护界面 修改原因启用状态
  - [x] 违约认定申请页面 根据后端产生原因, 用户名提交等
  - [ ] 违约重生申请页面 搜索提交等
  - [x] 违约认定审核页面 搜索提交等
  - [x] 违约重生审核页面 搜索提交等
  - [x] 违约信息查询页面 搜索等

### 后端需求点

- [ ] api 接口的实现
  - [x] 鉴权接口
    - [x] 统一鉴权
    - [ ] 分角色鉴权
  - [x] 违约认定申请接口
  - [x] 违约认定审核接口
  - [x] 违约重生申请接口
  - [x] 违约重生审核接口
  - [x] 信息获取类接口
    - [x] 获取违约申请接口
    - [x] 获取重生申请接口
    - [x] 获取违约原因接口
    - [x] 获取重生原因接口

## 代码版本

### 前端

| 版本                         | 新增功能简介                                       |
| ---------------------------- | -------------------------------------------------- |
| Web_Projects_违约原因维护0.1 | 网站 UI 等设计完成                                 |
| Web_Projects_违约原因维护0.2 | 完成违约原因维护页面                               |
| Web_Projects_违约原因维护0.3 | 完成违约认定申请页面                               |
| Web_Projects_违约原因维护0.4 | 初步与后端对接                                     |
| Web_Projects_违约原因维护0.5 | 进一步对接; 增加违约认定申请页面的用户信息展示功能 |
| Web_Projects_违约原因维护0.6 | 整合其他前端页面                                   |





### 后端
