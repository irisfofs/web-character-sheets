app = angular.module("webCharacterSheets",[
  "templates",
  "ngRoute",
  "controllers"
])

app.config([ "$routeProvider",
  ($routeProvider)->
    $routeProvider
      .when("/",
        templateUrl: "index.html"
        controller: "IndexController"
      )
])

controllers = angular.module("controllers", [])
