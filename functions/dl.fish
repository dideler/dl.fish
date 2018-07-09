function dl --description "Opinionated alias for youtube-dl"
    for path in $argv
        __dl_download $path
    end
end

function __dl_download --argument path
    youtube-dl  --ignore-config \
                --quiet \
                --no-mtime \
                --output "~/Music/%(title)s.%(ext)s" \
                --extract-audio \
                --audio-format mp3 \
                $path
end
