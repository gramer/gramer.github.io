---
tags: github,jekyll 
title: Jekyll
categories: Productivity
---

# Todo

- [x] Install jekyll
- [x] Run jekyll in local
- [x] Deploy to github (gramer.github.io)
- [ ] Design categories
- [ ] Apply Obsidian Jekyll workflow

---

- [ ] Apply dark theme
- [ ] Apply relative link
- [ ] Expose to google search

# Install

[github pages](https://rubygems.org/gems/github-pages) 에서 의존성을 확인하고 Gemfile 을 업데이트 한다.

```shell
# ruby 환경 설정
rbenv install 2.7.4
rbenv global 2.7.4
rbenv rehash

# jekyll 설치 및 프로젝트 초기화
gem install --user-install bundler jekyll

# 기존 파일이 있는 곳이면 --force 
jekyll new --skip-bundle . --force

# Gemfile 를 열어서 github page 활성화 

bundle install
```

# Test

Makefile 을 만들어서 로컬 테스트 Run 을 쉽게 사용하자.

```make
TAG="\n\n\033[0;32m\#\#\# "  
END=" \#\#\# \033[0m\n"  
  
.PHONY: setup  
jekyll-local: ## run jekyll-local  
 @echo ${TAG}starting${END}  
 @bundle exec jekyll serve  
 @echo ${TAG}completed${END}  
  
.PHONY: help  
help:  
   @grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \  
 awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'  
  
  
.DEFAULT_GOAL = help
```

# Issues

- jekyll plugin 은 github 에서는 실행되지 않는다. 따라서 [Github Action](https://github.com/jeffreytse/jekyll-deploy-action) 을 통해 처리한다.

# References

- [Jekyll on macOS](https://jekyllrb.com/docs/installation/macos/)
- [jekyll 실행 시킬 때 webrick 관련 오류](https://junho85.pe.kr/1850)
- [rbenv환경에서 Jekyll 블로그 생성하고 GitHub Pages에 배포하기](https://lhy.kr/create-jekyll-blog-using-rbenv-and-github-pages)
- [Fully Functional Jekyll Blog](https://www.sitepoint.com/fully-functional-jekyll-blog/)
- [올리브영 기술블로그 개발기](https://tech.oliveyoung.co.kr/tech/2011091042/)
- [올리브영 기술블로그 소스](https://github.com/oy-alldev/oy-alldev.github.io)
- [Obsidian Jekyll workflow](https://refinedmind.co/obsidian-jekyll-workflow)
  - [netlify](https://app.netlify.com/)
