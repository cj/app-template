const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')

const sassLoader = environment.loaders.get('sass')

sassLoader.use = [
  ...sassLoader.use,
  {
    loader: 'sass-resources-loader',
    options: {
      resources: ['./app/javascript/stylesheets/global.scss'],
    },
  },
]

environment.loaders.prepend('erb', erb)
module.exports = environment
