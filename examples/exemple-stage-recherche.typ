// Rapport de Stage - Souveraineté Numérique

#import "../template/template-univ-reunion.typ": *

// =============================================================================
// PAGE DE COUVERTURE
// =============================================================================

#page-couverture(
  logo-univ: "../img/UR_LOGO_2025_BLEU.jpg",
  logo-composante: "../img/ESIROI-logo.jpg",
  titre: "L'indépendance numérique a un prix : Sommes-nous prêts à le payer ?",
  sous-titre: "Analyse des enjeux de souveraineté numérique pour les organisations réunionnaises",
  type-document: "Rapport de Recherche",
  auteurs: (
    "Thibaut Fontaine",
  ),
  encadrants: (
    "John Doe (Directeur de Recherche - Université de La Réunion)",
    "Thalia Fontaine (RSSI - Kodetis)",
  ),
  formation: "Master 2 Informatique - Parcours Cybersécurité",
  annee-universitaire: "2024-2026",
  date: "Décembre 2026",
  style: "classique",
)

// =============================================================================
// CONFIGURATION DU DOCUMENT
// =============================================================================

#show: univ-report.with(
  titre: "Souveraineté Numérique à La Réunion",
  auteurs: ("Thibaut Fontaine",),
  date: datetime.today(),
  lang: "fr",
  resume: [
    Ce rapport examine les enjeux de souveraineté numérique pour les organisations réunionnaises. Face à la dépendance croissante aux géants technologiques américains (GAFAM), nous analysons le paradoxe auquel sont confrontés les professionnels IT à 10 000 km de l'Europe : choisir entre le confort des solutions cloud performantes et l'indépendance digitale. Notre étude démontre que la souveraineté numérique n'est pas qu'une question technique mais une décision stratégique organisationnelle, nécessitant une approche hybride pragmatique.
  ],
  mots-cles: "Souveraineté numérique, Cloud, GAFAM, La Réunion, Stratégie IT, Indépendance",
  abstract: [
    This report examines digital sovereignty issues for organizations in Réunion Island. Facing increasing dependence on American tech giants (GAFAM), we analyze the paradox confronting IT professionals 10,000 km from Europe: choosing between the comfort of high-performance cloud solutions and digital independence. Our study demonstrates that digital sovereignty is not just a technical issue but a strategic organizational decision, requiring a pragmatic hybrid approach.
  ],
  keywords: "Digital sovereignty, Cloud, GAFAM, Réunion Island, IT Strategy, Independence",
  toc: true,
)

// =============================================================================
// REMERCIEMENTS
// =============================================================================

#page-remerciements[
  Je tiens à exprimer ma profonde gratitude envers toutes les personnes qui ont contribué à la réussite de ce stage de recherche.

  Mes remerciements vont en premier lieu à mon directeur de stage pour son accompagnement scientifique rigoureux et sa disponibilité tout au long de ces six mois.

  Je remercie également Mme Thalia Fontaine, RSSI de Kodetis, pour m'avoir permis d'observer les pratiques terrain et les défis concrets auxquels font face les organisations réunionnaises.

  Ma reconnaissance s'adresse à l'ensemble des professionnels IT locaux qui ont accepté de partager leur expérience et leurs réflexions sur la souveraineté numérique.
]

// =============================================================================
// INTRODUCTION
// =============================================================================

= Introduction

== Contexte

Le numérique est souvent perçu comme immatériel, sans frontières et instantané. Pourtant, pour les professionnels IT à La Réunion, cette réalité se mesure en kilomètres de câbles sous-marins, en délais de livraison de matériel et, surtout, en millisecondes de latence.

La "souveraineté numérique" est devenue un concept tendance dans les discours politiques et stratégiques. Mais à 10 000 km de l'Europe, ce concept prend une dimension particulière : nous sommes confrontés à un paradoxe permanent entre le confort offert par les géants technologiques et l'aspiration à une indépendance digitale.

#info-box(title: "Problématique", type: "info")[
  Comment les organisations réunionnaises peuvent-elles concilier performance opérationnelle et souveraineté numérique dans un contexte d'éloignement géographique et de dépendance technologique ?
]

== Objectifs de la recherche

Ce stage de recherche poursuit les objectifs suivants :

+ *Analyser* les raisons de la dépendance aux solutions des GAFAM
+ *Évaluer* le coût réel de cette dépendance pour les organisations locales
+ *Identifier* les obstacles à une transition vers des solutions souveraines
+ *Proposer* une stratégie hybride pragmatique adaptée au contexte réunionnais

// =============================================================================
// LE CONFORT DE LA PRISON DORÉE
// =============================================================================

= Le confort de la "Prison Dorée"

== Pourquoi les entreprises choisissent les GAFAM

Les entreprises réunionnaises adoptent massivement les solutions des géants technologiques américains. Ce choix n'est pas le fruit d'une ignorance mais d'un pragmatisme assumé face aux contraintes locales.

=== La contrainte de la latence

Les serveurs "souverains" hébergés en Europe métropolitaine impliquent une latence incompressible de *200 à 250 millisecondes*. Cette latence, invisible pour un usage occasionnel, devient pénalisante pour :

