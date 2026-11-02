#import "@tola/address:0.0.0": output-url

#let site-name = "Mi blog"

#let site-navigation() = {
  html.nav(
    aria-label: "Navegación principal",
    class: "site-navigation",
  )[
    #html.a(href: output-url("index.html"), class: "site-brand")[#site-name]

    #html.div(class: "navigation-links")[
      #html.a(href: output-url("index.html"))[Inicio]
      #html.a(href: output-url("blog/index.html"))[Blog]
      #html.a(href: output-url("about/index.html"))[Acerca de]
    ]
  ]
}
