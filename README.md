# FortiSIEM IaC — Automatisation du déploiement

Stage Teamwill · 22 juin – 31 août 2026

## Statut du projet (mis à jour après échange avec le tuteur)

- **Environnement actuel : 100% local** (Docker sur ta machine). Le passage au cloud (Azure) se fera plus tard, une fois l'accès confirmé.
- **Licence FortiSIEM : fournie par le tuteur** (à récupérer — voir `docs/architecture.md`).
- **Objectif final inchangé** : infrastructure détruite et recréée en une seule commande (`terraform apply`), FortiSIEM opérationnel, alerte déclenchée suite à une attaque Kali simulée.

## Structure du repo

```
fortisiem-iac/
├── terraform/          # Provisioning de l'infra (réseau Docker, volumes, conteneurs)
│   └── modules/
│       ├── network/     # Réseau Docker isolé
│       └── fortisiem/    # Conteneurs FortiSIEM (Supervisor/Worker/Collector)
├── ansible/             # Configuration et déploiement de FortiSIEM
│   ├── inventory/
│   ├── playbooks/
│   └── roles/
├── docker/              # docker-compose pour tests rapides en local
└── docs/
    └── architecture.md  # Schéma cible + décisions prises avec le tuteur
```

## Prochaines étapes (P1 — Setup & étude)

1. Installer Docker, Terraform, Ansible sur la machine locale
2. Lire la doc officielle FortiSIEM, identifier les ports critiques (443, 514, 5480)
3. Récupérer la licence FortiSIEM auprès du tuteur
4. Compléter `terraform/modules/fortisiem/main.tf` une fois l'image/licence en main

## Journal de stage

Voir `JOURNAL.md` — à compléter chaque jour, même brièvement. C'est la base du futur rapport PFE.
