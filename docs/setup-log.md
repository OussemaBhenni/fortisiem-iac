# Journal technique — Mise en place de l'environnement (P1)

Stage Teamwill · 19 juin 2026

## Contexte

Suite à l'échange avec le tuteur (22/6) :
- Déploiement 100% local pour le moment, migration vers Azure prévue plus tard.
- Licence FortiSIEM fournie par le tuteur, attendue la semaine prochaine.
- Décision : démarrer la phase P1 (Setup & étude) sans attendre la licence.

## Environnement de travail

WSL2 (Ubuntu 24.04 "noble") sous Windows. Repo conservé sur le disque Windows,
dans `D:\Other Works\fortisiem-iac`, accessible depuis WSL via
`/mnt/d/Other Works/fortisiem-iac`.

## Outils installés

| Outil | Version installée | Minimum requis |
|---|---|---|
| Docker | 29.6.0 | 24+ |
| Terraform | 1.15.6 | 1.5+ |
| Ansible (core) | 2.16.3 | 2.15+ |

## Problèmes rencontrés et solutions

| # | Problème | Cause | Solution appliquée |
|---|---|---|---|
| 1 | Terraform et Ansible absents après la première installation | Le bloc de commandes a été partiellement collé dans le terminal : seul le bloc Docker s'est exécuté | Ré-exécution des blocs Terraform et Ansible séparément, un à la fois |
| 2 | Chemin de travail Windows avec espace (`D:\Other Works\fortisiem-iac`) | Sous WSL, un chemin contenant un espace casse les commandes bash si non protégé | Guillemets systématiques : `"/mnt/d/Other Works/fortisiem-iac"` |
| 3 | Échec de `docker.service` ("Interactive authentication required") | `systemctl start docker` lancé sans `sudo` ; WSL ne gère pas l'authentification interactive de polkit | Préfixer systématiquement les commandes systemctl par `sudo` |
| 4 | `docker.service` en échec répété (exit-code, "Start request repeated too quickly") | Conflit entre `iptables-nft` (défaut sur Ubuntu 24.04) et la configuration réseau attendue par `dockerd` sur une install fraîche WSL2 + systemd | Bascule vers `iptables-legacy` (`update-alternatives`), puis `systemctl restart docker` |
| 5 | Erreur Terraform : provider `hashicorp/docker` introuvable lors du premier `terraform init` | Chaque module Terraform résout ses providers indépendamment ; le bloc `required_providers` du module racine ne se propage pas aux sous-modules | Ajout du bloc `required_providers` (kreuzwerker/docker) dans `modules/network/main.tf` et `modules/fortisiem/main.tf`, suppression du lock file, nouveau `terraform init` |

## Résultat

Module `network` validé via `terraform apply` :

| Propriété | Valeur |
|---|---|
| Nom | fortisiem-net |
| Driver | bridge |
| Subnet | 172.28.0.0/24 |
| Gateway | 172.28.0.1 |

## Prochaines étapes

- [ ] Poursuivre la lecture de la doc FortiSIEM (ports, architecture Supervisor/Worker/Collector)
- [ ] Récupérer la licence/l'image FortiSIEM auprès du tuteur
- [ ] Compléter le module `fortisiem` et les playbooks Ansible une fois l'accès obtenu
