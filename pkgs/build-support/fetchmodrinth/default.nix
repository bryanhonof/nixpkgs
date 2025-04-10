{
  lib,
  runCommand,
  curl,
  jq,
  cacert,
}:
lib.fetchers.withNormalizedHash { } (
  {
    name,
    version,
    outputHash,
    outputHashAlgo,
    ...
  }:

  runCommand "${name}-${version}.jar" {
    inherit outputHash outputHashAlgo;
    outputHashMode = "flat";
    preferLocalBuild = true;
    nativeBuildInputs = [ curl jq cacert ];
    SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";
  } ''
    mod_file="$(curl 'https://api.modrinth.com/v2/project/${name}/version/${version}' | jq --raw-output '.files.[0]')"
    url="$(echo "$mod_file" | jq --raw-output '.url')"
    filename="$(echo "$mod_file" | jq --raw-output '.filename')"
    curl -o "$out" "$url"
  ''
)
