app = angular.module("webCharacterSheets",[
  "templates",
  "ngRoute",
  "ngResource",
  "controllers"
])

app.config([ "$routeProvider",
  ($routeProvider)->
    $routeProvider
      .when("/sheets/",
        templateUrl: "index.html"
        controller: "IndexController"
      )
      .when("/sheets/:sheetId",
        templateUrl: "sheet.html"
        controller: "SheetController"
      )
      .otherwise(
        redirectTo: "/sheets/"
      )
])

controllers = angular.module("controllers", [])
