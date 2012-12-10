_t =
  application: """
  <header>
    <div class='inner'>
      <ul>
        <li id="nav-my-staff-plan"><a href="/staffplans/{{currentUser.id}}">My StaffPlan</a></li>
        <li id="nav-all-staff"><a href="/staffplans">All StaffPlans</a></li>
        <li id="nav-clients"><a href="/clients">Clients</a></li>
        <li id="nav-projects"><a href="/projects">Projects</a></li>
        <li>
          <form class='quick-jump'>
            <input type="text" class="input search-query header-typeahead" placeholder="Client, Project or User" />
          </form>
        </li>
      </ul>
      <div class='pull-right'>
        <a href="mailto:staffplan-feedback@goinvo.com?subject=StaffPlan%20Feedback">Feedback</a>
        <a href="/sign_out" data-bypass>Sign Out</a>
      </div>
    </div>
  </header>
  <section class='main'></section>
  <footer>
    <a href="https://github.com/rescuedcode/StaffPlan" target="_blank">Github Repo</a>
    <a href="" target="_blank">Pivotal Tracker</a>
    <a href="http://goinvo.com" target="_blank">created by Involution Studios</a>
  </footer>
  """
  
StaffPlan.Templates.Layouts =
  application: Handlebars.compile _t.application