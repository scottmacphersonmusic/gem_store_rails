//= require_self
//= require gemstore_app/store_ctrl
//= require gemstore_app/products
//= require gemstore_app/review_ctrl

(function() {
  window.GemStoreInstance = angular.module('gemStore', ['store-directives']);

  GemStoreInstance.config(['$httpProvider', function($httpProvider){
    $httpProvider.defaults.headers.common['X-CSRF-Token'] =
      document.querySelector('meta[name=csrf-token]').content;
    $httpProvider.defaults.headers.common.Accept =
      'application/json';
  }]);
})();
