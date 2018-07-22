function __dl_print_version
    echo "dl version 1.0.0"
end

function dl --description "Opinionated alias for youtube-dl"
    argparse 'v/version' -- $argv

    if set --query _flag_version
        __dl_print_version
        return 0
    end

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
