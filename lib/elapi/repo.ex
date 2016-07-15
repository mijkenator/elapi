defmodule Elapi.Repo do
  use Ecto.Repo, otp_app: :elapi
  
  use Scrivener, page_size: 10
end
