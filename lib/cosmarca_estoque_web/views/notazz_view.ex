defmodule CosmarcaEstoqueWeb.NotazzView do
  use CosmarcaEstoqueWeb, :view
  alias CosmarcaEstoqueWeb.NotazzView

  def render("show.json", %{notazz: notazz}) do
    %{data: render_one(notazz, NotazzView, "notazz.json")}
  end

  def render("notazz.json", %{notazz: notazz}) do
    %{mensagem: "Produto: #{notazz} registrado com sucesso" }
  end
end
