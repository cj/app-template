module.exports = {
  extends: [
    'stylelint-config-recommended',
    'stylelint-prettier/recommended',
    'stylelint-config-prettier',
  ],
  rules: {
    'prettier/prettier': true,
    'string-quotes': 'single',
    'selector-pseudo-class-no-unknown': [
      true,
      {
        ignorePseudoClasses: ['global'],
      },
    ],
    'at-rule-no-unknown': [
      true,
      {
        ignoreAtRules: [
          'function',
          'if',
          'each',
          'include',
          'mixin',
          'return',
          'tailwind',
          'responsive',
          'type',
          'element',
          'screen',
          'themesFolder',
        ],
      },
    ],
  },
}
