defmodule ExBraceExpansionTest do
  use ExUnit.Case, async: true

  import ExBraceExpansion

  test "basic" do
    assert expand("abcd") == ["abcd"]
  end

  test "numeric sequences" do
    assert expand("a{1..2}b{2..3}c") == [
      "a1b2c", "a1b3c", "a2b2c", "a2b3c"
    ]

    assert expand("{1..2}{2..3}") == [
      "12", "13", "22", "23"
    ]
  end

  test "numeric sequences with step count" do
    assert expand("{0..8..2}") == [
      "0", "2", "4", "6", "8"
    ]
    assert expand("{1..8..2}") == [
      "1", "3", "5", "7"
    ]
  end

  test "numeric sequence with negative x / y" do
    assert expand("{3..-2}") == [
      "3", "2", "1", "0", "-1", "-2"
    ]
  end

  test "alphabetic sequences" do
    assert expand("1{a..b}2{b..c}3") == [
      "1a2b3", "1a2c3", "1b2b3", "1b2c3"
    ]
    assert expand("{a..b}{b..c}") == [
      "ab", "ac", "bb", "bc"
    ]
  end

  test "alphabetic sequences with step count" do
    assert expand("{a..k..2}") == [
      "a", "c", "e", "g", "i", "k"
    ]
    assert expand("{b..k..2}") == [
      "b", "d", "f", "h", "j"
    ]
  end

  test "ignore $" do
    assert expand("${1..3}") == ["${1..3}"]
    assert expand("${a,b}${c,d}") == ["${a,b}${c,d}"]
    assert expand("x${a,b}x${c,d}x") == ["x${a,b}x${c,d}x"]
  end

  test "empty option" do
    assert expand("-v{,,,,}") == [
      "-v", "-v", "-v", "-v", "-v"
    ]
  end

  test "negative increment" do
    assert expand("{3..1}") == ["3", "2", "1"]
    assert expand("{10..8}") == ["10", "9", "8"]
    assert expand("{10..08}") == ["10", "09", "08"]
    assert expand("{c..a}") == ["c", "b", "a"]

    assert expand("{4..0..2}") == ["4", "2", "0"]
    assert expand("{4..0..-2}") == ["4", "2", "0"]
    assert expand("{e..a..2}") == ["e", "c", "a"]
  end

  test "nested" do
    assert expand("{a,b{1..3},c}") == [
      "a", "b1", "b2", "b3", "c"
    ]
    assert expand("{{A..G},{a..g}}") == [
      "A", "B", "C", "D", "E", "F", "G",
      "a", "b", "c", "d", "e", "f", "g"
    ]

    assert expand("ppp{,config,oe{,conf}}") == [
      "ppp", "pppconfig", "pppoe", "pppoeconf"
    ]
  end

  test "ordered" do
    assert expand("a{d,c,b}e") == [
      "ade", "ace", "abe"
    ]
  end

  test "padded" do
    assert expand("{9..11}") == [
      "9", "10", "11"
    ]
    assert expand("{09..11}") == [
      "09", "10", "11"
    ]
  end

  test "same type" do
    assert expand("{a..9}") == ["{a..9}"]
  end

  test "from js minimatch" do
    cases = [
      {
        "a{b,c{d,e},{f,g}h}x{y,z}",
        ["abxy", "abxz", "acdxy", "acdxz", "acexy", "acexz", "afhxy", "afhxz", "aghxy", "aghxz"]
      }, {
        "a{1..5}b",
        ["a1b", "a2b", "a3b", "a4b", "a5b"]
      }, {
        "a{b}c", ["a{b}c"]
      }, {
        "a{00..05}b",
        [ "a00b", "a01b", "a02b", "a03b", "a04b", "a05b" ]
      }, {
        "z{a,b},c}d",
        ["za,c}d", "zb,c}d"]
      }, {
        "z{a,b{,c}d",
        ["z{a,bd", "z{a,bcd"]
      }, {
        "a{b{c{d,e}f}g}h",
        ["a{b{cdf}g}h", "a{b{cef}g}h"]
      }, {
        "a{b{c{d,e}f{x,y}}g}h",
        ["a{b{cdfx}g}h", "a{b{cdfy}g}h", "a{b{cefx}g}h", "a{b{cefy}g}h"]
      }, {
        "a{b{c{d,e}f{x,y{}g}h",
        ["a{b{cdfxh", "a{b{cdfy{}gh", "a{b{cefxh", "a{b{cefy{}gh"]
      }
    ]

    Enum.each cases, fn {pattern, expected} ->
      assert expand(pattern) == expected
    end
  end
end
