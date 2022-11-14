defmodule DiscussWeb.CommentsChannel do
   use DiscussWeb, :channel

   def join(name, _auth_params, socket) do
      IO.puts("+++++++++++++++++++++++")
      IO.puts(name)
      
   end

   def handle_in() do
   end
end