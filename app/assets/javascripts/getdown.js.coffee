$ ->
  max = 0
  $("td.chord-list").each ->
    subcount = $(this).find("span").length
    if subcount > max
      max = subcount

  $("td.chord-list").addClass("chords-" + max)
