defmodule SloaneSH.Serve do
  @moduledoc """
  Task to use `Bandit` to start `SloaneSH.Serve.Plug`
  """
  use Supervisor

  alias __MODULE__

  def start_link(ctx) do
    Supervisor.start_link(__MODULE__, ctx, name: __MODULE__)
  end

  @impl Supervisor
  def init(_ctx) do
    children = [
      {Bandit, plug: Serve.Plug}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
