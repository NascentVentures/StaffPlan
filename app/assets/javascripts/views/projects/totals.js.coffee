class window.StaffPlan.Views.Projects.Totals extends Backbone.View
  className: "grid-row-element fixed-60"
  tagName: "div"
    
  initialize: ->
    @weeks = @model.getWorkWeeks()
    
  render: ->
    hours = @weeks.reduce (memo, ww) ->
      memo.estimated += parseInt(ww.get('estimated_hours'), 10) || 0
      memo.actual += parseInt(ww.get('actual_hours'), 10) || 0
      memo
    , {estimated: 0, actual: 0}
    
    hours.delta = hours.estimated - hours.actual
    
    @$el.html StaffPlan.Templates.StaffPlans.assignment_totals
      hours: hours
    
    @