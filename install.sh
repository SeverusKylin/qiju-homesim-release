#!/usr/bin/env bash
set -eu

repo='SeverusKylin/qiju-homesim-release'
version="${QIJU_HOMESIM_VERSION:-v0.3.0}"
asset="qiju-homesim-customer-${version#v}.zip"
install_dir="${QIJU_HOMESIM_DIR:-$(pwd)/qiju-homesim}"
work_dir="$(mktemp -d)"
base_url="https://github.com/${repo}/releases/download/${version}"
trap 'rm -rf "$work_dir"' EXIT

curl -fL --retry 3 -o "$work_dir/$asset" "$base_url/$asset"
curl -fL --retry 3 -o "$work_dir/SHA256SUMS" "$base_url/SHA256SUMS"
expected="$(awk -v file="$asset" '$0 ~ ("  " file "$"){print $1; exit}' "$work_dir/SHA256SUMS")"
actual="$(sha256sum "$work_dir/$asset" | awk '{print $1}')"
if [ -z "$expected" ] || [ "$actual" != "$expected" ]; then
  echo '发行包 SHA-256 校验失败。' >&2
  exit 1
fi
if [ -e "$install_dir" ] && [ "$(find "$install_dir" -mindepth 1 -maxdepth 1 | head -n 1)" ]; then
  echo "安装目录不为空：$install_dir" >&2
  exit 1
fi
mkdir -p "$install_dir"
unzip -oq "$work_dir/$asset" -d "$install_dir"
printf '安装完成：%s\n' "$install_dir"
printf '启动：bash ./start-home-sim.sh\n'
