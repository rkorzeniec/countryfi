module.exports = {
  env: {
    browser: true,
    es2021: true
  },
  extends: [
    'standard'
  ],
  parserOptions: {
    ecmaVersion: 12,
    sourceType: 'module'
  },
  rules: {
  },
  settings: {
    'import/resolver': {
      webpack: {
        config: {
          resolve: {
            modules: ['app/javascript', 'node_modules'],
          },
        },
      },
    },
  },
}
