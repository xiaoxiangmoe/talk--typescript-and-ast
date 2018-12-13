workflow "Publish GitHub Pages" {
  on = "push"
  resolves = ["publish"]
}

action "Filters for GitHub Actions" {
  uses = "actions/bin/filter@e96fd9a"
  args = "branch master"
}

action "Install dependencies" {
  uses = "nuxt/actions-yarn@node-11"
  args = "install --frozen-lockfile"
  needs = ["Filters for GitHub Actions"]
}

action "Build Project" {
  uses = "nuxt/actions-yarn@node-11"
  args = "run build"
  needs = ["Install dependencies"]
}

action "publish" {
  uses = "xiaoxiangmoe/gh-pages-action@master"
  needs = ["Build Project"]
  secrets = ["GITHUB_TOKEN"]
  args = "--dist=dist --user=\"ZHAO Jinxiang <xiaoxiangmoe@gmail.com>\""
}
