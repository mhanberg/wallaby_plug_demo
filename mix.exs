defmodule WallabyPlugDemo.MixProject do
  use Mix.Project

  def project do
    [
      app: :wallaby_plug_demo,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: [
        test: ["assets.compile", "test"],
        "assets.compile": &compile_assets/1
      ]
    ]
  end

  defp compile_assets(_) do
    Mix.shell().cmd("yarn build",
      cd: "javascript-app",
      quiet: true
    )
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {WallabyPlugDemo.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, ">= 0.0.0"},
      {:bandit, ">= 0.0.0"},
      {:wallaby, ">= 0.0.0", only: :test}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
