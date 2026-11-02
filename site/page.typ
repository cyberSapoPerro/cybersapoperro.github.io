#import "@tola/code:0.0.0": code-stylesheet, code-themes, render-code
#import "@tola/site:0.0.0": site
#import "@tola/address:0.0.0": asset-url
#import "seo.typ": head-entries
#import "navigation.typ": site-navigation
#import "posts.typ": is-post
#import "post.typ": post-header
#import "blog.typ": blog-list

/// Write one page to its output file as a complete HTML document.
///
/// - page (dictionary): one `(source:, output:)` record from `select-pages`.
/// -> content
#let page-template(page, pages) = {
  let meta = page.source.meta
  let authors = if meta.authors == none {
    ()
  } else {
    meta.authors.map(author => if type(author) == dictionary { author.name } else { author })
  }
  document(
    page.output,
    format: "html",
    title: meta.title,
    description: meta.description,
    author: authors,
    keywords: meta.tags,
  )[
    #set raw(theme: code-themes.github)
    #show raw: render-code.with(dark-theme: code-themes.github-dark)
    #html.html(lang: site.language.tag)[
      #html.head[
        #for entry in head-entries(meta.title, description: meta.description, page: page) {
          entry
        }
        #html.link(
          rel: "stylesheet",
          href: asset-url("/assets/css/style.css")
        )
        #code-stylesheet()
      ]
      #html.body[
        #site-navigation()
        #html.main[
          #if is-post(page) {
            post-header(meta)
            include page.source.file
          } else {
            include page.source.file
          }
          #if page.output == "blog/index.html" [
            #blog-list(pages)
          ]
        ]
      ]
    ]
  ]
}
