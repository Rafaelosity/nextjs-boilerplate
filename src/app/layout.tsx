import type { Metadata } from 'next'
import './globals.scss'

export const metadata: Metadata = {
  title: {
    default: 'Project Name',
    template: '%s | Project Name',
  },
  description: 'Project description',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}
