function ebdeploy() {
	eb deploy --timeout 30 --label "$(git rev-parse --short HEAD)-$(date +%Y-%m-%dT%H:%M:%SZ)"
}
