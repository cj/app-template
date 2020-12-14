module.exports = {
  root: true,
  extends: ['airbnb-base', 'prettier'],
  rules: {
    semi: 'off',
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
}
