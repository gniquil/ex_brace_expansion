ExBraceExpansion
================

Brace expansion[1], as known from sh/bash, in JavaScript. This is a port of the
brace-expasion[2] project.

[1]: https://www.gnu.org/software/bash/manual/html_node/Brace-Expansion.html
[2]: https://github.com/juliangruber/brace-expansion

## Examples

```elixir
  iex> import ExBraceExpansion
  nil

  iex> expand("file-{a,b,c}.jpg")
  ["file-a.jpg", "file-b.jpg", "file-c.jpg"]

  iex> expand("-v{,,}")
  ["-v", "-v", "-v"]

  iex> expand("file{0..2}.jpg")
  ["file0.jpg", "file1.jpg", "file2.jpg"]

  iex> expand("file-{a..c}.jpg")
  ["file-a.jpg", "file-b.jpg", "file-c.jpg"]

  iex> expand("file{2..0}.jpg")
  ["file2.jpg", "file1.jpg", "file0.jpg"]

  iex> expand("file{0..4..2}.jpg")
  ["file0.jpg", "file2.jpg", "file4.jpg"]

  iex> expand("file-{a..e..2}.jpg")
  ["file-a.jpg", "file-c.jpg", "file-e.jpg"]

  iex> expand("file{00..10..5}.jpg")
  ["file00.jpg", "file05.jpg", "file10.jpg"]

  iex> expand("{{A..C},{a..c}}")
  ["A", "B", "C", "a", "b", "c"]

  iex> expand("ppp{,config,oe{,conf}}")
  ["ppp", "pppconfig", "pppoe", "pppoeconf"]
```
