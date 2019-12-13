def user_list
  return [
    {
      first_name: "Brian",
      last_name: "Welch",
      email: "brian.c.welch@gmail.com",
      password: "64206420",
      birthdate: "1974/12/10",
      weight: 94,
      active: true,
      gender: "m",
      role: "admin"
    },
    {
      first_name: "Jack",
      last_name: "Schmitt",
      email: "jack@bobshouse.com",
      password: "87654321",
      birthdate: "1972/01/01",
      weight: 80,
      active: false,
      gender: "m",
      role: "user"
    },
    {
      first_name: "John",
      last_name: "Doe",
      email: "demo@demo.com",
      password: "23456789",
      birthdate: "1970/01/01",
      weight: 85,
      active: false,
      gender: "m",
      role: "user"
    }
  ]
end
