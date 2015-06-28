controllers = angular.module('controllers')

controllers.controller("IndexController", [ "$scope", "$routeParams", "$location", "$resource"
  ($scope, $routeParams, $location, $resource)->
    $scope.search = (keywords)-> $location.path("/sheets/").search('keywords',keywords)
    Sheet = $resource('/sheets/:sheetId', { sheetId: "@id", format: 'json' })

    if $routeParams.keywords
      Sheet.query(keywords: $routeParams.keywords, (results)-> $scope.characters = results)
    else
      $scope.characters = []
])