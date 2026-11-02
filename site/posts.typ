#import "@tola/address:0.0.0": output-url

#let is-post(page) = {
  let segments = page.source.route-segments

  segments.len() >= 2 and segments.at(0) == "blog"
}

#let get-posts(pages) = {
  pages
    .filter(is-post)
    .filter(page => page.source.meta.published != none)
    .sorted(key: page => (
      -page.source.meta.published.unix-seconds,
      page.source.meta.published.subsecond,
    ))
}

#let post-link(page) = {
  link(output-url(page.output))[#page.source.meta.title]
}
