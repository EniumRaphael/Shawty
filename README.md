```
⠀⠀⠀⠀ ⠀⠀⠀  ⠀⡞⢡ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   .. 
⠀⠀⠀⠀ ⠀⠀⠀⠀⢀⣼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠋⠈
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⡇⢤⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⠟⠁⢀⠀
 ⠀⠀⠀⠀⠀⠀⠀⣼⣿⠌⠀⠉⠹⡀⠀⠀⠄⠠⠀⣠⣾⣟⠡⠄⠀⠀⠀
 ⠀⠀⠀⠀⠀⠀⢰⣿⡿⠀⠀⠀⣠⠎⠈⠉⠙⢕⠺⣿⠟⠁⠀⠑⢎⠀⠀
⠀⠀⠀⠀⠀⠀⡠⠋⠘⠃⢀⡶⠊⠀⠀⠀⠀⠀⠀⠱⡀⠑⢄⠀⢠⡄⠃⠀
⠀⠀⠀⠀⠀⡜⠁⠀⠀⠀⠌⠀⠀⠀⢠⡆⠀⠀⠀⠀⢱⡀⠀⠣⣤⠇⠀⠀
⠀⠀⠀⠀⡘⠀⠀⠀⠀⡜⠀⠀⠀⢠⣁⣇⢰⠀⠀⠀⣸⣡⠀⠀⣵⣀⠀⠀
⠀⠀⠀⠀⡇⠀⠀⡠⠊⠃⠀⠀⢠⠃⠀⢠⠈⠀⠀⠀⠆⠀⠆⠘⢿⣿⠀⠀
⠀⠀⠀⠀⣇⡄⠪⠄⠐⡆⠀⢠⢃⣀⣀⣘⠇⠀⠀⡜⣠⣤⣼⡀⢠⢫⢆⠀
⠀⠀⠀⠀⢰⠀⠀⠀⡄⠹⡀⡿⠋⣿⣿⣽⠁⡠⠺⠘⣿⡿⠈⠇⡘⠣⢈⣢
⠀⠀⠀⠀⢀⡄⠀⠀⡇⠀⠱⠸⡈⢇⡠⠹⠊⠀⠀⠀⠧⠆⣸⠘⠃⠀⣀⡀
⠀⠀⠀⠀⡌⢀⠀⠀⢁⠀⠀⢠⣱⡔⠀⠀⠀⠀⠀⠀⠀⠀⢾⠀⠁⠀⠿⠃
⠀⠀⢀⡜⠄⡆⠀⢀⠘⡤⠀⠀⡆⠁⠀⠀⠀⠀⠐⠀⠀⡠⠃⠀⡀⠀⠀⠀
⠀⠀⠀⠀⠀⢃⠀⠘⢂⢀⣇⠀⣇⠀⠳⣦⠤⠄⡤⠐⠹⢇⠀⠀⡇⠀⠀⠀
⠀⠀⠀⠀⠀⠘⠤⢇⡔⠻⣿⣆⣯⡢⣀⢸⢿⣶⡁⠀⠀⠀⠆⢸⠁⠀⠀⠀

███████╗██╗  ██╗ █████╗ ██╗    ██╗████████╗██╗   ██╗
██╔════╝██║  ██║██╔══██╗██║    ██║╚══██╔══╝╚██╗ ██╔╝
███████╗███████║███████║██║ █╗ ██║   ██║    ╚████╔╝
╚════██║██╔══██║██╔══██║██║███╗██║   ██║     ╚██╔╝
███████║██║  ██║██║  ██║╚███╔███╔╝   ██║      ██║
╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚══╝╚══╝    ╚═╝      ╚═╝      "Made with <3 by Sil3ntPurr"
```


Shawty est un scanner de vulnérabilités WordPress mignon mais puissant, écrit en Bash avec une touche à la Sil3ntPurr ! 
Il détecte les problèmes de sécurité courants et génère des rapports colorés avec des emojis.
___
```bash
🌸 Fonctionnalités

    🐱 Détection automatique de WordPress

    🔍 Identification de la version WordPress

    💉 Test des vulnérabilités SQLi

    🎯 Test des vulnérabilités XSS

    🎨 Interface colorée avec ASCII art

    📝 Génération de commandes sqlmap recommandées
```
___

🍡 Prérequis
```bash

# Dépendances nécessaires
sudo apt install curl grep sed awk
```

🍬 Installation

Téléchargez Shawty:

```bash

git clone https://github.com/Sil3ntPurr/shawty.git
cd shawty
```

Rendez le script exécutable:

```bash

chmod +x shawty.sh
```

Exécutez-le:

```bash

./shawty.sh http://votresite.com
```

🍥 Utilisation

Syntaxe de base:

```bash

./shawty.sh <URL>
```

Exemple:

```bash

./shawty.sh http://mon-site-wordpress.com
```

📊 Fonctionnalités Techniques

Détection WordPress

    Vérifie les indicateurs WordPress (wp-content, wp-includes, etc.)

    Détecte la version via:

        readme.html

        Meta generator

        wp-includes/version.php

Tests de Sécurité

    SQLi: Teste les endpoints WP REST API avec des payloads temporels

    XSS: Vérifie l'accès à l'éditeur de thème

Pour le moment, il ne dispose que de trois tests extrêmement basiques, mais je compte bien en ajouter beaucoup d'autres par la suite ! 😊

💖 Contribution

Les pull requests sont les bienvenues! Pour les changements majeurs, veuillez d'abord ouvrir une issue pour discuter de ce que vous souhaitez changer.
