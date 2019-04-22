defmodule Canasite.MixProject do
  use Mix.Project

  def project do
    [
      app: :canasite,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Canasite.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:absinthe, "~> 1.4.16"},
      {:absinthe_plug, "~> 1.4.6"},
      {:bcrypt_elixir, "~> 2.0"},
      {:comeonin, "~> 5.1.1"},
      {:ecto_sql, "~> 3.0"},
      {:gettext, "~> 0.11"},
      {:guardian, "~> 1.0"},
      {:jason, "~> 1.0"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix, "~> 1.4.2"},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_pubsub, "~> 1.1"},
      {:plug_cowboy, "~> 2.0"},
      {:ecto_ulid, "~> 0.2.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:ex_machina, "~> 2.3", only: :test},
      {:credo, "~> 0.9.1", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
