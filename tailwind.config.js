/* eslint-disable global-require */
const hexRgb = require('hex-rgb')
const tailwindColorPalette = require('@ky-is/tailwind-color-palette')
const R = require('ramda')

const extensions = 'js,ts,jsx,tsx,css,scss,erb,html'

const colorTypes = [
  'primary',
  'gray',
  'blue',
  'teal',
  'green',
  'yellow',
  'orange',
  'red',
  'pink',
  'purple',
  'indigo',
]

function rgba(hex, alpha) {
  const { red, green, blue } = hexRgb(hex)
  return `rgba(${red}, ${green}, ${blue}, ${alpha})`
}

function twColor(hex) {
  return tailwindColorPalette(hex).brand
}

const colors = {
  primary: twColor('#2B71B1'),
}

const content = ['app/views', 'app/javascript'].map(
  (purgeFolder) => `./${purgeFolder}/**/*.{${extensions}}`
)

const isProduction = process.env.NODE_ENV === 'production'

module.exports = {
  important: true,

  future: {
    removeDeprecatedGapUtilities: true,
    purgeLayersByDefault: true,
  },

  purge: {
    content,

    enabled: isProduction,

    // These options are passed through directly to PurgeCSS
    options: {
      whitelistPatterns: [/uppy.*/, /text-.*/],

      whitelist: ['html', 'body', '__next', ':global', 'uppy'],

      defaultExtractor: (string) => {
        // matches patterns like bg-${color}-500
        const matches = R.flatten(
          (
            string.match(
              /[^\s"#%'().<=>[\]`{}]*[^\s"#%'().:<=>[\]`{}](\w+-\${\w+}-\d+|\w+-\w+-\${\w+})/g
            ) || []
          ).map((record) => {
            const colorMatches = []

            colorTypes.forEach((color) => {
              colorMatches.push(record.replace(/\${\w+}/g, color))
            })

            return colorMatches
          })
        )

        return matches.concat(string.match(/[\w/:-]+/g) || [])
      },
    },
  },
  theme: {
    screens: {
      // 'md-down': { max: '1023px' },
      // 'lg-down': { max: '1279px' },
      'sm-only': { max: '767px' },
      'md-only': { min: '768px', max: '1023px' },
      'lg-only': { min: '1024px', max: '1279px' },
      'xl-only': { min: '1280px', max: '1535px' },
      '2xl-only': { min: '1526px' },
      sm: '640px',
      md: '768px',
      lg: '1024px',
      xl: '1280px',
      '2xl': '1536px',
    },
    extend: {
      colors,
      boxShadow: {
        'outline-primary': `0 0 0 3px ${rgba(colors.primary[300], 0.45)}`,
        solid: '0 0 0 2px currentColor',
        outline: `0 0 0 3px rgba(156, 163, 175, .5)`,
        'outline-gray': `0 0 0 3px rgba(254, 202, 202, .5)`,
        'outline-blue': `0 0 0 3px rgba(191, 219, 254, .5)`,
        'outline-green': `0 0 0 3px rgba(167, 243, 208, .5)`,
        'outline-yellow': `0 0 0 3px rgba(253, 230, 138, .5)`,
        'outline-red': `0 0 0 3px rgba(254, 202, 202, .5)`,
        'outline-pink': `0 0 0 3px rgba(251, 207, 232, .5)`,
        'outline-purple': `0 0 0 3px rgba(221, 214, 254,, .5)`,
        'outline-indigo': `0 0 0 3px rgba(199, 210, 254, .5)`,
      },
      padding: {
        '1/2': '50%',
        '1/3': '33.333333%',
        '2/3': '66.666667%',
        '1/4': '25%',
        '2/4': '50%',
        '3/4': '75%',
        '1/5': '20%',
        '2/5': '40%',
        '3/5': '60%',
        '4/5': '80%',
        '1/6': '16.666667%',
        '2/6': '33.333333%',
        '3/6': '50%',
        '4/6': '66.666667%',
        '5/6': '83.333333%',
        '1/12': '8.333333%',
        '2/12': '16.666667%',
        '3/12': '25%',
        '4/12': '33.333333%',
        '5/12': '41.666667%',
        '6/12': '50%',
        '7/12': '58.333333%',
        '8/12': '66.666667%',
        '9/12': '75%',
        '10/12': '83.333333%',
        '11/12': '91.666667%',
        full: '100%',
      },
      typography: {
        DEFAULT: {
          css: {
            'h1:first-child': {
              marginTop: '0',
            },
            'h2:first-child': {
              marginTop: '0',
            },
            'h3:first-child': {
              marginTop: '0',
            },
            'h4:first-child': {
              marginTop: '0',
            },
            'h5:first-child': {
              marginTop: '0',
            },
            'h6:first-child': {
              marginTop: '0',
            },
            'p:last-child': {
              marginBottom: '0',
            },
            // ...
          },
        },
      },
    },
  },
  variants: {
    margin: ['responsive', 'last', 'hover', 'focus'],
    extend: {
      backgroundColor: ['group-focus', 'active'],
      borderColor: ['group-focus'],
      boxShadow: ['group-focus'],
      opacity: ['group-focus'],
      textColor: ['group-focus', 'active'],
      textDecoration: ['group-focus'],
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/aspect-ratio'),
    require('tailwindcss-debug-screens'),
  ],
}
