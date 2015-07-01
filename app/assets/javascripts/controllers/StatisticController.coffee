controllers = angular.module('controllers')

secondsToWaitBeforeSave = 2;

controllers.controller("StatisticController", [ "$scope", "$routeParams", "$resource", "$timeout",
  ($scope, $routeParams, $resource, $timeout)->
    Statistic = $resource("/sheets/:sheetId/statistics/:statisticId",
      { sheetId: "@sheetId", statisticId: "@id", format: "json" },
      {
        'save':   {method:'PUT'},
        'create': {method:'POST'}
      }
    )

    timeout = null
    saveUpdates = ()->
      # Save stuff to server...
      if $scope["statistic_" + $scope.statistic.name + "_form"].$valid
        console.log("Saving updates to " + ($scope.statistic.name) + "...", $scope.statistic)
        Statistic.save({ sheetId: $scope.character.id }, $scope.statistic)
      else
        console.log("Tried to save updates to " + ($scope.statistic.name) + " but the form is invalid.")

    debounceUpdate = (newVal, oldVal)->
      if newVal != oldVal
        if timeout
          $timeout.cancel(timeout);
        timeout = $timeout(saveUpdates, secondsToWaitBeforeSave * 1000);

    $scope.$watch("statistic.base_value", debounceUpdate)
    $scope.$watch("statistic.expression", debounceUpdate)
])

