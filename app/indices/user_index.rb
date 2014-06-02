ThinkingSphinx::Index.define :user, :with => :active_record do
  indexes :first_name, :sortable => true
  indexes :last_name, :sortable => true
  indexes :email
end
