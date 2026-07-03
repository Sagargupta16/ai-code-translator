import coreWebVitals from 'eslint-config-next/core-web-vitals';

const config = [
  ...coreWebVitals,
  {
    ignores: ['.next/**', 'node_modules/**'],
  },
  {
    rules: {
      // ponytail: existing localStorage/retranslate effects predate this rule
      'react-hooks/set-state-in-effect': 'warn',
    },
  },
];

export default config;
