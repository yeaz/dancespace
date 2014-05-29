ThinkingSphinx::Index.define :studio, :with => :active_record do
  indexes :name, :sortable => true
  indexes :description
end
  
