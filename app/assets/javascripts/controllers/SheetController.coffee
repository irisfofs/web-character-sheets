
statistics = {
  Level: { base_value: 1, expression: "" }
  Strength: { base_value: 10, expression: "" }
  Dexterity: { base_value: 10, expression: "" }
  Initiative: { base_value: 0, expression: "" }
}

controllers = angular.module('controllers')

controllers.controller("SheetController", [ "$scope", "$routeParams", "$parse", "$resource",
  ($scope, $routeParams, $parse, $resource)->
    Sheet = $resource('/sheets/:sheetId', { sheetId: "@id", format: 'json' })

    $scope.statistics = statistics

    if $routeParams.sheetId
      Sheet.get({ sheetId: $routeParams.sheetId },
        ( (sheet)-> $scope.character = sheet )
      )

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
