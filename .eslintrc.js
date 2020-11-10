module.exports = {
  extends: ["eslint-config-airbnb-base", "plugin:prettier/recommended"],
  env: {
    browser: true,
    es2021: true,
  },
  parserOptions: {
    ecmaVersion: 12,
    sourceType: "module",
  },
  rules: {},
  settings: {
    "import/resolver": {
      webpack: {
        config: {
          resolve: {
            modules: ["app/javascript", "node_modules"],
          },
        },
      },
    },
  },
};
