gitignore () {
    if [ $# -lt 1 ]; then
        echo "Usage: gitignore <language name>"
        echo ""
        echo "Downloads a handy pre-made gitignore file for a given language."
        echo "Full list available at https://github.com/github/gitignore."
        return 1
    fi

    if [ -f ./.gitignore ]; then
        echo ".gitignore already exists!" >&2
        return 1
    fi

    local lang=$1
    local base_url="https://raw.githubusercontent.com/github/gitignore/master"
    local url="${base_url}/${lang}.gitignore"

    curl -fs ${url} -o .gitignore
    curl_res=$?

    if [ $curl_res -ne 0 ]; then
        echo "Could not fetch ${url}" >&2
        return 1
    fi

    echo "Fetched ${url}"
}
