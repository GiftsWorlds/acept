#!/bin/bash
# Создаём папку для картинок
mkdir -p images

echo "Скачиваем картинки..."

declare -A IMAGES=(
  ["images/avatar_default.png"]="https://cdn-icons-png.flaticon.com/512/149/149071.png"
  ["images/birthday-cake.png"]="https://em-content.zobj.net/source/apple/391/birthday-cake_1f382.png"
  ["images/bouquet.png"]="https://em-content.zobj.net/source/apple/391/bouquet_1f490.png"
  ["images/cat-face.png"]="https://em-content.zobj.net/source/apple/391/cat-face_1f431.png"
  ["images/coin.png"]="https://em-content.zobj.net/source/apple/391/coin_1fa99.png"
  ["images/cookie.png"]="https://em-content.zobj.net/source/apple/391/cookie_1f36a.png"
  ["images/cooking.png"]="https://em-content.zobj.net/source/apple/391/cooking_1f373.png"
  ["images/crown.png"]="https://em-content.zobj.net/source/apple/391/crown_1f451.png"
  ["images/desert-island.png"]="https://em-content.zobj.net/source/apple/391/desert-island_1f3dd-fe0f.png"
  ["images/game-die.png"]="https://em-content.zobj.net/source/apple/391/game-die_1f3b2.png"
  ["images/gem-stone.png"]="https://em-content.zobj.net/source/apple/391/gem-stone_1f48e.png"
  ["images/guitar.png"]="https://em-content.zobj.net/source/apple/391/guitar_1f3b8.png"
  ["images/hamburger.png"]="https://em-content.zobj.net/source/apple/391/hamburger_1f354.png"
  ["images/hot-beverage.png"]="https://em-content.zobj.net/source/apple/391/hot-beverage_2615.png"
  ["images/lizard.png"]="https://em-content.zobj.net/source/apple/391/lizard_1f98e.png"
  ["images/milky-way.png"]="https://em-content.zobj.net/source/apple/391/milky-way_1f30c.png"
  ["images/motor-boat.png"]="https://em-content.zobj.net/source/apple/391/motor-boat_1f6e5-fe0f.png"
  ["images/panda.png"]="https://em-content.zobj.net/source/apple/391/panda_1f43c.png"
  ["images/pizza.png"]="https://em-content.zobj.net/source/apple/391/pizza_1f355.png"
  ["images/racing-car.png"]="https://em-content.zobj.net/source/apple/391/racing-car_1f3ce-fe0f.png"
  ["images/ring.png"]="https://em-content.zobj.net/source/apple/391/ring_1f48d.png"
  ["images/ringed-planet.png"]="https://em-content.zobj.net/source/apple/391/ringed-planet_1fa90.png"
  ["images/rocket.png"]="https://em-content.zobj.net/source/apple/391/rocket_1f680.png"
  ["images/rose.png"]="https://em-content.zobj.net/source/apple/391/rose_1f339.png"
  ["images/teddy-bear.png"]="https://em-content.zobj.net/source/apple/391/teddy-bear_1f9f8.png"
  ["images/trophy.png"]="https://em-content.zobj.net/source/apple/391/trophy_1f3c6.png"
  ["images/video-game.png"]="https://em-content.zobj.net/source/apple/391/video-game_1f3ae.png"
  ["images/watermelon.png"]="https://em-content.zobj.net/source/apple/391/watermelon_1f349.png"
)

for FILE in "${!IMAGES[@]}"; do
  URL="${IMAGES[$FILE]}"
  echo "  ⬇ $FILE"
  curl -sL "$URL" -o "$FILE"
done

echo ""
echo "✅ Готово! Все картинки в папке images/"
