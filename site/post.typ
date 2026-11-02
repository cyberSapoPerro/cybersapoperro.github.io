#import "@tola/address:0.0.0": output-url

#let post-header(meta) = {
  html.header(class: "post-header")[
    #html.h1[#meta.title]

    #if meta.published != none [
      #html.p(class: "post-date")[
        #meta.published.rfc3339
      ]
    ]

    #if meta.tags.len() > 0 [
      #html.p(class: "post-tags")[
        #meta.tags.join(", ")
      ]
    ]
  ]
}
