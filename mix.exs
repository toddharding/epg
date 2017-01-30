defmodule Epg.Mixfile do
  use Mix.Project

  def project do
    [app: :epg,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: escript(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  def escript do
    [main_module: Epg]
  end
  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:benchfella, "~> 0.3.0"},
     {:exprof, "~> 0.2.0"},
     {:flow, "~> 0.11"},
     {:gen_stage, "~> 0.11"}]
  end
end
