projeto de quickstart para trabalhar com commits enriquecidos
====

Executar no bash os seguintes comandos:
```bash
yarn global add commitizen rimraf conventional-recommended-bump conventional-changelog-cli conventional-github-releaser conventional-commits-detector json

commitizen init cz-conventional-changelog --save-dev --save-exact

yarn add --dev husky conventional-changelog validate-commit-msg
```

Editar o package.json:

```json
 {
    "scripts": {
      "commitmsg": "validate-commit-msg"
    }
  }
```
na raiz do package.json colocar o conteúdo:

```json
"config": {
    "validate-commit-msg": {
      "types": [
        "feat",
        "fix",
        "docs",
        "style",
        "refactor",
        "perf",
        "test",
        "chore",
        "revert",
        "ci",
        "build"
      ],
      "warnOnFail": false,
      "maxSubjectLength": 100,
      "subjectPattern": ".+",
      "subjectPatternErrorMsg": "subject does not match subject pattern!",
      "helpMessage": ""
    },
    "commitizen": {
      "path": "./node_modules/cz-conventional-changelog"
    }
 }
```
