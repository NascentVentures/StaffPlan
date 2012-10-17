class StaffPlan.Models.WeeklyAggregate extends Backbone.Model
  initialize: (options) ->
    @cweek = options.cweek
    @year = options.year
    @weeks = options.weeks

    @values = _.reduce @weeks, (values, elem) ->
      values['estimated'] += parseInt(elem.get "estimated_hours", 10) || 0
      values['actual'] += parseInt(elem.get "actual_hours", 10) || 0
      values['proposed'] += parseInt(elem.get "estimated_hours", 10) if elem.collection.parent.get("proposed")
      
      values
    , {estimated: 0, actual: 0, proposed: 0}
