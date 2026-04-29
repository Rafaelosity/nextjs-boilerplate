#!/usr/bin/env node
/**
 * Pre-build image optimizer for public/images/
 * Compresses originals in-place using the same quality settings as next/image.
 * Run: node scripts/optimize-images.js
 * Runs automatically via: npm run build
 */

import sharp from 'sharp'
import { readdir, stat } from 'fs/promises'
import { join, extname, basename } from 'path'

const INPUT_DIR = 'public/images'

const QUALITY = {
  jpeg: 75,
  jpg: 75,
  png: 80,
  webp: 75,
  avif: 50,
}

async function getFiles(dir) {
  const entries = await readdir(dir, { withFileTypes: true })
  const files = await Promise.all(
    entries.map((entry) => {
      const fullPath = join(dir, entry.name)
      return entry.isDirectory() ? getFiles(fullPath) : fullPath
    })
  )
  return files.flat()
}

async function optimizeImage(filePath) {
  const ext = extname(filePath).slice(1).toLowerCase()
  const quality = QUALITY[ext]
  if (!quality) return

  const { size: before } = await stat(filePath)
  const image = sharp(filePath)

  switch (ext) {
    case 'jpeg':
    case 'jpg':
      await image.jpeg({ quality, mozjpeg: true }).toFile(filePath + '.tmp')
      break
    case 'png':
      await image.png({ quality, compressionLevel: 9 }).toFile(filePath + '.tmp')
      break
    case 'webp':
      await image.webp({ quality }).toFile(filePath + '.tmp')
      break
    case 'avif':
      await image.avif({ quality }).toFile(filePath + '.tmp')
      break
    default:
      return
  }

  const { rename } = await import('fs/promises')
  await rename(filePath + '.tmp', filePath)

  const { size: after } = await stat(filePath)
  const saved = (((before - after) / before) * 100).toFixed(1)
  console.log(`  ${basename(filePath)}: ${(before / 1024).toFixed(1)}KB → ${(after / 1024).toFixed(1)}KB (${saved}% saved)`)
}

async function main() {
  let files
  try {
    files = await getFiles(INPUT_DIR)
  } catch {
    // public/images doesn't exist yet — nothing to optimize
    return
  }

  const imageFiles = files.filter((f) => /\.(jpe?g|png|webp|avif)$/i.test(f))
  if (imageFiles.length === 0) {
    console.log('optimize-images: no images found in public/images/')
    return
  }

  console.log(`optimize-images: processing ${imageFiles.length} file(s)...`)
  await Promise.all(imageFiles.map(optimizeImage))
  console.log('optimize-images: done')
}

main().catch((err) => {
  console.error('optimize-images failed:', err.message)
  process.exit(1)
})
