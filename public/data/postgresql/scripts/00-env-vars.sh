#!/bin/bash

# List of apps (for loop iteration)
apps=(
    "AUTHELIA"
    "HASS"
    "FRIGATE"
    "GRAFANA"
)

# Usernames
DB_USER_AUTHELIA=authelia
DB_USER_GRAFANA=grafana
DB_USER_HASS=hass
DB_USER_FRIGATE=frigate

# Databases
DB_NAME_AUTHELIA=authelia_db
DB_NAME_GRAFANA=grafana_db
DB_NAME_HASS=hass_db
DB_NAME_FRIGATE=frigate_db
