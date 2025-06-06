#!/bin/bash

VERSION="1.0"
TOOL_NAME="FuckYou password generator"

# ANSI Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Banner function
print_banner() {
    clear
    if [ "$QUIET" = false ]; then
        echo -e "${PURPLE}"
        echo -e "ㅤㅤㅤㅤㅤㅤ${GREEN}Me: ${WHITE}"
        echo "⠀⠀⠀⠀⠀⠀⠀⣠⣶⣶⣦⡀"
        echo "⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        echo "⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        echo "⠀⠀⠀⠀⠀⠀⣴⣶⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        echo "⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        echo -e "⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣧⠀⠀⠀. ${GREEN}YOU ${WHITE}"
        echo "⠀⠀⠀⠀⣼⣿⣿⣿⡿⣿⣿⣆⠀⠀⠀⠀⠀⠀⣠⣴⣶⣤⡀⠀"
        echo "⠀⠀⠀⢰⣿⣿⣿⣿⠃⠈⢻⣿⣦⠀⠀⠀⠀⣸⣿⣿⣿⣿⣷⠀"
        echo "⠀⠀⠀⠘⣿⣿⣿⡏⣴⣿⣷⣝⢿⣷⢀⠀⢀⣿⣿⣿⣿⡿⠋⠀"
        echo "⠀⠀⠀⠀⢿⣿⣿⡇⢻⣿⣿⣿⣷⣶⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀"
        echo "⠀⠀⠀⠀⢸⣿⣿⣇⢸⣿⣿⡟⠙⠛⠻⣿⣿⣿⣿⡇⠀⠀⠀⠀"
        echo "⣴⣿⣿⣿⣿⣿⣿⣿⣠⣿⣿⡇⠀⠀⠀⠉⠛⣽⣿⣇⣀⣀⣀⠀"
        echo "⠙⠻⠿⠿⠿⠿⠿⠟⠿⠿⠿⠇⠀⠀⠀⠀⠀⠻⠿⠿⠛⠛⠛⠃"
        echo -e "${NC}"
        echo -e "${RED}$TOOL_NAME ${WHITE}v$VERSION${NC}"
        echo -e "${CYAN}By Alienkrishn${NC}"
        echo -e "${YELLOW}GitHub - github.com/Anon4You${NC}"
        echo ""
    fi
}

# Progress bar function
show_progress() {
    local current=$1
    local total=$2
    local width=50
    local percent=$((current * 100 / total))
    local progress=$((current * width / total))
    
    printf "\r${CYAN}Generating: ${WHITE}["
    for ((i = 0; i < progress; i++)); do printf "#"; done
    for ((i = progress; i < width; i++)); do printf " "; done
    printf "] ${percent}%% (${current}/${total})${NC}"
}

# Help menu
show_help() {
    print_banner
    echo -e "${WHITE}Usage: ${GREEN}$0 [options]${NC}"
    echo ""
    echo -e "${YELLOW}Options:${NC}"
    echo -e "  ${GREEN}-i, --interactive${NC}    Interactive mode (default if no args)"
    echo -e "  ${GREEN}-h, --help${NC}           Show this help menu"
    echo -e "  ${GREEN}-v, --version${NC}        Print the version of the tool"
    echo -e "  ${GREEN}-q, --quiet${NC}          Don't print the banner"
    echo ""
    echo -e "${WHITE}Interactive mode will prompt you for information to generate a custom password list.${NC}"
    exit 0
}

# Check for arguments
QUIET=false
INTERACTIVE=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            show_help
            ;;
        -v|--version)
            echo -e "${PURPLE}$TOOL_NAME ${WHITE}version ${GREEN}$VERSION${NC}"
            exit 0
            ;;
        -q|--quiet)
            QUIET=true
            shift
            ;;
        -i|--interactive)
            INTERACTIVE=true
            shift
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            show_help
            exit 1
            ;;
    esac
done

