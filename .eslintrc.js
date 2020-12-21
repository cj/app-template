module.exports = {
  root: true,
  extends: ['airbnb-base', 'prettier'],
  // extends: ['airbnb-base'],
  parser: 'babel-eslint',
  rules: {
    semi: 'off',
  },
  globals: {
    Rails: true,
    Turbolinks: true,
  },
  env: {
    node: true,
    browser: true,
    jest: true,
  },
  overrides: [
    {
      files: ['*.config.js'],
      rules: {
        'no-param-reassign': 'off',
        'global-require': 'off',
        'import/no-extraneous-dependencies': 'off',
      },
    },
  ],
  settings: {
    'import/resolver': {
      alias: {
        map: [['~', './app/javascript']],
        extensions: ['.js', '.jsx', '.ts', '.tsx', '.json', 'js.erb'],
      },
      node: {
        extensions: ['.js', '.jsx', '.ts', '.tsx'],
      },
    },
  },
}
