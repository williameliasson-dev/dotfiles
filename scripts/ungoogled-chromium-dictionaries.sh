#!/usr/bin/env bash
# Downloads spell check dictionaries for ungoogled-chromium.
# Dictionaries are fetched from Chromium's hunspell_dictionaries repo
# and placed into the correct profile directory.
#
# Usage:
#   ./ungoogled-chromium-dictionaries.sh [lang...]
#
# Examples:
#   ./ungoogled-chromium-dictionaries.sh en-US          # just English (US)
#   ./ungoogled-chromium-dictionaries.sh en-US sv        # English + Swedish
#   ./ungoogled-chromium-dictionaries.sh --list          # show available dictionaries
#
# After running, toggle spell check in chrome://settings/languages and restart.

set -euo pipefail

BASE_URL="https://chromium.googlesource.com/chromium/deps/hunspell_dictionaries/+/refs/heads/main"

# Determine dictionaries directory per platform
case "$(uname -s)" in
    Darwin)
        DICT_DIR="${HOME}/Library/Application Support/Chromium/Dictionaries"
        ;;
    Linux)
        if [ -d "${HOME}/.var/app/com.github.Eloston.UngoogledChromium" ]; then
            DICT_DIR="${HOME}/.var/app/com.github.Eloston.UngoogledChromium/config/chromium/Dictionaries"
        else
            DICT_DIR="${HOME}/.config/chromium/Dictionaries"
        fi
        ;;
    *)
        echo "Unsupported platform: $(uname -s)" >&2
        exit 1
        ;;
esac

# All known bdic files in the upstream repo (language -> filename)
declare -A DICTS=(
    [af]=af-ZA-3-0.bdic
    [bg]=bg-BG-3-0.bdic
    [ca]=ca-ES-3-0.bdic
    [cs]=cs-CZ-3-0.bdic
    [cy]=cy-GB-3-0.bdic
    [da]=da-DK-3-0.bdic
    [de]=de-DE-3-0.bdic
    [el]=el-GR-3-0.bdic
    [en-AU]=en-AU-10-1.bdic
    [en-CA]=en-CA-10-1.bdic
    [en-GB]=en-GB-10-1.bdic
    [en-US]=en-US-10-1.bdic
    [es]=es-ES-3-0.bdic
    [et]=et-EE-3-0.bdic
    [fa]=fa-IR-3-0.bdic
    [fo]=fo-FO-3-0.bdic
    [fr]=fr-FR-3-0.bdic
    [he]=he-IL-3-0.bdic
    [hi]=hi-IN-3-0.bdic
    [hr]=hr-HR-3-0.bdic
    [hu]=hu-HU-3-0.bdic
    [id]=id-ID-3-0.bdic
    [it]=it-IT-3-0.bdic
    [ko]=ko-3-0.bdic
    [lt]=lt-LT-3-0.bdic
    [lv]=lv-LV-3-0.bdic
    [nb]=nb-NO-3-0.bdic
    [nl]=nl-NL-3-0.bdic
    [pl]=pl-PL-3-0.bdic
    [pt-BR]=pt-BR-3-0.bdic
    [pt-PT]=pt-PT-3-0.bdic
    [ro]=ro-RO-3-0.bdic
    [ru]=ru-RU-3-0.bdic
    [sh]=sh-3-0.bdic
    [sk]=sk-SK-3-0.bdic
    [sl]=sl-SI-3-0.bdic
    [sq]=sq-AL-3-0.bdic
    [sr]=sr-3-0.bdic
    [sv]=sv-SE-3-0.bdic
    [ta]=ta-IN-3-0.bdic
    [tg]=tg-TG-3-0.bdic
    [tr]=tr-TR-3-0.bdic
    [uk]=uk-UA-3-0.bdic
    [vi]=vi-VN-3-0.bdic
)

list_dicts() {
    echo "Available dictionaries:"
    for lang in $(echo "${!DICTS[@]}" | tr ' ' '\n' | sort); do
        printf "  %-10s %s\n" "$lang" "${DICTS[$lang]}"
    done
}

download_dict() {
    local lang="$1"
    local bdic="${DICTS[$lang]}"

    if [ -z "$bdic" ]; then
        echo "Unknown language: $lang" >&2
        echo "Run with --list to see available languages." >&2
        return 1
    fi

    local url="${BASE_URL}/${bdic}?format=TEXT"
    local dest="${DICT_DIR}/${bdic}"

    if [ -f "$dest" ]; then
        echo "Already exists: $dest"
        return 0
    fi

    echo "Downloading ${bdic}..."
    if curl -fsSL "$url" | base64 -d > "$dest"; then
        echo "Installed: $dest"
    else
        rm -f "$dest"
        echo "Failed to download ${bdic}" >&2
        return 1
    fi
}

if [ $# -eq 0 ]; then
    echo "Usage: $0 [--list] [lang...]"
    echo "Example: $0 en-US sv"
    echo "Run with --list to see available languages."
    exit 0
fi

if [ "$1" = "--list" ]; then
    list_dicts
    exit 0
fi

mkdir -p "$DICT_DIR"

for lang in "$@"; do
    download_dict "$lang"
done

echo ""
echo "Done. Now toggle spell check in chrome://settings/languages and restart the browser."
