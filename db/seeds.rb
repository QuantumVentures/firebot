user = User.create!(
  email:      "john@gmail.com",
  first_name: "John",
  last_name:  "Doe",
  password:   "12"
)

app = user.apps.create!(
  description: "People can buy used cars from others",
  name:        "Used Car Marketplace",
  metadata: {
    application_id: "KH7KW0pOOZsu6gjmPfD4uL5yLCD8CLgRSIuqwnyb",
    api_key: "K5Uq0hecbVmf2ZYff1pW2wIgjj5bmjEqyBI0qGVy"
  }
)

model = app.models.new name: "Car"
model.add_column :condition, required: true, type: "string"
model.add_column :features, required: false, type: "array"
model.add_column :make, required: true, type: "string"
model.add_column :model, required: true, type: "string"
model.add_column :salvaged, required: true, type: "boolean"
model.add_column(:user,
  required: false, relationship_to: "User", type: "relation"
)
model.add_column :year, required: true, type: "number"
model.save!

token = user.access_tokens.create! tokenable: app
