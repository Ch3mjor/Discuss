defmodule DiscussWeb.CommentsChannel do
   use DiscussWeb, :channel

   @impl true
   def join(name, _params, socket) do
      {:ok, %{hey: "there"}, socket}
   end

   @impl true
   def handle_in(name, message, socket) do

      {:reply, :ok, socket}
   end
end