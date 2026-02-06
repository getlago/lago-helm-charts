tmpf=$(mktemp)

case "$(uname -m)" in
  x86_64|amd64)
    url="https://github.com/redpanda-data/redpanda/releases/download/v25.2.5/rpk-linux-amd64.zip"
    ;;
  aarch64|arm64)
    url="https://github.com/redpanda-data/redpanda/releases/download/v25.2.5/rpk-linux-arm64.zip"
    ;;
  *)
    echo "Unsupported architecture: $arch"
    exit 1
    ;;
esac
wget -qO- "$url" > "$tmpf"
unzip -o "$tmpf"

./rpk topic list | awk -v expected="$topics" '
BEGIN {
    n = split(expected, exp_array, " ")
    for (i = 1; i <= n; i++) expected_topics[exp_array[i]] = 1
} NR > 1 {
    topic = $1
    if (topic in expected_topics) printf "%s ", topic
}' | xargs -r ./rpk topic delete
