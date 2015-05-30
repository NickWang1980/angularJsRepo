app = angular.module('appNgMaterials', [ 'ngMaterial', 'ngMessages', 'ngRoute' ]);

app.controller('ngMaterialsCtrl', function($scope, $http) {
	$scope.user = {
			title : 'Developer',
			email : 'nickwang1980@gmail.com',
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
