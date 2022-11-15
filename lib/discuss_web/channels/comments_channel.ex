defmodule DiscussWeb.CommentsChannel do
   use DiscussWeb, :channel

   @impl true
   def join(name, _params, socket) do
      IO.puts("+++++++++++++++++++++++")
      IO.puts(name)
      {:ok, %{hey: "there"}, socket}
   end

   @impl true
   def handle_in(_param, _payload, _socket) do
   end
end