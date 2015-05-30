app = angular.module('app', [ 'ngMaterial', 'ngMessages', 'ngRoute' ]);

app.controller('oracleDbMonitorController', function($scope, $http, $log) {

	$scope.mySqlStr="";
	
//	$log.info("$scope.mySqlStr=[" + $scope.mySqlStr + "]");
	
	$scope.dbQuerySubmit = function() {
		$http.get("../dbAccess/get_oracle_data.jsp?sqlStr="+ $scope.mySqlStr).success(function(response) {
			$scope.empData = response;
			$scope.reverse = true;
		}).error(function() {
		});
	};
	
	$scope.clearSqlStr= function() {
		$scope.mySqlStr="";
	}
	
	$scope.clearResult= function() {
		$scope.empData="";
	}
});
