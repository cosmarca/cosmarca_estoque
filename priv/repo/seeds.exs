# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CosmarcaEstoque.Repo.insert!(%CosmarcaEstoque.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
CosmarcaEstoque.Accounts.create_user(%{
  email: "zara@gmail.com",
  first_name: "zara",
  last_name: "zara",
  password: "teste@123",
  password_confirmation: "teste@123",
  cnpj: "123",
  business_name: "123",
  fancy_name: "123",
  role: "admin"
})
