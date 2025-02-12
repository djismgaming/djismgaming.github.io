# yt-dlp command to transcode video to h264 after download


```bash
yt-dlp --recode-video mp4 --force-write-archive https://www.youtube.com/watch?v=dQw4w9WgXcQ
```

Here's a breakdown:

*   `--recode-video mp4`: This option tells `yt-dlp` to transcode the video into an MP4 container.
*   `<video_url>`: Replace this with the URL of the video.
*   `--force-write-archive`: This option forces `yt-dlp` to re-encode the video.
