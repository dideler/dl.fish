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
