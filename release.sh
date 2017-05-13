# Script para criacao de releases 
#
# pre-requisitos:
# `yarn install -g rimraf conventional-recommended-bump conventional-changelog-cli conventional-github-releaser conventional-commits-detector json`
#  voce sobrescrever a detecção do tipo de release executando o segundo argumento opcional
#  sh release.sh `patch`/`minor`/`major`/`<version>`
# por padrão ele utililiza o conventional-recommended-bump
# uma segunda opção é escolher o preset (metodo de deteção de mudança de versão) `angular`/ `jquery` ...
# defaults to conventional-commits-detector
#
# For release setup token authentication (https://github.com/conventional-changelog/conventional-github-releaser)

# Create release script
#
# prerequisites:
# `yarn install -g rimraf conventional-recommended-bump conventional-changelog-cli conventional-github-releaser conventional-commits-detector json`
#
# `np` with optional argument `patch`/`minor`/`major`/`<version>`
# defaults to conventional-recommended-bump
# and optional argument preset `angular`/ `jquery` ...
# defaults to conventional-commits-detector
#
# For release setup token authentication (https://github.com/conventional-changelog/conventional-github-releaser)
echo "entrando no branch develop"
git checkout develop 
echo "enviando conteudo em staging para o repositório"
git push &&
echo "Apagando node_modules" &&
rimraf node_modules &&
echo "git pull --rebase" &&
git pull --rebase &&
echo "yarn install" &&
yarn install &&
echo "yarn test" &&
yarn test &&
cp package.json _package.json &&
preset=$(conventional-commits-detector) &&
echo ${2:-$preset} &&
bump=$(conventional-recommended-bump -p ${2:-$preset}) &&
echo ${1:-$bump} &&
npm --no-git-tag-version version ${1:-$bump} &&
conventional-changelog -i CHANGELOG.md -s -p ${2:-$preset} &&
git add CHANGELOG.md &&
version=$(json -f package.json version) &&
echo ${3:-$version} &&
git commit -m"docs(CHANGELOG): $version" &&
mv -f _package.json package.json &&
git flow release start $version
npm version ${1:-$bump} -m "chore(release): %s" &&
conventional-github-releaser -p ${2:-$preset} &&
git checkout develop && 
git merge --no-ff --no-edit release/$version &&
git checkout master &&
git merge --no-ff --no-edit release/$version &&
git push origin develop master --follow-tags
git checkout develop
git branch -D release/$version