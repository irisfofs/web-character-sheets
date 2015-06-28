app = angular.module("webCharacterSheets",[
  "templates",
  "ngRoute",
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
        controller: "StatisticsController"
      )
      .otherwise(
        redirectTo: "/sheets/"
      )
])

controllers = angular.module("controllers", [])

characters = [
  {
    id: 1
    name: 'Baked Potato w/ Cheese'
  },
  {
    id: 2
    name: 'Garlic Mashed Potatoes',
  },
  {
    id: 3
    name: 'Potatoes Au Gratin',
  },
  {
    id: 4
    name: 'Baked Brussel Sprouts',
  },
]

# controllers = angular.module('controllers')

controllers.controller("IndexController", [ "$scope", "$routeParams", "$location",
  ($scope, $routeParams, $location)->
    $scope.search = (keywords)->
      console.log(keywords)
      $location.path("/sheets/").search('keywords',keywords)

    if $routeParams.keywords
      keywords = $routeParams.keywords.toLowerCase()
      $scope.characters = characters.filter (character)-> character.name.toLowerCase().indexOf(keywords) != -1
    else
      $scope.characters = []
])