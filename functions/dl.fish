function __dl_print_help
    printf "Usage: dl [OPTION] 'URL'\n\n"
    printf "Description:\n"
    printf "    Download media easily from the web\n\n"
    printf "Examples:\n"
    printf "    dl 'https://example.com/media-id'\n\n"
    printf "Options:\n"
    printf "    -h, --help      Prints helps\n"
    printf "    -v, --version   Prints version"
end

function __dl_print_version
    echo "dl version 1.2.2"
end

function dl --description "Opinionated alias for youtube-dl"
    set --local options 'h/help' 'v/version'
    argparse $options -- $argv

    if set --query _flag_help
        __dl_print_help
        return 0
    else if set --query _flag_version
        __dl_print_version
        return 0
    end

    for path in $argv
        __dl_download $path
    end
end

function __dl_download --argument path
    set --local output_dir "$HOME/Music"
    set --local yt_dl_options "--ignore-config" \
                              "--quiet" \
                              "--no-mtime" \
                              "--output '$output_dir/%(title)s.%(ext)s'" \
                              "--extract-audio" \
                              "--audio-format mp3"
    set --local dl_cmd "youtube-dl $yt_dl_options '$path'"
    set --local spinner_msg " @ Saving to $output_dir\r"

    spin --format $spinner_msg $dl_cmd
end
