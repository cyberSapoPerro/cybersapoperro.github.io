#import "@tola/address:0.0.0": output-url

/// Select published articles under the blog directory.
#let get-posts(pages) = {
  pages
    .filter(page => {
      let segments = page.source.route-segments
      segments.len() > 1 and segments.at(0) == "blog" and page.source.meta.published != none
    })
    .sorted(
      key: page => page.source.meta.published.unix-seconds,
    )
}

/// Render the list of blog posts.
#let blog-list(pages) = {
  let posts = get-posts(pages)

  if posts.len() == 0 {
    html.elem("p")[Todavía no hay publicaciones.]
  } else {
    html.section(class: "post-list")[
      #for post in posts {
        let meta = post.source.meta

        html.article(class: "post-list-item")[
          #html.h2[
          #link(output-url(post.output))[#meta.title]
          ]

          #html.time[
          #meta.published.rfc3339
          ]

          #if meta.description != none [
            #html.p[#meta.description]
          ]

          #if meta.tags.len() > 0 [
            #html.p(class: "post-tags")[
            #meta.tags.join(", ")
            ]
          ]
        ]
      }
    ]
  }
}
