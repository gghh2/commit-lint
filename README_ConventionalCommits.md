markdown# Configuration Conventional Commits

## Installation automatique

### Linux/Mac:
```bash
chmod +x setup-conventional-commits.sh
./setup-conventional-commits.sh




### Windows:
bashsetup-conventional-commits.bat

Format des commits
<type>[scope]: <description>

[optional body]

[optional footer]




Types principaux:

feat: nouvelle fonctionnalité
fix: correction de bug
docs: documentation
refactor: refactoring
test: tests
chore: maintenance

Exemples:
feat(auth): add JWT authentication
fix(api): resolve null pointer exception
docs: update installation guide
refactor(user): simplify validation logic
Les commits non conformes sont automatiquement rejetés.

### 4. Ajout au package.json (création automatique)

Le script ajoutera automatiquement dans `package.json` :
```json
{
  "scripts": {
    "prepare": "husky install",
    "setup-commits": "./setup-conventional-commits.sh"
  }
}