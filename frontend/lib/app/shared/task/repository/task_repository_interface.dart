abstract class ITaskRepository {
  createTask(String desc);
  deleteTask(int id);
  updateTask(int id);
  getTasks();
}
