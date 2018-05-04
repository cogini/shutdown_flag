defmodule ShutdownFlag.Mixfile do
  use Mix.Project

  def project do
    [
      app: :shutdown_flag,
      version: "0.1.0",
      elixir: "~> 1.5",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      source_url: "https://github.com/cogini/shutdown_flag",
      dialyzer: [
        plt_add_deps: true,
        # flags: ["-Wunmatched_returns", :error_handling, :race_conditions, :underspecs],
      ],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ShutdownFlag.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      # {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
    ]
  end

  defp description() do
    "Performs an orderly system shutdown with `:init.stop()` if a flag file appears."
  end

  defp package() do
    [
      maintainers: ["Jake Morrison"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/cogini/shutdown_flag"}
    ]
  end
end
