module.exports = {
  test: /\.css$/,
  use: [{
    loader: 'style-loader!css-loader'
  }]
}