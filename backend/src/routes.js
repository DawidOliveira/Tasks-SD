module.exports = app => {
    app.post('/task', app.api.task.create)
    app.get('/tasks', app.api.task.getTasks)
    app.put('/task/:id', app.api.task.update)
    app.delete('/task/:id', app.api.task.remove)
}