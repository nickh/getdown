// Import styles
import '../css/application.css'

// Application state
let songs = []
let currentSong = null
let currentView = 'list' // 'list' or 'song'

// Simple client-side routing
function handleRouting() {
  const hash = window.location.hash.slice(1) // Remove #
  const [route, id] = hash.split('/')
  
  if (route === 'songs' && id) {
    showSong(parseInt(id))
  } else {
    showSongList()
  }
}

// Load songs data
async function loadSongs() {
  try {
    const response = await fetch('/src/data/songs.json')
    songs = await response.json()
    return songs
  } catch (error) {
    console.error('Error loading songs:', error)
    return []
  }
}

// Simple chord colorization (simplified version of the Rails chordpro gem functionality)
function colorizeChords(songBody) {
  // Basic chord parsing and colorization
  // This is a simplified version - the Rails app used a full chordpro parser
  const lines = songBody.split('\n')
  let html = '<table class="song">'
  
  lines.forEach(line => {
    if (line.trim() === '') {
      html += '<tr><td colspan="2">&nbsp;</td></tr>'
    } else if (line.includes('{c:') || line.includes('{title:') || line.includes('{soc}') || line.includes('{eoc}')) {
      // Handle chordpro directives
      const content = line.replace(/\{[^}]*\}/g, match => {
        if (match.includes('{c:')) {
          return `<strong>${match.replace('{c:', '').replace('}', '')}</strong>`
        } else if (match.includes('{title:')) {
          return `<h3>${match.replace('{title:', '').replace('}', '')}</h3>`
        }
        return ''
      })
      if (content.trim()) {
        html += `<tr><td colspan="2" class="section">${content}</td></tr>`
      }
    } else {
      // Parse chord/lyric lines
      const chordMatches = [...line.matchAll(/\[([^\]]+)\]/g)]
      if (chordMatches.length > 0) {
        let chordHtml = '<td class="chord-list">'
        let lyricHtml = '<td class="lyric-line">'
        
        let lastIndex = 0
        chordMatches.forEach(match => {
          const chord = match[1]
          const position = match.index
          
          // Add lyrics before this chord
          const lyrics = line.substring(lastIndex, position)
          lyricHtml += lyrics
          
          // Add chord with color
          chordHtml += `<span class="chord-${chord.replace(/[^a-zA-Z0-9]/g, '')}">${chord}</span> `
          
          lastIndex = position + match[0].length
        })
        
        // Add remaining lyrics
        lyricHtml += line.substring(lastIndex)
        
        chordHtml += '</td>'
        lyricHtml += '</td>'
        
        html += `<tr>${chordHtml}${lyricHtml}</tr>`
      } else {
        // Line without chords
        html += `<tr><td colspan="2" class="lyric-only">${line}</td></tr>`
      }
    }
  })
  
  html += '</table>'
  return html
}

// Show song list
function showSongList() {
  currentView = 'list'
  const app = document.getElementById('app')
  
  let html = `
    <h2>These are all the songs</h2>
    <table>
      <tr><th>Added by</th><th>Artist</th><th>Song</th></tr>
  `
  
  songs.forEach(song => {
    html += `
      <tr>
        <td>${song.user}</td>
        <td>${song.artist}</td>
        <td><a href="#songs/${song.id}">${song.name}</a></td>
      </tr>
    `
  })
  
  html += '</table>'
  app.innerHTML = html
}

// Show individual song
function showSong(songId) {
  currentView = 'song'
  const song = songs.find(s => s.id === songId)
  
  if (!song) {
    document.getElementById('app').innerHTML = '<p>Song not found</p>'
    return
  }
  
  currentSong = song
  const app = document.getElementById('app')
  
  const html = `
    <div>
      <a href="#" onclick="showSongList()">&larr; Back to songs</a>
      <h2>${song.artist}: ${song.name}</h2>
      ${colorizeChords(song.body)}
    </div>
  `
  
  app.innerHTML = html
  
  // Apply chord width calculation (similar to original CoffeeScript)
  setTimeout(() => {
    let max = 0
    const chordLists = document.querySelectorAll('td.chord-list')
    chordLists.forEach(td => {
      const spanCount = td.querySelectorAll('span').length
      if (spanCount > max) {
        max = spanCount
      }
    })
    
    chordLists.forEach(td => {
      td.classList.add(`chords-${max}`)
    })
  }, 10)
}

// Initialize the app
async function init() {
  console.log('Initializing Getdown app...')
  
  // Load songs
  await loadSongs()
  console.log('Loaded songs:', songs)
  
  // Set up routing
  window.addEventListener('hashchange', handleRouting)
  
  // Make functions globally available for onclick handlers
  window.showSongList = showSongList
  window.showSong = showSong
  
  // Initial route
  handleRouting()
}

// Start the app when DOM is loaded
document.addEventListener('DOMContentLoaded', init)