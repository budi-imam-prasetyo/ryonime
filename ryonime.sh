#!/bin/bash
# RyoNime - Pencarian Anime Sub Indo
# Modifikasi dari animek-cli: https://github.com/THEUNFORGIVENNN/animek-cli

# Warna
BOLD="\033[1m"
RED="\033[38;5;196m"
GREEN="\033[38;5;46m"
YELLOW="\033[38;5;226m"
CYAN="\033[38;5;51m"
PURPLE="\033[38;5;93m"
ORANGE="\033[38;5;208m"
BLUE="\033[38;5;39m"
RESET="\033[0m"

# Konfigurasi
CHANNEL_ID="UCVg6XW6LiG8y7ZP5l9nN3Rw"  # Muse Indonesia
MAX_RESULTS=15
VERSION="1.2.0"

# Fungsi untuk header
header() {
    clear
    echo -e "${PURPLE}╭──────────────────────────────────────────────────────╮"
    echo -e "│${CYAN}      ______  ______  _   ________  _________ ${PURPLE}│"
    echo -e "│${CYAN}     / __ \ \/ / __ \/ | / /  _/  |/  / ____/${PURPLE}│"
    echo -e "│${CYAN}    / /_/ /\  / / / /  |/ // // /|_/ / __/  ${PURPLE}│"
    echo -e "│${CYAN}    / /_/ /\  / / / /  |/ // // /|_/ / __/ ${PURPLE}│"
    echo -e "│${CYAN}   / _, _/ / / /_/ / /|  // // /  / / /___${PURPLE}│"
    echo -e "│${CYAN}  /_/ |_| /_/\____/_/ |_/___/_/  /_/_____/ ${PURPLE}│"
    echo -e "├──────────────────────────────────────────────────────┤"
    echo -e "│${BOLD}   Versi ${VERSION} • Channel: Muse Indonesia • by Ryo${RESET}${PURPLE}       │"
    echo -e "╰──────────────────────────────────────────────────────╯${RESET}"
}

# Fungsi untuk footer
footer() {
    echo -e "\n${PURPLE}╭──────────────────────────────────────────────────────╮"
    echo -e "│${CYAN}  [N] Cari lagi   ${GREEN}[P] Putar ulang   ${YELLOW}[Q] Keluar   ${ORANGE}[?] Bantuan  ${PURPLE}│"
    echo -e "╰──────────────────────────────────────────────────────╯${RESET}"
    echo -ne "${YELLOW}[?] Pilih menu: ${RESET}"
    
    read -n1 choice
    case ${choice,,} in
        n) main_flow ;;
        p) play_video ;;
        \?) show_help ;;
        q) echo -e "\n${GREEN}[+] Terima kasih telah menggunakan RyoNime!${RESET}"; exit 0 ;;
        *) echo -e "\n${RED}[!] Pilihan tidak valid${RESET}" ;;
    esac
}

# Fungsi bantuan
show_help() {
    clear
    echo -e "${CYAN}╭────────────────── ${BOLD}BANTUAN RYONIME${RESET}${CYAN} ───────────────────╮"
    echo -e "│                                                      │"
    echo -e "│  ${YELLOW}• Cara Penggunaan:${RESET}${CYAN}                                     │"
    echo -e "│    1. Masukkan judul anime yang ingin dicari          │"
    echo -e "│    2. Pilih video dari daftar hasil                  │"
    echo -e "│    3. Pilih kualitas video                           │"
    echo -e "│    4. Pilih pemutar video                            │"
    echo -e "│                                                      │"
    echo -e "│  ${YELLOW}• Navigasi:${RESET}${CYAN}                                            │"
    echo -e "│    - Gunakan nomor untuk memilih opsi                │"
    echo -e "│    - Gunakan tombol panah (↑/↓) untuk navigasi menu  │"
    echo -e "│                                                      │"
    echo -e "│  ${YELLOW}• Fitur:${RESET}${CYAN}                                               │"
    echo -e "│    - Auto-detect pemutar video (MPV, VLC, IINA)      │"
    echo -e "│    - Pilih resolusi video sesuai kebutuhan           │"
    echo -e "│    - Skip video dengan durasi > 1 jam                │"
    echo -e "│                                                      │"
    echo -e "│  ${YELLOW}• Dependensi:${RESET}${CYAN}                                          │"
    echo -e "│    - yt-dlp (wajib)                                  │"
    echo -e "│    - MPV/VLC/IINA (pilih salah satu)                 │"
    echo -e "│                                                      │"
    echo -e "╰──────────────────────────────────────────────────────╯${RESET}"
    echo -e "\n${GREEN}Tekan enter untuk kembali...${RESET}"
    read
    header
}

