ThinkingSphinx::Index.define :event, :with => :active_record do
  indexes :name, :sortable => true
  indexes :description
end
