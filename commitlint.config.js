module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat',     // nouvelle fonctionnalité
        'fix',      // correction de bug
        'docs',     // documentation
        'style',    // formatage
        'refactor', // refactoring
        'perf',     // amélioration des performances
        'test',     // ajout/modification de tests
        'chore',    // tâches de maintenance
        'ci',       // intégration continue
        'build',    // système de build
        'revert'    // annulation de commit
      ]
    ],
    'subject-max-length': [2, 'always', 72],
    'subject-case': [2, 'always', 'lower-case'],
    'subject-empty': [2, 'never'],
    'type-empty': [2, 'never']
  }
};
