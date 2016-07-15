defmodule Elapi.ErrorViewTest do
  use Elapi.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.html" do
    assert render_to_string(Elapi.ErrorView, "404.html", []) ==
           "Page not found"
  end

  test "render 500.html" do
    assert render_to_string(Elapi.ErrorView, "500.html", []) ==
           "Server internal error"
  end

  test "renders 404.json" do
    assert render(Elapi.ErrorView, "404.json", []) ==
           %{errors: %{detail: "not found"}}
  end

  test "render 500.json" do
    assert render(Elapi.ErrorView, "500.json", []) ==
           %{errors: %{detail: "Server internal error"}}
  end

  test "render any other" do
    #assert render_to_string(Elapi.ErrorView, "505.html", []) ==
    #       "Server internal error"
    assert render(Elapi.ErrorView, "505.html", []) ==
           %{errors: %{detail: "Server infernal error"}}
  end
end
