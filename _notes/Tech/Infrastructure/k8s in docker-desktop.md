---
tags: mac,docker-desktop,k8s,skaffold
title: k8s in docker-desktop
categories: Tech
---

## Install nginx ingress 

```bash
helm install --namespace kube-system nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx
```