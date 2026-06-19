# Architecture cible

## Décisions confirmées avec le tuteur (22/6)

- **Phase 1 (maintenant)** : déploiement 100% local, sur la machine locale, via Docker.
- **Phase 2 (plus tard)** : migration vers Azure, une fois l'accès cloud confirmé.
- **Licence FortiSIEM** : fournie par le tuteur (ne plus bloquer sur ce point — à récupérer en P1).

## Phase 1 — Local (maintenant)

```
Git/GitLab CI → Terraform (kreuzwerker/docker) → Réseau Docker isolé
                                                         │
                                            ┌────────────┴────────────┐
                                            ▼                         ▼
                                   FortiSIEM (conteneurs)      Kali (conteneur)
                                   Supervisor/Worker/Collector  même réseau isolé
                                            │
                                            ▼
                                   Alertes & tableaux de bord
```

Ports critiques à exposer (doc officielle FortiSIEM) :
- `443` — GUI / API REST
- `514` — Syslog (UDP/TCP)
- `5480` — Administration

## Phase 2 — Cloud (plus tard, après confirmation)

```
Git/GitLab CI → Terraform (azurerm) → Azure (VNet + VMs)
                                              │
                                ┌─────────────┴─────────────┐
                                ▼                           ▼
                       FortiSIEM (VM Azure)           Kali (VM Azure, NSG isolé)
                                │
                                ▼
                       Alertes & tableaux de bord
```

## Ce qui ne change pas entre les deux phases

- La couche Ansible (déploiement/config FortiSIEM, règles de corrélation)
- Le repo Git et la structure du projet
- L'objectif final : infra recréée en une commande, alerte déclenchée suite à une attaque Kali

## Ouvert / à suivre

- [ ] Récupérer la licence FortiSIEM auprès du tuteur
- [ ] Confirmer le calendrier de la migration cloud (pas de date fixée pour le moment)
- [ ] Identifier l'image Docker FortiSIEM à utiliser en Phase 1
