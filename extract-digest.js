#!/usr/bin/env node

const DIGEST_REGEX = /(sha256:.{64})/

// Just extracts the digest output from the docker push
// eg latest: digest: sha256:3cf5c58305d31be36204fcdedfdd5a5cf560e627441ff46b9c1e92c0fa1e2f36 size: 2839
// should return 'sha256:3cf5c58305d31be36204fcdedfdd5a5cf560e627441ff46b9c1e92c0fa1e2f36'

process.stdin.resume()
process.stdin.setEncoding('utf8')
process.stdin.on('data', function (data) {
  if (!data) {
    console.error('Docker status message not found. Did the docker push succeed?')
    process.exit(-1)
  }

  const matches = data.match(DIGEST_REGEX)

  if (matches) {
    console.log(matches[0])
    process.exit(0)
  } else {
    console.error('Digest not found in the message.')
    process.exit(-1)
  }
})

