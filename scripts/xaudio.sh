usage() {
  cat <<'EOF'
usage: xaudio [options] video [video...]

  -f FORMAT   copy (default, lossless, no re-encode) | mp3 | m4a | opus | ogg | flac | wav
  -b BITRATE  bitrate for lossy formats, e.g. 192k (defaults: mp3 VBR q2, m4a 192k, opus 128k, ogg q5)
  -s START    start time, e.g. 90 or 00:01:30
  -t LENGTH   duration, e.g. 30 or 00:00:30
  -a N        audio track index, 0-based (default 0)
  -d DIR      output directory (default: next to each input)
  -y          overwrite existing output (default: skip)
  -h          show this help

examples:
  xaudio talk.mp4                      # lossless copy, extension picked from the codec
  xaudio -f mp3 -b 256k *.mkv          # batch convert to mp3
  xaudio -f wav -s 90 -t 30 clip.mov   # 30s of PCM wav starting at 1:30
  xaudio -d ~/Music/rips -f flac a.mp4 b.mp4
EOF
}

die() { echo "xaudio: $1" >&2; exit "${2:-1}"; }

# absolute path without needing GNU realpath (macOS-friendly)
abspath() {
  local d b
  d=$(dirname -- "$1"); b=$(basename -- "$1")
  d=$(cd -- "$d" 2>/dev/null && pwd -P) || return 1
  printf '%s/%s\n' "$d" "$b"
}

# lossless copy: codec name -> file extension (mka holds anything)
ext_for_codec() {
  case $1 in
    aac|alac)                         echo m4a ;;
    mp3)                              echo mp3 ;;
    opus)                             echo opus ;;
    vorbis)                           echo ogg ;;
    flac)                             echo flac ;;
    ac3)                              echo ac3 ;;
    eac3)                             echo eac3 ;;
    dts)                              echo dts ;;
    pcm_s16le|pcm_s24le|pcm_s32le)    echo wav ;;
    *)                                echo mka ;;
  esac
}

fmt=copy track=0 bitrate="" outdir="" start="" dur="" overwrite=-n

while getopts ":f:b:s:t:a:d:yh" opt; do
  case $opt in
    f) fmt=$OPTARG ;;
    b) bitrate=$OPTARG ;;
    s) start=$OPTARG ;;
    t) dur=$OPTARG ;;
    a) track=$OPTARG ;;
    d) outdir=$OPTARG ;;
    y) overwrite=-y ;;
    h) usage; exit 0 ;;
    :) echo "xaudio: option -$OPTARG needs an argument" >&2; usage >&2; exit 2 ;;
    \?) echo "xaudio: unknown option -$OPTARG" >&2; usage >&2; exit 2 ;;
  esac
done
shift $((OPTIND - 1))

[ $# -gt 0 ] || { usage >&2; exit 2; }
command -v ffmpeg  >/dev/null 2>&1 || die "ffmpeg not found in PATH" 127
command -v ffprobe >/dev/null 2>&1 || die "ffprobe not found in PATH" 127

case $fmt in
  copy|mp3|m4a|aac|opus|ogg|flac|wav) ;;
  *) die "unknown format '$fmt' (try: copy mp3 m4a opus ogg flac wav)" 2 ;;
esac

trim=()
[ -n "$start" ] && trim+=(-ss "$start")
[ -n "$dur" ]   && trim+=(-t "$dur")

rc=0
for f in "$@"; do
  if [ ! -f "$f" ]; then
    echo "xaudio: not a file: $f" >&2; rc=1; continue
  fi

  codec_args=()
  case $fmt in
    copy)
      codec=$(ffprobe -v error -select_streams "a:$track" \
                -show_entries stream=codec_name -of default=nw=1:nk=1 -i "$f" 2>/dev/null)
      if [ -z "$codec" ]; then
        echo "xaudio: no audio track $track in: $f" >&2; rc=1; continue
      fi
      ext=$(ext_for_codec "$codec")
      codec_args=(-c:a copy)
      ;;
    mp3)
      ext=mp3; codec_args=(-c:a libmp3lame)
      if [ -n "$bitrate" ]; then codec_args+=(-b:a "$bitrate"); else codec_args+=(-q:a 2); fi
      ;;
    m4a|aac)
      ext=m4a; codec_args=(-c:a aac -b:a "${bitrate:-192k}" -movflags +faststart)
      ;;
    opus)
      ext=opus; codec_args=(-c:a libopus -b:a "${bitrate:-128k}")
      ;;
    ogg)
      ext=ogg; codec_args=(-c:a libvorbis)
      if [ -n "$bitrate" ]; then codec_args+=(-b:a "$bitrate"); else codec_args+=(-q:a 5); fi
      ;;
    flac) ext=flac; codec_args=(-c:a flac) ;;
    wav)  ext=wav;  codec_args=(-c:a pcm_s16le) ;;
  esac

  base=$(basename -- "$f"); base=${base%.*}
  dir=${outdir:-$(dirname -- "$f")}
  mkdir -p -- "$dir" || { rc=1; continue; }
  out=$dir/$base.$ext

  # never clobber the source (e.g. extracting from an .mka/.m4a in place)
  if [ "$(abspath "$out" 2>/dev/null)" = "$(abspath "$f")" ]; then
    out=$dir/$base.audio.$ext
  fi

  if [ -e "$out" ] && [ "$overwrite" = "-n" ]; then
    echo "skip (exists, use -y to overwrite): $out"; continue
  fi

  echo "▶ $f"
  if ffmpeg -hide_banner -loglevel error -stats "$overwrite" \
       ${trim[@]+"${trim[@]}"} -i "$f" -map "0:a:$track" -vn -sn -dn \
       "${codec_args[@]}" "$out"; then
    echo "✔ $out"
  else
    echo "✘ failed: $f" >&2
    rm -f -- "$out"
    rc=1
  fi
done
exit $rc
