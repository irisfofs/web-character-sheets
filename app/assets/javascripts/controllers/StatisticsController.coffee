
statistics = {
  Level: { base_value: 1, expression: "" }
  Strength: { base_value: 10, expression: "" }
  Dexterity: { base_value: 10, expression: "" }
  Initiative: { base_value: 0, expression: "" }
}

controllers = angular.module('controllers')

controllers.controller("IndexController", [ "$scope", "$routeParams", "$location",
  ($scope, $routeParams, $location)->
    $scope.addStatistic = (keywords)->  $location.path("/").search('keywords',keywords)

    $scope.statistics = statistics
    if $routeParams.keywords
      keywords = $routeParams.keywords
      $scope.statistics[keywords] = {
          base_value: 1
          expression: ""
        }
])

controllers.controller("StatisticController", [ "$scope", "$parse",
  ($scope, $parse)->
    $scope.statistics = statistics

    process = (expr)->
      expr.replace(/[a-zA-Z]+/g, (ref)-> 'compute("' + ref + '")')

    $scope.compute = (name)->
      stat = $scope.statistics[name]
      parsed_mod = $parse(process($scope.statistics[name].expression))($scope)
      if parsed_mod == undefined
        stat.base_value
      else
        stat.base_value + parseFloat(parsed_mod, 10)
])
