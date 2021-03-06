class CreateAdminService
  def call
   user = User.find_or_create_by!(email: "admin@asianh.com") do |user|
      user.name = Rails.application.secrets.admin_name
      user.password = Rails.application.secrets.admin_password
      user.password_confirmation = Rails.application.secrets.admin_password
      user.confirmed_at = DateTime.now
      user.team_admin!
    end
  end
end
