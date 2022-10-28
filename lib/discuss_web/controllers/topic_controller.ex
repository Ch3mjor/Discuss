defmodule DiscussWeb.TopicController do
    use DiscussWeb, :controller

    alias Discuss.Topic
    alias Discuss.Repo


    def new(conn, _params) do
        changeset = Topic.changeset(%Topic{}, %{})
        render conn, "new.html", changeset: changeset
    end

    def index(conn, _params) do
        IO.inspect("HELLO")
        topics = Repo.all(Topic)
        render conn, "index.html", topics: topics
    end

    def create(conn, %{"topic" => topic}) do
        changeset = Topic.changeset(%Topic{}, topic)
        
        case Repo.insert(changeset) do
            {:ok, post} -> 
                conn
                |> put_flash(:info, "Topic Created")
                |> redirect(to: Routes.topic_path(conn, :index))
            {:error, changeset} -> 
                render conn, "new.html", changeset: changeset
        end
    end

    def edit(conn, %{"id" => topic_id}) do
        IO.inspect(topic_id)
    end
end