projeto de quickstart para trabalhar com commits enriquecidos
====

Executar no bash os seguintes comandos:
```bash
yarn global add commitizen rimraf conventional-recommended-bump conventional-changelog-cli conventional-github-releaser conventional-commits-detector json

commitizen init cz-conventional-changelog --save-dev --save-exact

yarn add --dev husky conventional-changelog
```

Editar o package.json:

```json
 {
    "scripts": {
      "commitmsg": "conventional-changelog-lint -e"
    }
  }
```