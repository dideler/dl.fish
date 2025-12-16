function __dl_print_help
    echo "Usage: dl [OPTION] URL"
    echo
    echo "Description:"
    echo "    Download audio (MP3) from YouTube, SoundCloud, etc. to your Music folder"
    echo
    echo "Options:"
    echo "    -h, --help      Show this help message"
    echo "    -v, --version   Show version information"
    echo "    -s, --silent    Suppress progress spinner"
    echo
    echo "Examples:"
    echo "    dl https://youtube.com/watch?v=abc123"
end

function __dl_print_version
    set -l dl_version "1.2.5"
    set -l ytdlp_version (yt-dlp --version 2>/dev/null; or echo "not installed")
    printf "dl version %s\nyt-dlp version %s\n" $dl_version $ytdlp_version
end

function dl --description "Download audio with yt-dlp"
    set --local options 'h/help' 'v/version' 's/silent'
    argparse $options -- $argv; or return

    if set --query _flag_help
        __dl_print_help; return 0
    else if set --query _flag_version
        __dl_print_version; return 0
    end

    set --local silent (set --query _flag_silent && echo 1 || echo 0)

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