# If no arguments, show help
if [ $# -eq 0 ] && [ "$INTERACTIVE" = false ]; then
    show_help
fi

# Main interactive function
interactive_mode() {
    print_banner
    
    # Initialize variables
    FIRST_NAME=""
    SURNAME=""
    NICKNAME=""
    BIRTHDAY=""
    PARTNERS_NAME=""
    PARTNERS_NICKNAME=""
    PARTNERS_BIRTHDAY=""
    CHILDS_NAME=""
    CHILDS_NICKNAME=""
    CHILDS_BIRTHDAY=""
    PETS_NAME=""
    COMPANY_NAME=""
    EXTRA_KEYWORDS=""
    EXTRA_CHARS=""
    RANDOM_NUMBERS=false
    LEET_MODE=false
    
    # Function to validate name input
    get_name() {
        local prompt="$1"
        local var_name="$2"
        local required="$3"
        
        while true; do
            echo -ne "${CYAN}${prompt}: ${WHITE}"
            read -r input
            if [ "$required" = true ] && [ -z "$input" ]; then
                echo -e "${RED}You must enter a name at least!${NC}"
            else
                eval "$var_name=\"$input\""
                break
            fi
        done
    }
    
    # Function to validate date input
    get_date() {
        local prompt="$1"
        local var_name="$2"
        
        while true; do
            echo -ne "${CYAN}${prompt} (DDMMYYYY, leave empty to skip): ${WHITE}"
            read -r input
            if [ -z "$input" ]; then
                eval "$var_name=\"$input\""
                break
            elif [[ "$input" =~ ^[0-9]{8}$ ]]; then
                eval "$var_name=\"$input\""
                break
            else
                echo -e "${RED}Invalid date format. Please use DDMMYYYY format.${NC}"
            fi
        done
    }
    
    # Function to get yes/no input
    get_yes_no() {
        local prompt="$1"
        local var_name="$2"
        local default="$3"
        
        while true; do
            echo -ne "${CYAN}${prompt} [y/N]: ${WHITE}"
            read -r input
            input=${input:-$default}
            case "$input" in
                [Yy]*)
                    eval "$var_name=true"
                    break
                    ;;
                [Nn]*)
                    eval "$var_name=false"
                    break
                    ;;
                *)
                    echo -e "${RED}Please answer yes or no.${NC}"
                    ;;
            esac
        done
    }
    
    # Collect information
    echo -e "${YELLOW}╔══════════════════════════════════════╗"
    echo -e "║          ${WHITE}PERSONAL INFORMATION${YELLOW}        ║"
    echo -e "╚══════════════════════════════════════╝${NC}"
    get_name "Enter your first name" FIRST_NAME true
    get_name "Enter your surname" SURNAME false
    get_name "Enter your nickname" NICKNAME false
    get_date "Enter your birthday" BIRTHDAY
    
    echo -e "\n${YELLOW}╔══════════════════════════════════════╗"
    echo -e "║           ${WHITE}PARTNER INFORMATION${YELLOW}        ║"
    echo -e "╚══════════════════════════════════════╝${NC}"
    get_name "Enter your partner's name" PARTNERS_NAME false
    get_name "Enter your partner's nickname" PARTNERS_NICKNAME false
    get_date "Enter your partner's birthday" PARTNERS_BIRTHDAY
    
    echo -e "\n${YELLOW}╔══════════════════════════════════════╗"
    echo -e "║            ${WHITE}CHILD INFORMATION${YELLOW}         ║"
    echo -e "╚══════════════════════════════════════╝${NC}"
    get_name "Enter your child's name" CHILDS_NAME false
    get_name "Enter your child's nickname" CHILDS_NICKNAME false
    get_date "Enter your child's birthday" CHILDS_BIRTHDAY
    
    echo -e "\n${YELLOW}╔══════════════════════════════════════╗"
    echo -e "║            ${WHITE}OTHER INFORMATION${YELLOW}         ║"
    echo -e "╚══════════════════════════════════════╝${NC}"
    get_name "Enter your pet's name" PETS_NAME false
    get_name "Enter your company name" COMPANY_NAME false
    
    echo -ne "${CYAN}Enter any extra keywords (space separated): ${WHITE}"
    read -r EXTRA_KEYWORDS
    
    echo -e "\n${YELLOW}╔══════════════════════════════════════╗"
    echo -e "║          ${WHITE}PASSWORD ENHANCEMENTS${YELLOW}       ║"
    echo -e "╚══════════════════════════════════════╝${NC}"
    get_yes_no "Do you want to add extra characters (@, !, #, etc.) at the end of words?" EXTRA_CHARS "N"
    get_yes_no "Add random numbers at the end of words?" RANDOM_NUMBERS "N"
    get_yes_no "Enable leet mode? (i.e. leet = 1337)" LEET_MODE "N"
    
    # Generate the wordlist
    generate_wordlist
}

# Leet conversion function
leet_convert() {
    local word="$1"
    # Basic leet substitutions
    echo "$word" | tr 'aA' '4' | tr 'eE' '3' | tr 'iI' '1' | tr 'oO' '0' | tr 'sS' '5' | tr 'tT' '7'
}

