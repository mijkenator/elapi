defmodule Elapi.ErrorView do
  require Logger
  use Elapi.Web, :view

  def render("404.html", _assigns) do
    "Page not found"
  end

  def render("500.html", _assigns) do
    "Server internal error"
  end
  
  def render("404.json", _assigns) do
    %{errors: %{detail: "not found"}}
  end
  
  def render("400.json",  %{conn: %{path_info: ["api" | _]}} = _assigns) do
    %{errors: %{detail: "Server infernal error3"}}
  end

  def render("400.json", _assigns) do
    %{errors: %{detail: "Server infernal error2"}}
  end

  def render("500.json", %{conn: %{path_info: ["api" | _]}} = _assigns) do
    %{errors: %{detail: "Server internal error"}}
  end

  def render("500.json", _assigns) do
    %{errors: %{detail: "Server internal error"}}
  end
  
  def render("501.json", _assigns) do
    %{errors: %{detail: "Server infernal error"}}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(template, assigns) do
    #render "500.html", assigns
    Logger.debug "Template not found in Elapi.ErrorView #{inspect template} \n #{inspect assigns}"
    render "501.json", assigns
  end
end
