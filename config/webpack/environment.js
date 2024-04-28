const { environment } = require('@rails/webpacker');

// Add support for .jsx and .js files using Babel
const babelLoader = environment.loaders.get('babel');
babelLoader.test = /\.(js|jsx)$/;

// Add Babel presets
babelLoader.options.presets = [
  ['@babel/preset-env', { targets: { node: 'current' } }]
];

module.exports = environment;
