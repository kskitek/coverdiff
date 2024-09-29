#!/bin/bash
set -oe pipefail

declare -A coverage_before
while read -r pkg x; do
  coverage_before["$pkg"]="$x"
done < "before.cover"

declare -A coverage_after
while read -r pkg x; do
  coverage_after["$pkg"]="$x"
done < "after.cover"

declare -A all_pkgs
for pkg in "${!coverage_before[@]}"; do
  all_pkgs["$pkg"]=1
done
for pkg in "${!coverage_after[@]}"; do
  all_pkgs["$pkg"]=1
done

> diff
for pkg in "${!all_pkgs[@]}"; do
  before="${coverage_before[$pkg]}"
  after="${coverage_after[$pkg]}"

  if [[ -z "$before" ]]; then
    echo "| $pkg | - | ${after}% | :heavy_check_mark: |" >> diff
    continue
  elif [[ -z "$after" ]]; then
    echo "| $pkg | ${before}% | - | :question: |" >> diff
    continue
  fi

  if [[ "$before" -gt "$after" ]]; then
    echo "| $pkg | ${before}% | ${after}% | :x: |" >> diff
  else
    echo "| $pkg | ${before}% | ${after}% | :havy_check_mark: |" >> diff
  fi
done

cat diff | sort
