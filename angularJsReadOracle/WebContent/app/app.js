app = angular.module('app', []);

app.controller('MyCtrl', function($scope, $http) {
	
	$http.get("../views/get_oracle_data.jsp").success(function(response) {
		
		$scope.empData = response;
		$scope.reverse = true;
		
	}).error(function() {
	});

});