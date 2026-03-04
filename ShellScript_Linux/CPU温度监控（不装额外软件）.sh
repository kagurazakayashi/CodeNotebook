#!/bin/bash

declare -A h_max
gh_max=0  # 全局歷史最高
trap "exit" SIGINT

while true; do
    clear
    printf "%-20s %-10s %-10s\n" "ID" "CUR" "H-MAX"

    sum=0
    count=0
    g_max=0

    for dir in /sys/class/hwmon/hwmon*; do
        if [[ -f "$dir/name" ]]; then
            name=$(cat "$dir/name")
            if [[ "$name" == "coretemp" || "$name" == "k10temp" ]]; then
                for file in "$dir"/temp*_input; do
                    if [[ -f "$file" ]]; then
                        val_raw=$(cat "$file")
                        val=$((val_raw / 1000))
                        
                        label_f="${file%_input}_label"
                        label=$( [[ -f "$label_f" ]] && cat "$label_f" || echo "Sensor" )
                        
                        # 更新單核歷史最高
                        [[ -z "${h_max[$file]}" || $val -gt ${h_max[$file]} ]] && h_max[$file]=$val
                        # 更新當前全核最高
                        [[ $val -gt $g_max ]] && g_max=$val
                        # 更新全局總歷史最高
                        [[ $val -gt $gh_max ]] && gh_max=$val
                        
                        sum=$((sum + val_raw))
                        count=$((count + 1))

                        printf "%-20s %-10s %-10s\n" "$label" "${val}°C" "${h_max[$file]}°C"
                    fi
                done
            fi
        fi
    done

    # 最後一行匯總
    if [[ $count -gt 0 ]]; then
        avg=$(awk "BEGIN {printf \"%.1f\", $sum / $count / 1000}")
        # 格式：日期時間 | 核心數 | 全核當前最高 | 總歷史最高 | 總平均
        echo "$(date '+%Y-%m-%d %H:%M:%S') | Cores: $count"
        echo "MAX: ${g_max}°C | H-MAX: ${gh_max}°C | AVG: ${avg}°C"
    fi

    sleep 1
  done
