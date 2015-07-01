controllers = angular.module('controllers')

controllers.controller("SheetController", [ "$scope", "$routeParams", "$parse", "$resource", "$timeout",
  ($scope, $routeParams, $parse, $resource, $timeout)->
    Sheet = $resource('/sheets/:sheetId', { sheetId: "@id", format: 'json' },
      {
        'save':   {method:'PUT'},
        'create': {method:'POST'}
      }
    )
    Statistic = $resource("/sheets/:sheetId/statistics/:statisticId",
      { sheetId: "@sheetId", statisticId: "@id", format: "json" },
      {
        'save':   {method:'PUT'},
        'create': {method:'POST'}
      }
    )

    if $routeParams.sheetId
      Sheet.get({ sheetId: $routeParams.sheetId },
        ( (sheet)->
          $scope.character = sheet
          # Convert the array of statistics into a map by name
          stat_map = {}
          for stat in $scope.character.statistics
            stat_map[stat.name] = stat
          $scope.character.statistics = stat_map
        )
      )

    process = (expr)->
      expr.replace(/[a-zA-Z]+/g, (ref)-> 'compute("' + ref + '")')

    $scope.compute = (name)->
      stat = $scope.character.statistics[name]
      parsed_mod = $parse(process($scope.character.statistics[name].expression))($scope)
      if parsed_mod == undefined
        stat.base_value
      else
        stat.base_value + parseFloat(parsed_mod, 10)

    $scope.addStatistic = (statName)->
      Statistic.create({ sheetId: $scope.character.id, name: statName, base_value: 0, expression: "" },
        ( (newStatistic)-> $scope.character.statistics[newStatistic.name] = newStatistic )
        # TODO: Error check duplicate statistic names
      )
])
