def user_list
  return [
    {
      first_name: "brian",
      last_name: "welch",
      email: "brian.c.welch@gmail.com",
      password: "12345678",
      birthdate: "1974/12/10",
      weight: 94,
      active: true,
      gender: "m",
      role: "admin"
    },
    {
      first_name: "niels",
      last_name: "hemmingsen",
      email: "nhe@boozt.com",
      password: "87654321",
      birthdate: "1962/01/01",
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
