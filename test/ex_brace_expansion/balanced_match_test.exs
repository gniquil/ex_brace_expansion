defmodule BalancedMatchTest do
  use ExUnit.Case, async: true

  import ExBraceExpansion.BalancedMatch

  test "invalid" do
    assert balanced("{", "}", "nope") == nil
  end

  test "pre{nest}post" do
    assert balanced("{", "}", "pre{nest}post") == %{
      start: 3,
      finish: 8,
      pre: "pre",
      body: "nest",
      post: "post"
    }
  end

  test "pre{in{nest}}post" do
    assert balanced("{", "}", "pre{in{nest}}post") == %{
      start: 3,
      finish: 12,
      pre: "pre",
      body: "in{nest}",
      post: "post"
    }
  end

  test "{{{{{{{{{in}post" do
    assert balanced("{", "}", "{{{{{{{{{in}post") == %{
      start: 8,
      finish: 11,
      pre: "{{{{{{{{",
      body: "in",
      post: "post"
    }
  end

  test "pre{body{in}post" do
    assert balanced("{", "}", "pre{body{in}post") == %{
      start: 8,
      finish: 11,
      pre: "pre{body",
      body: "in",
      post: "post"
    }
  end

  test "pre}{in{nest}}post" do
    assert balanced("{", "}", "pre}{in{nest}}post") == %{
      start: 4,
      finish: 13,
      pre: "pre}",
      body: "in{nest}",
      post: "post"
    }
  end

  test "pre{body}between{body2}post" do
    assert balanced("{", "}", "pre{body}between{body2}post") == %{
      start: 3,
      finish: 8,
      pre: "pre",
      body: "body",
      post: "between{body2}post"
    }
  end

  test "pre<b>in<b>nest</b></b>post" do
    assert balanced("<b>", "</b>", "pre<b>in<b>nest</b></b>post") == %{
      start: 3,
      finish: 19,
      pre: "pre",
      body: "in<b>nest</b>",
      post: "post"
    }
  end

  test "pre</b><b>in<b>nest</b></b>post" do
    assert balanced("<b>", "</b>", "pre</b><b>in<b>nest</b></b>post") == %{
      start: 7,
      finish: 23,
      pre: "pre</b>",
      body: "in<b>nest</b>",
      post: "post"
    }
  end
end
