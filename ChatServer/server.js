const express = require('express'),
    app = express(),
    http = require('http'),
    server = http.createServer(app),
    port = process.env.PORT || 5000,
    {Server} = require('socket.io'),
    io = new Server(server)

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html')
})

let connectedInfo = {}

io.on('connection', socket => {
    console.log('A user connected')
    let userInfo = {}
    // updateUserInfo()
    //登录
    socket.on('login', (loginInfo, callback) => {
        userInfo = loginInfo
        if (userInfo.length === 0) {
            callback('请先填写用户名')
            return
        }
        if (!connectedInfo[userInfo.house_id]) {
            //没有房间，在建房的同时把用户放进去
            connectedInfo[userInfo.house_id] = [userInfo.user_id]
            callback(connectedInfo[userInfo.house_id])
        } else {
            //有房间，判断人数
            if (connectedInfo[userInfo.house_id].indexOf(userInfo.user_id) !== -1) {
                //房间内存在同名用户，允许多开
                callback(connectedInfo[userInfo.house_id])
            } else if (connectedInfo[userInfo.house_id].length === 2) {
                //已经有2人，不让进
                callback('这里满员了')
                return
            } else {
                //用户进入房间
                connectedInfo[userInfo.house_id].push(userInfo.user_id)
                callback(connectedInfo[userInfo.house_id])
            }
        }
        console.log(connectedInfo)
        updateUserInfo()
    })
    //接收消息
    socket.on('chat message', data => {
        io.emit('output', data)
    })

    //登出
    socket.on('disconnect', () => {
        if(connectedInfo[userInfo.house_id] && connectedInfo[userInfo.house_id].indexOf(userInfo.user_id) !== -1){
            console.log('A User disconnected')
            connectedInfo[userInfo.house_id].splice(connectedInfo[userInfo.house_id].indexOf(userInfo.user_id), 1)
            console.log(connectedInfo)
            updateUserInfo()
        }
    })

    //更新用户列表
    function updateUserInfo() {
        io.emit('loadUser', connectedInfo)
    }
})

server.listen(port, () => {
    console.log(`Server running on port ${port}`)
})