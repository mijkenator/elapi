defmodule Elapi.Mixfile do
  use Mix.Project

  def project do
    {result, _exit_code} = System.cmd("git", ["rev-parse", "HEAD"])
    {rcount, _exit_code} = System.cmd("git", ["rev-list", "--all", "--count"])
    rcount = String.strip(rcount)
    result = String.strip(result)
    [app: :elapi,
     version: "0.0.#{rcount}-#{result}",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Elapi, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger, :gettext,
                    :phoenix_ecto, :postgrex, :mariaex, :comeonin, :ueberauth_github,
                    :phoenix_html, :cors_plug, :secure_random,
                    :ex_admin, :guardian, :ueberauth, :ueberauth_identity,
                    :ueberauth_github, :exrm]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.1.6"},
     {:postgrex, ">= 0.0.0"},
     {:mariaex, ">= 0.0.0"},
     {:phoenix_ecto, "~> 2.0"},
     {:phoenix_html, "~> 2.4"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:gettext, "~> 0.9"},
     {:cors_plug, "~> 1.1"},
     {:comeonin, "~> 2.0"},
     {:secure_random, "~> 0.2"},
     {:ex_admin, "~> 0.7"},
     {:guardian, "~> 0.12.0"},
     {:ueberauth, "~> 0.2.0"},
     {:ueberauth_identity, "~> 0.2.3"},
     {:ueberauth_github, "~> 0.2.0"},
     {:exrm, "~> 0.15.3"},
     {:logger_file_backend, ">= 0.0.0"},
     {:cowboy, "~> 1.0"}]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"]]
  end
end