- La bureautique moderne (édition collaborative en temps réel)
- Les applications métier critiques
- La visioconférence et le travail hybride
- Les outils de développement cloud

#figure(
  table(
    columns: 3,
    [*Localisation serveur*], [*Latence moyenne*], [*Impact utilisateur*],
    [La Réunion], [< 20 ms], [Optimal],
    [Singapour (GAFAM)], [80-120 ms], [Acceptable],
    [Europe (souverain)], [200-250 ms], [Dégradé],
  ),
  caption: [Comparaison des latences selon la localisation],
)

=== L'investissement des géants technologiques

Les GAFAM ont investi massivement pour résoudre ces défis techniques :

- *Réseaux de distribution de contenu (CDN)* : Points de présence régionaux
- *Protocoles optimisés* : QUIC, HTTP/3 réduisant l'impact de la latence
- *Edge computing* : Traitement au plus proche de l'utilisateur

Leur offre cloud est séduisante : déploiement instantané, scalabilité automatique, maintenance incluse. Comparée aux délais logistiques locaux pour acquérir et déployer du matériel, la proposition de valeur est difficile à refuser.

== Le prix de ce confort

#info-box(title: "Constat", type: "warning")[
  Nous avons échangé notre indépendance contre la performance et la simplicité. Nous sommes devenus locataires de notre propre Système d'Information.
]

Cette dépendance se manifeste à plusieurs niveaux :

- *Dépendance contractuelle* : Conditions dictées unilatéralement
- *Dépendance technique* : Formats propriétaires, API verrouillées
- *Dépendance économique* : Coûts d'exit prohibitifs
- *Dépendance géopolitique* : Soumission aux lois extra-territoriales (Cloud Act)

// =============================================================================
// LE RÉVEIL BRUTAL
// =============================================================================

= Le réveil brutal

== L'affaire VMware-Broadcom

Le rachat de VMware par Broadcom en 2023 et l'augmentation drastique des licences qui a suivi ont constitué un électrochoc pour les directions informatiques locales. Du jour au lendemain, les organisations ont découvert leur vulnérabilité.

#figure(
  table(
    columns: 3,
    [*Aspect*], [*Avant rachat*], [*Après rachat*],
    [Modèle de licence], [Perpétuel + maintenance], [Abonnement obligatoire],
    [Augmentation tarifaire], [-], [+200% à +500%],
    [Support partenaires], [Écosystème large], [Restreint],
    [Alternatives], [Nombreuses], [Migration complexe],
  ),
  caption: [Impact du rachat VMware par Broadcom],
)

== Les défis d'une migration

Face à cette situation, les organisations envisageant une migration vers des alternatives souveraines se heurtent à plusieurs obstacles :

=== La dette technique

- *Scripts et automatisations* : Des années de développement aligné sur VMware
- *Monitoring et supervision* : Outils intégrés à l'écosystème
- *Compétences internes* : Formations et certifications VMware
- *Procédures documentées* : Basées sur les interfaces propriétaires

=== La mobilisation des ressources

Une migration représente une mobilisation massive de ressources humaines et financières, sans valeur métier immédiate visible pour les dirigeants. Le système fonctionne, pourquoi le changer ?

=== La vulnérabilité révélée

Cette situation a révélé une vérité inconfortable : les décisions stratégiques concernant notre infrastructure IT sont prises par des conseils d'administration étrangers, selon des logiques financières qui nous échappent totalement.

// =============================================================================
// LE MUR DE LA RÉALITÉ
// =============================================================================

= Le mur de la réalité

== Le mythe du ROI immédiat

Lorsque la question de la souveraineté est abordée en comité de direction, la première question est invariablement : "Quel est le retour sur investissement ?"

Cette question révèle une incompréhension fondamentale. La souveraineté numérique ne fonctionne pas comme un investissement classique générant des profits. Elle fonctionne comme *une assurance* :

#info-box(title: "La souveraineté comme assurance", type: "info")[
  L'objectif n'est pas de "gagner plus" mais de "ne pas subir". Il s'agit de garder la maîtrise de son destin numérique, quelles que soient les évolutions géopolitiques ou les décisions commerciales des fournisseurs.
]

== La surcharge des équipes IT locales

Les équipes informatiques réunionnaises partagent une caractéristique commune : elles sont généralement réduites et surchargées par la maintenance opérationnelle quotidienne (le "RUN").

#figure(
  table(
    columns: 2,
    [*Activité*], [*Part du temps*],
    [Maintenance opérationnelle (RUN)], [70%],
    [Support utilisateurs], [15%],
    [Projets d'évolution (BUILD)], [10%],
    [Veille et formation], [5%],
  ),
  caption: [Répartition typique du temps des équipes IT locales],
)

Les solutions propriétaires "clé en main" offrent du *temps de cerveau disponible*. La maintenance est externalisée, les mises à jour sont automatiques, le support est inclus.

Migrer vers des alternatives souveraines restaure cette charge en interne. Cela nécessite :

