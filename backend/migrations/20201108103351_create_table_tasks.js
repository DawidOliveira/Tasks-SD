
exports.up = function(knex) {
  return knex.schema.createTable('tasks', table => {
      table.increments('id').primary()
      table.string('desc').notNullable()
      table.boolean('done').defaultTo(false)

      table.timestamp('createdAt').defaultTo(knex.fn.now());
      table.timestamp('updatedAt').defaultTo(knex.fn.now());
  })
};

exports.down = function(knex) {
    return knex.schema.dropTable('tasks')
};
