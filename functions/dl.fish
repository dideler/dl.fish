function __dl_print_help
    echo "Usage: dl [OPTION] URL"
    echo
    echo "Description:"
    echo "    Easily download songs to your Music directory."
    echo "    Currently limited to audio (MP3) only."
    echo "    Depends on yt-dlp."
    echo
    echo "Examples:"
    echo "    dl 'https://www.youtube.com/watch?v=some-video'"
    echo "    dl https://soundcloud.com/some-profile/some-song"
    echo
    echo "Options:"
    echo "    -h, --help      Prints helps"
    echo "    -v, --version   Prints version"
    echo "    -s, --silent    Silent mode"
end

function __dl_print_version
    set -l dl_version "1.2.5"
    set -l ytdlp_version (yt-dlp --version 2>/dev/null)
    if test -z "$ytdlp_version"
        set ytdlp_version "not installed"
    end
    printf "dl version %s\n" $dl_version
    printf "yt-dlp version %s" $ytdlp_version
end

function dl --description "Opinionated alias for yt-dlp"
    set --local options 'h/help' 'v/version' 's/silent'
    argparse $options -- $argv; or return

    if set --query _flag_help
        __dl_print_help
        return 0
    else if set --query _flag_version
        __dl_print_version
        return 0
    end

    set --local silent 0
    if set --query _flag_silent; set silent 1; end

    for url in $argv
        __dl_download $url $silent
    end
end

function __dl_download --argument-names url silent
    set --local output_dir "$HOME/Music"
    set --local yt_dl_options "--ignore-config" \
                              "--quiet" \
                              "--no-mtime" \
                              "--embed-metadata" \
                              "--output '$output_dir/%(title)s.%(ext)s'" \
                              "--extract-audio" \
                              "--audio-format mp3"
    set --local dl_cmd "yt-dlp $yt_dl_options '$url'"
    if test $silent -eq 1
        eval $dl_cmd
    else
        set --local clear_line "\r\033[K"
        set --local spinner_msg " @ Saving to $output_dir\r"
        spin --interval=100 --format="$spinner_msg" "$dl_cmd" && printf $clear_line
    end
end
