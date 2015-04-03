defmodule ExBraceExpansion.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_brace_expansion,
     version: "0.0.1",
     elixir: "~> 1.0",
     description: description,
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    []
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    []
  end

  defp description do
    """
    Brace expansion, as known from sh/bash, in Elixir. Quick example:

    iex> ExBraceExpansion.expand("file-{a,b,c}.jpg")
    ["file-a.jpg", "file-b.jpg", "file-c.jpg"]

    iex> expand("file{00..10..5}.jpg")
    ["file00.jpg", "file05.jpg", "file10.jpg"]
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      contributors: ["Frank Liu"],
      links: %{"GitHub" => "https://github.com/gniquil/ex_brace_expansion"}
    ]
  end
end
