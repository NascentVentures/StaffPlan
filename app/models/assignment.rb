class Assignment < ActiveRecord::Base
  
  has_many :work_weeks, dependent: :destroy do
    def for_range(lower, upper)
      if lower.cweek <= upper.cweek 
        self.where(year: lower.year, cweek: Range.new(lower.cweek,upper.cweek)) 
      else # The date range spans over two years 
        query = "(cweek >= ? AND year = ?) OR (cweek <= ? AND year = ?)"
        self.where(query, lower.cweek, lower.year, upper.cweek, upper.year)
      end
    end
  end
  
  belongs_to :project
  belongs_to :user
  
  validates_uniqueness_of :project_id, scope: :user_id, unless: Proc.new { |model| model.user_id.blank? } # TBD user
  validates_presence_of :project
end
