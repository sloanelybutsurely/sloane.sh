defmodule SloaneSH.FrontMatterTest do
  use ExUnit.Case

  alias SloaneSH.FrontMatter

  test "parses TOML front matter" do
    document = ~S"""
    +++
    foo = "bar"
    +++
    # Hello, World!

    This is a document with front matter.
    """

    assert {:ok, %{foo: "bar"}, "# Hello, World!" <> _} = FrontMatter.parse(document, %{})
  end

  test "returns an empty map is the document doesn't have front matter" do
    document = ~S"""
    # Hello, World!

    This is a document with front matter.
    """

    assert {:ok, %{} = map, document} = FrontMatter.parse(document, %{})
    assert %{} = map
  end

  test "errors in TOML front matter produce an error" do
    document = ~S"""
    +++
    foo = "bar
    +++
    # Hello, World!

    This is a document with front matter.
    """

    assert {:error, _} = FrontMatter.parse(document, %{})
  end
end
