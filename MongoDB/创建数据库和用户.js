// MongoDB 创建数据库和用户

// 只需切换到数据库并进行操作即可创建
use dbname
// switched to db dbname

// 为 dbname 数据库创建一个名为 dbuser 的用户，并设置密码为 test，同时授予 readWrite 权限。
db.createUser({
  user: "dbuser",
  pwd: "test",
  roles: [
    { role: "readWrite", db: "dbname" }
  ]
})
// Successfully added user: { "user" : "dbuser", "roles" : [ { "role" : "readWrite", "db" : "dbname" } ] }

// 测试新用户连接 mongosh mongodb://dbuser:test@172.18.0.50:27017/dbname
// 连接成功后，可执行以下命令检查权限
db.testCollection.insertOne({ name: "testData" })  // 插入测试数据
db.testCollection.find()                          // 查询数据

// 尝试访问其他数据库，确认新用户没有权限
use admin
db.testCollection.find()
// 应显示权限错误
