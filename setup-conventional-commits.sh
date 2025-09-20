#!/bin/bash

echo "🚀 Configuration des Conventional Commits..."

# Vérifier si npm est installé
if ! command -v npm &> /dev/null; then
    echo "❌ npm n'est pas installé. Veuillez installer Node.js d'abord."
    exit 1
fi

# Installer les dépendances
echo "📦 Installation des dépendances..."
npm install --save-dev @commitlint/cli @commitlint/config-conventional husky

# Créer le fichier de configuration commitlint
echo "⚙️ Création de la configuration commitlint..."
cat > commitlint.config.js << 'EOF'
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
EOF

# Initialiser husky
echo "🐶 Configuration de husky..."
npx husky install
npm pkg set scripts.prepare="husky install"

# Créer le hook commit-msg (version simplifiée)
echo "🪝 Création du hook de validation..."
mkdir -p .husky

cat > .husky/commit-msg << 'EOF'
npx --no -- commitlint --edit $1
EOF

chmod +x .husky/commit-msg

# Créer le template de commit (optionnel)
echo "📝 Création du template de commit..."
cat > .gitmessage << 'EOF'
# <type>[optional scope]: <description>
#
# [optional body]
#
# [optional footer(s)]
#
# Types disponibles:
# feat: nouvelle fonctionnalité
# fix: correction de bug
# docs: documentation
# style: formatage
# refactor: refactoring
# perf: performance
# test: tests
# chore: maintenance
# ci: intégration continue
# build: système de build
# revert: annulation
#
# Exemples:
# feat(auth): add login functionality
# fix(api): resolve user data fetching issue
# docs: update README with installation steps
EOF

# Configurer le template git pour l'utilisateur
read -p "Voulez-vous configurer le template de commit pour ce projet ? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    git config commit.template .gitmessage
    echo "✅ Template de commit configuré"
fi

echo ""
echo "✅ Configuration terminée !"
echo ""
echo "📋 Prochaines étapes pour l'équipe:"
echo "1. Chaque développeur doit exécuter: chmod +x setup-conventional-commits.sh && ./setup-conventional-commits.sh"
echo "2. Les commits non conformes seront automatiquement rejetés"
echo ""
echo "📖 Format des commits:"
echo "feat(scope): description"
echo "fix(scope): description"
echo "docs: description"
echo ""
echo "🔗 Plus d'infos: https://www.conventionalcommits.org/"