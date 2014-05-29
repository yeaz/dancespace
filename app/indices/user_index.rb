ThinkingSphinx::Index.define :user, :with => :active_record do
  indexes :first_name, :sortable => true
  indexes :username, :sortable => true
  indexes :email
end
