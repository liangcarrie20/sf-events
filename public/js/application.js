$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them
  var userList = new List('budget-list', {
  valueNames: ['name'],
  plugins: [ ListFuzzySearch() ]
});

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
});
