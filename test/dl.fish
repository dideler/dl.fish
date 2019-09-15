function setup
    command mkdir -p ~/Music
end

function teardown
    command rm -rf ~/Music/quality\ content.mp3
end

@test "downloads a YouTube video as an MP3 in the Music directory" -e (
    dl "https://www.youtube.com/watch?v=J1R5S-X9DEw"
    command ls ~/Music/quality\ content.mp3
)
