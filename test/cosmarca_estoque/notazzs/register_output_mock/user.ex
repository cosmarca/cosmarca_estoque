defmodule CosmarcaEstoque.Stocks.Notazz.User do


  def mock_user() do
    %CosmarcaEstoque.Accounts.User{
      business_name: "notazz@notazz.com",
      cnpj: "123444",
      email: "notazz@notazz.com",
      fancy_name: "notazz@notazz.com",
      first_name: "notazz@notazz.com",
      id: 2,
      inserted_at: ~N[2019-04-21 21:02:29],
      last_name: "notazz@notazz.com",
      password: nil,
      password_confirmation: nil,
      password_hash:
        "$argon2i$v=19$m=65536,t=6,p=1$UesGg1ht4/QLbCX93IqoYQ$ovrQXjSMwVv8xHyk/xccsEdsS+vgPONNPg+mINu61jY",
      role: "user",
      token: nil,
      updated_at: ~N[2019-04-21 21:02:29]
    }
  end

end