# Cek dependensi
check_dependency() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "${RED}[✗] Error: $1 tidak terinstall.${RESET}"
        return 1
    fi
    return 0
}

# Deteksi pemutar video
detect_player() {
    declare -A players
    players["mpv"]="mpv --no-terminal"
    players["vlc"]="vlc --play-and-exit --quiet"
    players["iina"]="iina --no-stdin"

    for player in "${!players[@]}"; do
        if command -v "$player" &> /dev/null; then
            echo "$player"
            return
        fi
    done
    echo ""
}

# Fungsi pemilihan
select_option() {
    local prompt="$1"
    local options=("${@:2}")
    local selected=0

    while true; do
        echo -e "${YELLOW}$prompt${RESET}"
        for i in "${!options[@]}"; do
            if [[ $i -eq $selected ]]; then
                echo -e "${GREEN}   ${BOLD}${options[$i]}${RESET}"
            else
                echo -e "    ${options[$i]}"
            fi
        done

        read -rsn1 input
        case "$input" in
            "A") # Up arrow
                selected=$(( (selected + ${#options[@]} - 1) % ${#options[@]} )) ;;
            "B") # Down arrow
                selected=$(( (selected + 1) % ${#options[@]} )) ;;
            "") # Enter
                return $((selected)) ;;
            [1-9]) # Number input
                if [[ $input -le ${#options[@]} ]]; then
                    return $((input-1))
                fi ;;
        esac
        tput cuu $((${#options[@]}+1))
    done
}

# Animasi loading
show_loading() {
    local text="$1"
    local delay=0.1
    local chars=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    
    echo -ne "${CYAN}[~] ${text}... ${RESET}"
    
    for i in {1..10}; do
        for char in "${chars[@]}"; do
            echo -ne "\b${char}"
            sleep $delay
        done
    done
    echo -e "\b✓"
}

# Main flow
main_flow() {
    header
    
    # Input judul
    echo -ne "${YELLOW}[?] Masukkan judul anime: ${RESET}"
    read -r query

    if [[ -z "$query" ]]; then
        echo -e "${RED}[!] Masukkan judul anime terlebih dahulu.${RESET}"
        sleep 2
        main_flow
        return
    fi

    show_loading "Mencari \"$query\" di channel Muse Indonesia"

    # Mencari video
    results=$(yt-dlp "ytsearch$MAX_RESULTS:$query site:youtube.com/channel/$CHANNEL_ID" \
        --print "%(title)s|%(id)s|%(duration>%H:%M:%S)s" \
        --match-filter "duration < 3600" \
        --quiet 2>/dev/null)

    if [[ -z "$results" ]]; then
        echo -e "${RED}[!] Tidak ditemukan hasil yang cocok.${RESET}"
        sleep 2
        main_flow
        return
    fi

    # Menampilkan hasil
    mapfile -t lines <<< "$results"
    echo -e "\n${GREEN}[✓] Ditemukan ${#lines[@]} hasil:${RESET}"
    echo -e "${BLUE}╭──────────────────────────────────────────────────────╮${RESET}"

    for i in "${!lines[@]}"; do
        IFS='|' read -r title id duration <<< "${lines[$i]}"
        
        # Format judul
        clean_title=$(echo "$title" | sed 's/ - Muse Indonesia//g; s/\([0-9]\) - \([0-9]\)/\1-\2/g')
        
        if [[ $((i % 2)) -eq 0 ]]; then
            printf "${BOLD}${CYAN}│ %2d. ${RESET}%-45s ${YELLOW}%8s${CYAN} │${RESET}\n" "$((i+1))" "$clean_title" "$duration"
        else
            printf "${BOLD}${PURPLE}│ %2d. ${RESET}%-45s ${YELLOW}%8s${PURPLE} │${RESET}\n" "$((i+1))" "$clean_title" "$duration"
        fi
    done
    
    echo -e "${BLUE}╰──────────────────────────────────────────────────────╯${RESET}"

    # Pemilihan video
    selected_index=-1
    while [[ $selected_index -lt 0 || $selected_index -ge ${#lines[@]} ]]; do
        echo -ne "${YELLOW}[?] Pilih video [1-${#lines[@]}]: ${RESET}"
        read -r choice
        
        if [[ "$choice" =~ ^[0-9]+$ ]]; then
            selected_index=$((choice-1))
        else
            echo -e "${RED}[!] Masukkan nomor yang valid.${RESET}"
        fi
    done

    IFS='|' read -r selected_title video_id duration <<< "${lines[$selected_index]}"
    # Bersihkan judul untuk ditampilkan
    clean_selected_title=$(echo "$selected_title" | sed 's/ - Muse Indonesia//g; s/\([0-9]\) - \([0-9]\)/\1-\2/g')
    video_url="https://www.youtube.com/watch?v=$video_id"

    # Pemilihan kualitas
    echo -e "\n${CYAN}[~] Mendapatkan kualitas video...${RESET}"
    formats=$(yt-dlp -F "$video_url" --quiet 2>/dev/null | grep -E "video only|audio only")

    if [[ -z "$formats" ]]; then
        echo -e "${YELLOW}[!] Tidak dapat mendapatkan daftar kualitas. Gunakan kualitas default.${RESET}"
        selected_format="best"
        quality_name="Kualitas Terbaik"
    else
        quality_options=("Kualitas Terbaik (default)")
        format_ids=("best")
        
        while IFS= read -r line; do
            if [[ $line =~ ([0-9]+).*([0-9]{3,4}x[0-9]+).* ]]; then
                format_id="${BASH_REMATCH[1]}"
                resolution="${BASH_REMATCH[2]}"
                quality_options+=("$resolution")
                format_ids+=("$format_id")
            fi
        done <<< "$formats"
        
        select_option "[?] Pilih kualitas video:" "${quality_options[@]}"
        quality_choice=$?
        selected_format="${format_ids[$quality_choice]}"
        quality_name="${quality_options[$quality_choice]}"
    fi

    # Pemilihan pemutar
    players=()
    default_player=$(detect_player)
    [[ -n "$default_player" ]] && players+=("$default_player")
    [[ "$default_player" != "mpv" && $(command -v mpv) ]] && players+=("mpv")
    [[ "$default_player" != "vlc" && $(command -v vlc) ]] && players+=("vlc")
    [[ "$default_player" != "iina" && $(command -v iina) ]] && players+=("iina")

    player_name="$default_player"
    if [[ ${#players[@]} -gt 1 ]]; then
        select_option "[?] Pilih pemutar video:" "${players[@]}"
        player_choice=$?
        player_name="${players[$player_choice]}"
    fi

    # Konfigurasi pemutar
    case "$player_name" in
        "mpv") player_cmd="mpv --no-terminal --ytdl-format=$selected_format" ;;
        "vlc") player_cmd="vlc --play-and-exit --quiet" ;;
        "iina") player_cmd="iina --no-stdin" ;;
        *) player_cmd="$player_name" ;;
    esac

    play_video
}

# Fungsi putar video
play_video() {
    header
    echo -e "${GREEN}╭────────────────── ${BOLD}SEDANG MEMUTAR${RESET}${GREEN} ───────────────────╮"
    echo -e "│                                                      │"
    echo -e "│  ${CYAN}• Judul:${RESET} ${BOLD}$clean_selected_title${RESET}"
    echo -e "│  ${CYAN}• Durasi:${RESET} ${YELLOW}$duration${RESET}"
    echo -e "│  ${CYAN}• Kualitas:${RESET} ${ORANGE}$quality_name${RESET}"
    echo -e "│  ${CYAN}• Pemutar:${RESET} ${PURPLE}$player_name${RESET}"
    echo -e "│                                                      │"
    echo -e "╰──────────────────────────────────────────────────────╯${RESET}"
    echo -e "${YELLOW}Tekan 'q' untuk berhenti memutar...${RESET}\n"
    
    if ! $player_cmd "$video_url"; then
        echo -e "\n${RED}[!] Gagal memutar video.${RESET}"
        echo -e "${YELLOW}Mungkin perlu instal codec tambahan atau coba pemutar lain.${RESET}"
        sleep 3
    fi
    
    footer
}

# Inisialisasi
if ! check_dependency "yt-dlp"; then
    header
    echo -e "${RED}[!] Error: yt-dlp tidak terinstall.${RESET}"
    echo -e "${YELLOW}Install dengan: pip3 install yt-dlp${RESET}"
    exit 1
fi

default_player=$(detect_player)
if [[ -z "$default_player" ]]; then
    header
    echo -e "${RED}[!] Tidak ada pemutar video yang terdeteksi.${RESET}"
    echo -e "${YELLOW}Instal salah satu: mpv, vlc, atau iina${RESET}"
    exit 1
fi

# Mulai program
main_flow