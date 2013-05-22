/**
 * RequireJS configuration
 */
require.config({

  // Initialize the application with the main application file and the
  // console-stub from HTML5 Boilerplate
  deps: ['console', 'jquery', 'hashgrid', 'main'],

  paths: {
    'jquery': '../../../src/vendor/jquery/jquery',
    'hashgrid': '../../../src/vendor/hashgrid/hashgrid'
    // More additional paths here
  },

  shim: {
    // If you need to shim anything
  }

});
