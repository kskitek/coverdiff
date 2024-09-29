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

> diff_raw
for pkg in "${!all_pkgs[@]}"; do
  before="${coverage_before[$pkg]}"
  after="${coverage_after[$pkg]}"

  if [[ -z "$before" ]]; then
    echo "| $pkg | - | ${after}% | :heavy_check_mark: |" >> diff_raw
    continue
  elif [[ -z "$after" ]]; then
    echo "| $pkg | ${before}% | - | :question: |" >> diff_raw
    continue
  fi

  if [[ "$before" -gt "$after" ]]; then
    echo "| $pkg | ${before}% | ${after}% | :x: |" >> diff_raw
  else
    echo "| $pkg | ${before}% | ${after}% | :heavy_check_mark: |" >> diff_raw
  fi
done

echo "Test coverage changes:" > diff
echo "| Package | Before | After | Diff |" >> diff
echo "|-|-|-|-|" >> diff
cat diff_raw | sort >> diff

cat diff
