ThinkingSphinx::Index.define :video, :with => :active_record do
  indexes :title, :sortable => true
  indexes :description
end
