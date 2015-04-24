# User
#-------------------------------------------------------------------------------
user = User.create!(
  email:      "john@gmail.com",
  first_name: "John",
  last_name:  "Doe",
  password:   "12"
)

# Backend app
#-------------------------------------------------------------------------------
app = user.apps.create!(
  description: "People can buy used cars from others",
  name:        "Used Car Marketplace",
  metadata: {
    application_id: "KH7KW0pOOZsu6gjmPfD4uL5yLCD8CLgRSIuqwnyb",
    api_key: "K5Uq0hecbVmf2ZYff1pW2wIgjj5bmjEqyBI0qGVy"
  }
)

# Model
#-------------------------------------------------------------------------------
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

# Components
#-------------------------------------------------------------------------------
# Users
component_users = Component.create! name: "Users",
  description: "Store user information and login credentials."
user_model = Model.new name: "User"
user_model.add_column :email, required: true, type: "string"
user_model.add_column :first_name, type: "string"
user_model.add_column :last_name, type: "string"
user_model.add_column :password, required: true, type: "string"
user_model.add_column :phone_number, type: "string"
component_users.add_model user_model
component_users.save!

# Authentication
component_auth = Component.create! name: "Authentication",
  description: "Give access tokens for users to interact with your app."
auth_model = Model.new name: "Authentication"
auth_model.add_column :expires_at, required: true, type: "date"
auth_model.add_column :token, required: true, type: "string"
auth_model.add_column :user, required: true, relationship_to: "User",
                             type: "relation"
component_auth.add_model auth_model
component_auth.save!
# Composition
component_auth.compositions.create! composable: component_users

# Feedback
feedback = Component.create! name: "Feedback",
  description: "Allow your users to give feedback."
feedback_model = Model.new name: "Feedback"
feedback_model.add_column :body, required: true, type: "string"
feedback_model.add_column :email, type: "string"
feedback.add_model feedback_model
feedback.save!


# Backend app components
#-------------------------------------------------------------------------------
app.add_component component_auth
app.add_component feedback