- Des compétences spécifiques (souvent rares localement)
- Du temps pour la mise en place et la maintenance
- Une capacité à absorber les incidents sans support éditeur premium

// =============================================================================
// LE COÛT DE LA LIBERTÉ
// =============================================================================

= Le coût de la liberté

== Une approche hybride pragmatique

Plutôt qu'une souveraineté totale irréaliste, nous proposons une stratégie hybride basée sur la classification des données et services.

=== Identifier les "joyaux de la couronne"

Certaines données et certains services méritent une protection maximale :

- *Données de santé* : Soumises à des réglementations strictes (HDS)
- *Données financières* : Critiques pour la continuité d'activité
- *Propriété intellectuelle* : Avantage compétitif de l'organisation
- *Données personnelles sensibles* : RGPD et responsabilité juridique

#figure(
  table(
    columns: 3,
    [*Catégorie*], [*Hébergement recommandé*], [*Justification*],
    [Joyaux de la couronne], [Souverain / Local], [Protection maximale],
    [Données métier courantes], [Hybride], [Équilibre coût/contrôle],
    [Services génériques], [Cloud public], [Performance et coût],
  ),
  caption: [Stratégie d'hébergement par catégorie de données],
)

=== Accepter une dépendance maîtrisée

Pour les services génériques (messagerie, bureautique collaborative, outils de productivité), la dépendance aux solutions cloud peut être acceptée si elle est :

- *Consciente* : Risques identifiés et documentés
- *Réversible* : Plan de sortie préparé
- *Encadrée* : Contrats négociés, données exportables

== L'effort requis

La transition vers une souveraineté même partielle nécessite des investissements significatifs :

=== Formation des compétences locales

- Développer l'expertise sur les solutions open source
- Créer des parcours de formation adaptés
- Favoriser les communautés techniques locales

=== Accepter des coûts initiaux plus élevés

- Infrastructure locale ou hébergement souverain
- Temps de migration et adaptation
- Courbe d'apprentissage des équipes

=== Éduquer les dirigeants

- Sensibiliser à la valeur stratégique de l'indépendance
- Présenter la souveraineté comme une gestion de risque
- Démontrer les coûts cachés de la dépendance

// =============================================================================
// CONCLUSION
// =============================================================================

= Conclusion

== Synthèse

Ce stage de recherche a permis de mettre en lumière le paradoxe auquel font face les organisations réunionnaises en matière de souveraineté numérique.

La dépendance aux géants technologiques n'est pas le fruit d'une négligence mais d'un arbitrage rationnel face aux contraintes locales : latence, compétences disponibles, ressources limitées. Cependant, cette dépendance a un coût souvent invisible jusqu'au jour où il devient brutal.

== Recommandations

+ *Cartographier sa dépendance* : Identifier les fournisseurs critiques et évaluer les risques associés

+ *Classifier ses données* : Distinguer les "joyaux de la couronne" des services génériques

+ *Préparer la réversibilité* : Maintenir des plans de sortie pour les services critiques

+ *Investir dans les compétences* : Former les équipes aux alternatives souveraines

+ *Mutualiser localement* : Créer des synergies entre organisations réunionnaises

== Question ouverte

#info-box(title: "Réflexion finale", type: "warning")[
  Sommes-nous prêts à sacrifier notre confort immédiat pour garantir notre liberté future ?
]

L'enjeu dépasse largement la technique. Il s'agit d'une décision stratégique qui engage l'avenir de nos organisations et, plus largement, de notre territoire dans l'économie numérique mondiale.

La souveraineté numérique a un prix. La question n'est plus de savoir si nous devons le payer, mais comment et à quel rythme nous sommes prêts à le faire.

// =============================================================================
// GLOSSAIRE
// =============================================================================

#glossaire((
  ("GAFAM", "Google, Apple, Facebook (Meta), Amazon, Microsoft"),
  ("CDN", "Content Delivery Network - Réseau de distribution de contenu"),
  ("Cloud Act", "Loi américaine permettant l'accès aux données stockées à l'étranger"),
  ("HDS", "Hébergement de Données de Santé"),
  ("RGPD", "Règlement Général sur la Protection des Données"),
  ("RUN", "Activités de maintenance opérationnelle courante"),
  ("BUILD", "Activités de développement et projets d'évolution"),
  ("ROI", "Return On Investment - Retour sur investissement"),
  ("Edge Computing", "Traitement des données au plus proche de l'utilisateur"),
))

// =============================================================================
// PAGE DE GARDE FINALE
// =============================================================================

#page-garde-finale(
  logo-gauche: "../img/UR_LOGO_2025_BLEU.jpg",
  logo-centre: "../img/ESIROI-logo.jpg",
  logo-droite: "../img/MESRE_RVB.png",
  nom: "Thibaut Fontaine",
  email: "thibaut.fontaine@etudiant.univ-reunion.fr",
  telephone: "+262 6 92 XX XX XX",
  adresse: "Université de La Réunion - ESIROI\n40 avenue de Soweto, 97410 Saint-Pierre",
  linkedin: "https://linkedin.com/in/thibaut-fontaine",
)
