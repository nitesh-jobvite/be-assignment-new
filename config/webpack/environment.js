const { environment } = require('@rails/webpacker');

// Check if the babel loader exists
const babelLoader = environment.loaders.get('babel');

if (babelLoader) {
  // Modify babel loader to support .jsx and .js files
  babelLoader.test = /\.(js|jsx)$/;

  // Set Babel presets
  babelLoader.use[0].options.presets = [
    ['@babel/preset-env', { targets: { node: 'current' } }]
  ];
} else {
  console.error('Babel loader not found in webpack environment configuration.');
}

module.exports = environment;
