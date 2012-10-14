window.StaffPlan =
  Models: {}
  Collections: {}
  Views:
    Shared: {}
    StaffPlans:
      Client: {}
      WorkWeeks: {}
      Assignments: {}
    Users: {}
    Projects: {}
    Clients: {}
  Routers: {}
  
  initialize: (data) ->
    @users = new StaffPlan.Collections.Users data.users
    @projects = new StaffPlan.Collections.Projects data.projects
    @clients = new StaffPlan.Collections.Clients data.clients
    @currentCompany = data.currentCompany

    new StaffPlan.Routers.StaffPlan
      users: @users
      projects: @projects
      clients: @clients
      currentCompany: @currentCompany
    
    $ -> Backbone.history.start(pushState: true)
    
    $('a:not([data-bypass])').live 'click', (event) =>
      event.preventDefault()
      href = $(event.currentTarget).attr('href').slice(1)
      Backbone.history.navigate(href, true)
  
  addClientByName: (name, callback) ->
    @clients.create
      name: name
    ,
      success: callback
      
  addProjectByNameAndClient: (name, client, callback) ->
    @projects.create
      name: name
      client_id: client.get('id')
    ,
      success: callback