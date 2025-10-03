#!/bin/bash

# Configuration
CACHE_FILE="/tmp/weather_cache"
UPDATE_INTERVAL=60 # 1 minute in seconds

# wttr.in format string: 
# %l (location), %c (condition symbol), %t (temperature), %f (temperature feels like), %C (condition text), %w (wind), %h (humidity), %p (percipitation (mm/3 hours)), %P (pressure Hpa), %u (UV index), %m (moon phase symbol), %M (moon day), %s (sunest time (local time)), %S (sunrise time (local time))
# you need a "+" sign for everything after the ":"
# you can also add "|" to divide things
# if you want the tempuratre to be in metric add "&%m" after "%t" NOTE: This will cause other things in your string to not show.
# an example could be "https://wttr.in/?format=%l:+%t+%f+%w+%s+%S" this shows the locations (%l) the temp (%t) feels like (%f) wind (%w) and sunrise/sunset (%s/%S respectively)
# I would recommend just using this that just tell you the location (Handy with a laptop) and the temperature. If you don't want the location. simply remove the "%l" and replace it with "Temperature" or leave it blank.
WTTR_URL="wttr.in?format=%l:+%t"

# Check if cache file exists
if [[ -f "$CACHE_FILE" ]]; then
    # Check if cache is stale
    if [[ $(($(date +%s) - $(stat -c %Y "$CACHE_FILE"))) -ge $UPDATE_INTERVAL ]]; then
        # Cache is stale, update in background
        (
            NEW_DATA=$(curl -s "$WTTR_URL")
            # Update cache only if curl was successful and returned data
            [[ -n "$NEW_DATA" ]] && echo "$NEW_DATA" > "$CACHE_FILE"
        ) &
    fi
    # Output current cache content immediately
    cat "$CACHE_FILE"
else
    # No cache: fetch now, save, output
    NEW_DATA=$(curl -s "$WTTR_URL")
    # Save to cache if data is retrieved
    [[ -n "$NEW_DATA" ]] && echo "$NEW_DATA" | tee "$CACHE_FILE"
fi
