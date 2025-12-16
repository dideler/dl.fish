function setup
    command mkdir -p ~/Music
end

function teardown
    command rm -rf ~/Music/1\ Second\ Video.mp3
end

set -l url "https://www.youtube.com/watch?v=Wch3gJG2GJ4"

@test "downloads a YouTube video as an MP3 in the Music directory" (
    dl $url > /dev/null
    test -e ~/Music/1\ Second\ Video.mp3
) $status -eq 0

@test "--version displays both tool versions" (
    set -l lines (dl --version)

    test (count $lines) -eq 2
    and string match -qr '^dl version \d+\.\d+\.\d+$' $lines[1]
    and string match -qr '^yt-dlp version \d{4}\.\d{2}\.\d{2}$' $lines[2]
) $status -eq 0
