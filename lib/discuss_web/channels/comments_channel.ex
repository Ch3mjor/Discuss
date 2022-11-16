defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel
  alias Discuss.{Comment, Topic, Repo}

  @impl true
  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)

    # topic =
    #   Topic
    #   |> Repo.get(topic_id)
    #   |> Repo.preload(comments: [:user])

    topic =
      Topic
      |> Repo.get(topic_id)
      |> Repo.preload(comments: [:user])

    socket = assign(socket, :topic, topic)
    {:ok, %{comments: topic.comments}, socket}
  end

  @impl true
  def handle_in(name, %{"content" => content}, socket) do
    # IO.inspect(socket.assigns, label: "++++++++++++++++++++++FULL SOCKET980800+++++++++++++++++++++=")
    topic = socket.assigns.topic
    # user_id = socket.assigns
    # IO.inspect(user_id, label: "++++++++++++++++++++++HERE+++++++++++++++++++++=")
    # Socket param setting not working
    # Check on this
    user_id = 1

    changeset =
      topic
      |> Ecto.build_assoc(:comments, user_id: user_id)
      |> Comment.changeset(%{content: content})
    

    case Repo.insert(changeset) do
      {:ok, comment} ->
         broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{comment: comment})
        {:reply, :ok, socket}

      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
end
