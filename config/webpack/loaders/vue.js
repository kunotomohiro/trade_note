module.exports = {
  test: /\.vue(\.erb)?$/,
  use: [{
    loader: 'vue-loader'
  }],
  test: /\.css$/,
  use: [{
    loader: 'style-loader!css-loader'
  }],
  test: /\.(otf|eot|svg|ttf|woff|woff2)(\?.+)?$/,
  use: [{
    loader: 'url-loader'
  }]
}
