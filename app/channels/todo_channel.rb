# Be sure to restart your server when you modify this file.
# Action Cable runs in a loop that does not support auto reloading.

class TodoListChannel < ApplicationCable::Channel
  def follow(data)
    stop_all_streams
    # todo_list_id = data["todo_id"]
    todo_list_id = TodoList.first
    stream_from "todo_list_channel_#{todo_list_id}"
  end

  def unfollow
    stop_all_streams
  end

  def create_todo(data)
    todo = Todo.create!(data["todo"])
    ActionCable.server.broadcast(
      "todo_list_channel_#{todo.todo_list_id}",
      todo: todo.to_json, action: :create_todo
    )
  end

  def update_todo(data)
    todo = find_todo data["todo"]["id"]
    todo.update_columns data["todo"]
    ActionCable.server.broadcast(
      "todo_list_channel_#{todo.todo_list_id}",
      todo: todo.to_json, action: :update_todo
    )
  end

  def destroy_todo(data)
    todo = find_todo data["id"]
    todo.destroy!
    ActionCable.server.broadcast(
      "todo_list_channel_#{todo.todo_list_id}",
      todo: todo.to_json, action: :destroy_todo
    )
  end

  private

  def find_todo(id)
    Todo.find(id)
  end
end
