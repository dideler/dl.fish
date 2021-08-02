function setup
    command mkdir -p ~/Music
end

function teardown
    command rm -rf ~/Music/1\ Second\ Video.mp3
end

@test "downloads a YouTube video as an MP3 in the Music directory" -e (
    dl "https://www.youtube.com/watch?v=Wch3gJG2GJ4"
    command ls ~/Music/1\ Second\ Video.mp3
)
