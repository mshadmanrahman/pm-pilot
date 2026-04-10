#!/usr/bin/env bash

# PM Pilot demo simulation script
# Simulates the meeting-prep skill output with realistic typing and delays

# ANSI color codes
GREEN='\033[0;32m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
DIM='\033[2m'
RESET='\033[0m'
BOLD='\033[1m'

# Simulate typing a command character by character
type_cmd() {
  local text="$1"
  printf "${WHITE}\$ ${RESET}"
  for (( i=0; i<${#text}; i++ )); do
    printf "%s" "${text:$i:1}"
    sleep 0.06
  done
  printf "\n"
  sleep 0.4
}

type_cmd "prep for my 1:1 with Sarah"

sleep 0.5
printf "${DIM}Checking connected sources...${RESET}\n"
sleep 0.6

printf "  ${GREEN}✓${RESET} Jira - 3 open tickets assigned to Sarah\n"
sleep 0.4

printf "  ${GREEN}✓${RESET} Slack - 2 unresolved threads in #product\n"
sleep 0.4

printf "  ${GREEN}✓${RESET} Calendar - Last 1:1 was Mar 28 (2 open action items)\n"
sleep 0.7

printf "\n"
printf "${CYAN}-- Meeting Brief -----------------------------------------${RESET}\n"
sleep 0.4

printf "\n"
printf "${WHITE}${BOLD}Sarah's focus:${RESET} Migrating auth service (blocked on DevOps)\n"
sleep 0.5

printf "\n"
printf "${WHITE}${BOLD}You owe her:${RESET}\n"
sleep 0.3
printf "  API spec review (promised Mar 28)\n"
sleep 0.5

printf "\n"
printf "${WHITE}${BOLD}She owes you:${RESET}\n"
sleep 0.3
printf "  Updated timeline for Q2 roadmap\n"
sleep 0.7

printf "\n"
printf "${CYAN}-- Suggested talking points ------------------------------${RESET}\n"
sleep 0.4

printf "\n"
printf "  ${WHITE}1.${RESET} Unblock auth migration - offer to escalate with DevOps\n"
sleep 0.45

printf "  ${WHITE}2.${RESET} API spec review - share your status or ask for extension\n"
sleep 0.45

printf "  ${WHITE}3.${RESET} Q2 roadmap timeline - get her latest estimate\n"
sleep 0.7

printf "\n"
printf "${DIM}Ready in 28 seconds. Your meeting is in 45 minutes.${RESET}\n"
sleep 1.5
