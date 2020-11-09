module.exports = app => {
    const create = async (req, res) => {
        const {desc} = req.body

        if(!desc.trim()){
            return res.status(400).send('Informação inválida.')
        }

        await app.db('tasks').insert({
            desc
        }).then(_ => res.status(201).send()).catch(err => res.status(400).json(err))
    }

    const getTasks = async (req,res) => {
        const tasks = await app.db('tasks').select('*')

        return res.status(201).json(tasks)
    }

    const update = async (req, res) => {
        const id = req.params.id

        if(!id){
            return res.status(400).send('Informação inválida.')
        }

        const [{done}] = await app.db('tasks').where({id}).select('done')

        await app.db('tasks').where({id}).update({done: !done}).then(_ => res.status(201).send()).catch(err => res.status(400).json(err))
    }

    const remove = async (req, res) => {
        const id = req.params.id

        if(!id){
            return res.status(400).send('Não existe este dado.')
        }

        await app.db('tasks').where({id}).del().then(_ => res.status(201).send()).catch(err => res.status(400).json(err))
    }

    return {create, getTasks, update, remove}
}