# Generate the wordlist file
generate_wordlist() {
    local filename="$(pwd)/${FIRST_NAME}_wordlist.txt"
    local temp_file=$(mktemp)
    local total_steps=5
    local current_step=0
    
    echo -e "\n${GREEN}Generating wordlist...${NC}"
    
    # Initialize progress
    show_progress $current_step $total_steps
    current_step=$((current_step + 1))
    
    # Add all words to a temporary file
    [ -n "$FIRST_NAME" ] && echo "$FIRST_NAME" >> "$temp_file"
    [ -n "$SURNAME" ] && echo "$SURNAME" >> "$temp_file"
    [ -n "$NICKNAME" ] && echo "$NICKNAME" >> "$temp_file"
    [ -n "$BIRTHDAY" ] && echo "$BIRTHDAY" >> "$temp_file"
    [ -n "$PARTNERS_NAME" ] && echo "$PARTNERS_NAME" >> "$temp_file"
    [ -n "$PARTNERS_NICKNAME" ] && echo "$PARTNERS_NICKNAME" >> "$temp_file"
    [ -n "$PARTNERS_BIRTHDAY" ] && echo "$PARTNERS_BIRTHDAY" >> "$temp_file"
    [ -n "$CHILDS_NAME" ] && echo "$CHILDS_NAME" >> "$temp_file"
    [ -n "$CHILDS_NICKNAME" ] && echo "$CHILDS_NICKNAME" >> "$temp_file"
    [ -n "$CHILDS_BIRTHDAY" ] && echo "$CHILDS_BIRTHDAY" >> "$temp_file"
    [ -n "$PETS_NAME" ] && echo "$PETS_NAME" >> "$temp_file"
    [ -n "$COMPANY_NAME" ] && echo "$COMPANY_NAME" >> "$temp_file"
    
    # Add extra keywords
    for word in $EXTRA_KEYWORDS; do
        echo "$word" >> "$temp_file"
    done
    
    show_progress $current_step $total_steps
    current_step=$((current_step + 1))
    
    # Generate combinations
    if [ -n "$FIRST_NAME" ] && [ -n "$SURNAME" ]; then
        echo "${FIRST_NAME}${SURNAME}" >> "$temp_file"
        echo "${FIRST_NAME}.${SURNAME}" >> "$temp_file"
        echo "${FIRST_NAME}_${SURNAME}" >> "$temp_file"
        echo "${FIRST_NAME:0:1}${SURNAME}" >> "$temp_file"
    fi
    
    if [ -n "$FIRST_NAME" ] && [ -n "$BIRTHDAY" ]; then
        echo "${FIRST_NAME}${BIRTHDAY}" >> "$temp_file"
        echo "${FIRST_NAME}${BIRTHDAY:4:4}" >> "$temp_file" # Just year
    fi
    
    show_progress $current_step $total_steps
    current_step=$((current_step + 1))
    
    # Process leet mode if enabled
    if [ "$LEET_MODE" = true ]; then
        local leet_words=()
        while read -r word; do
            leet_words+=("$(leet_convert "$word")")
        done < "$temp_file"
        printf "%s\n" "${leet_words[@]}" >> "$temp_file"
    fi
    
    show_progress $current_step $total_steps
    current_step=$((current_step + 1))
    
    # Add extra characters if enabled
    if [ "$EXTRA_CHARS" = true ]; then
        local special_chars="@!?#$%^&*"
        while read -r word; do
            for (( i=0; i<${#special_chars}; i++ )); do
                echo "${word}${special_chars:$i:1}" >> "${temp_file}_extra"
            done
        done < "$temp_file"
        cat "${temp_file}_extra" >> "$temp_file"
        rm "${temp_file}_extra"
    fi
    
    # Add random numbers if enabled
    if [ "$RANDOM_NUMBERS" = true ]; then
        while read -r word; do
            # Single digits
            for num in {0..9}; do
                echo "${word}${num}" >> "${temp_file}_numbers"
            done
            # Double digits
            for num in {00..99}; do
                echo "${word}${num}" >> "${temp_file}_numbers"
            done
            # Common years
            for year in {1970..2025}; do
                echo "${word}${year}" >> "${temp_file}_numbers"
            done
        done < "$temp_file"
        cat "${temp_file}_numbers" >> "$temp_file"
        rm "${temp_file}_numbers"
    fi
    
    show_progress $current_step $total_steps
    
    # Remove duplicates and sort
    sort -u "$temp_file" > "$filename"
    rm "$temp_file"
    
    echo -e "\n\n${GREEN}Wordlist generated successfully: ${WHITE}$filename${NC}"
    echo -e "${GREEN}Total passwords generated: ${WHITE}$(wc -l < "$filename")${NC}"
}

# Main execution
if [ "$INTERACTIVE" = true ] || [ $# -eq 0 ]; then
    interactive_mode
fi
