app = angular.module('app', [ 'ngMaterial', 'ngMessages', 'ngRoute' ]);

app.controller('MyCtrl', function($scope, $http) {

	$http.get("../views/get_oracle_data.jsp").success(function(response) {

		$scope.empData = response;
		$scope.reverse = true;

	}).error(function() {
	});
	
	$scope.user = {
			title : 'Developer',
			email : 'ipsum@lorem.com',
			firstName : '',
			lastName : '',
			company : 'Google',
			address : '1600 Amphitheatre Pkwy',
			city : 'Mountain View',
			state : 'CA',
			biography : 'Loves kittens, snowboarding, and can type at 130 WPM.\n\nAnd rumor has it she bouldered up Castle Craig!',
			postalCode : '94043'
		};

}).config(
		function($mdThemingProvider) {
			// Configure a dark theme with primary foreground yellow
			$mdThemingProvider.theme('docs-dark', 'default')
					.primaryPalette('yellow').dark();
		});
