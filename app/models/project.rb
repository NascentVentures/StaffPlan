class Project < ActiveRecord::Base
  include StaffPlan::AuditMethods
  has_paper_trail

  attr_accessible :name, :active

  belongs_to  :client
  belongs_to  :company

  has_many :work_weeks, dependent: :destroy do
    def for_user(user)
      self.select { |ww| ww.user_id == user.id }
    end

    def for_user_and_cweek_and_year(user, cweek, year)
      self.for_user(user).detect { |ww| ww.cweek == cweek && ww.year == year }
    end
  end

  has_many :assignments, :dependent => :destroy
  has_many :users, :through => :assignments


  after_update :update_originator_timestamp

  validates_presence_of :name, :client
  validates_uniqueness_of :name, case_sensitive: false, scope: :client_id

  default_scope(order: "client_id ASC, name ASC")

  def proposed_for_user?(user)
    assignments.where(user_id: user.id).first.try(:proposed?) || false
  end

  def work_week_totals_for_date_range(lower, upper)
    # FIXME: The initial hash we're tapping should be pre-filled so that we never get any hash lookup failure
    {}.tap do |grouped|
      WorkWeek.for_project_and_date_range(self, lower, upper).group_by(&:year).each do |year, weeks|
        totals = {}.tap do |totals| 
          weeks.group_by(&:cweek).each do |iso_week, weeks| 
            totals.store(iso_week, weeks.inject({:proposed => 0, :actuals => 0}) do |total, week|
              total[week.proposed? ? :proposed : :actuals] += (week.send((Date.today.cweek >= iso_week) ? :actual_hours : :estimated_hours) || 0)
              total
            end)
          end
        end
        grouped.store(year, totals)
      end
    end
  end
end
