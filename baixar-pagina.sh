#!/bin/bash
# ============================================================
# POKESTORE - Espelhar página do Pokémon TCG (Chaos Rising)
# Uso educacional apenas — estudo de efeitos/animações.
# Rodar no Git Bash:  bash baixar-pagina.sh
# ============================================================

URL="https://tcg.pokemon.com/pt-br/expansions/chaos-rising/"
DEST="$(cd "$(dirname "$0")" && pwd)/site"

mkdir -p "$DEST"
cd "$DEST" || exit 1

# --mirror            : recursivo + timestamps
# --convert-links     : reescreve links para funcionar offline
# --adjust-extension  : adiciona .html/.css quando necessário
# --page-requisites   : baixa CSS, JS, imagens, fontes da página
# --span-hosts + -D   : permite baixar assets em CDNs do Pokémon
# --no-parent         : não sobe além de /chaos-rising/
# -e robots=off       : ignora robots.txt (necessário p/ assets)
# --user-agent        : evita bloqueio por bot detection

wget \
  --mirror \
  --convert-links \
  --adjust-extension \
  --page-requisites \
  --span-hosts \
  --domains=tcg.pokemon.com,assets.pokemon.com,static.pokemon.com,images.pokemon.com,pokemon.com \
  --no-parent \
  --level=2 \
  -e robots=off \
  --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0 Safari/537.36" \
  --wait=1 --random-wait \
  --tries=3 \
  --no-check-certificate \
  "$URL"

echo ""
echo "=============================================="
echo "Download concluído em: $DEST"
echo "Abra o index.html dentro de tcg.pokemon.com/pt-br/expansions/chaos-rising/"
echo "=============================================="
echo ""
echo "AVISO: se os efeitos (WebGL/animações JS) não funcionarem offline,"
echo "é porque carregam recursos dinamicamente. Nesse caso:"
echo "  1. Abra a página real no Chrome > DevTools > Network"
echo "  2. Recarregue e clique com o direito > 'Save all as HAR'"
echo "  3. Ou use a extensão 'Save All Resources' (SingleFile também ajuda)"
