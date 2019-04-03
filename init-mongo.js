
db.createUser({ user: 'admin', pwd: 'admin123456', roles: [ { role: "root", db: "admin" } ] });

db.auth("admin", "admin123456");
 db.createUser({
 user: 'yapi',
 pwd: 'yapi123456',
 roles: [
 { role: "dbAdmin", db: "yapi" },
 { role: "readWrite", db: "yapi" }
 ]

 });
