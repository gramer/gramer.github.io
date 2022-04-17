---
tags: mac
title: Mac 설정하기
categories: Tech
---

## Requirements

- [x] dotfiles 최신화
- [x] Check ausus portal monitor
- [x] Check docker 
- [x] jenv 대신 sdkman 을 사용해 보자

## Dotfiles

- 사용하지 않는 brew 삭제
- mas 를 이용하여 설치

## Obsidian

### Consideration

- 여러 맥북에서 Obsidian 을 사용한다.
- 중요 문서는 Git 으로 백업하고 공유한다.
  - .obsidian 폴더에서 Plugin 을 공유하여 사용한다.
  - .obsidian/workspace 에서는 공유하지 않는다. 
- 중요 하지 않는 문서는 Google Drive 로 관리한다. (개인용 맥북에서만 적용)


## Manual Works

- tmux plugin 은 설치
- navi-cheats repo add

## Issues

- [ ] alfred: macOCR 이 동작 안함
- [x] brew: brew 설치 시에 m1 은 경로가 다르다. brew doctor를 통해서 .zshrc 파일에 경로 추가
	- [[Mac] M1 Mac에 HomeBrew 설치하기](https://cloudest.oopy.io/posting/043)
- [x] tmux: tmux-fzf-url 동작 안함.
	- bash 파일을 /usr/loca/bin 으로 이동해 준다.
- [x] java 에서 dns 이슈 (netty library.로 해결)
	- Unable to load io.netty.resolver.dns.macos.MacOSDnsServerAddressStreamProvider

	