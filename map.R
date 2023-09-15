library(tidyverse)
library(maps)
library(plotly)


# MD All -----------------------------------------

## Create data frame of lab cities -----
data("world.cities")
md_cities <- world.cities %>%
  filter((name == "Auburn" & country.etc == "USA" & lat == 32.59) |
           (name == "Boston" & country.etc == "USA") |
           (name == "Budapest" & country.etc == "Hungary") |
           (name == "Buenos Aires" & country.etc == "Argentina") |
           (name == "Durham" & country.etc == "USA") |
           (name == "Kingston" & country.etc == "Canada") |
           (name == "Lexington" & country.etc == "USA") |
           (name == "Lincoln" & country.etc == "USA" & lat == 40.82) |
           (name == "Messina" & country.etc == "Italy") |
           (name == "New Haven" & country.etc == "USA") |
           (name == "New York" & country.etc == "USA") |
           (name == "Portsmouth" & country.etc == "UK") |
           (name == "Providence" & country.etc == "USA") |
           (name == "Rijeka" & country.etc == "Croatia") |
           (name == "Rochester Hills" & country.etc == "USA") |
           (name == "Saint John's" & country.etc == "Canada") |
           (name == "Santa Rosa" & country.etc == "USA") |
           (name == "Tucson" & country.etc == "USA") |
           (name == "Vienna" & country.etc == "Austria") |
           (name == "Warsaw" & country.etc == "Poland") |
           (name == "Winchester" & country.etc == "UK") |
           (name == "Winnipeg" & country.etc == "Canada")
  ) %>%
  select(city = name, country = country.etc, lat, long) %>%
  mutate(lab = c("Canine Performance Sciences, Auburn University",
                 "Canine Cognition Center, Boston College",
                 "The Family Dog Project, Eötvös Loránd University",
                 "Canid Behavior Research Group, National Scientific and Technical Research Council",
                 "Duke Canine Cognition Center, Duke University",
                 "Social Cognition Lab, Queen’s University",
                 "Transylvania University",
                 "Canine Cognition and Human Interaction Lab, University of Nebraska-Lincoln ",
                 "Pet Behaviour Consulting, Università degli Studi di Messina",
                 "Canine Cognition Center, Yale University",
                 "Thinking Dog Center, Hunter College",
                 "Dog Cognition Centre, University of Portsmouth",
                 "Brown Dog Lab, Brown University",
                 "Comparative Cognitive Science Lab, University of Rijeka",
                 "Leader Dogs for the Blind",
                 "Canine Research Unit, Memorial University",
                 "Canine Companions",
                 "Arizona Canine Cognition Center, University of Arizona",
                 "The Clever Dog Lab, University of Veterinary Medicine Vienna",
                 "Department of Psychology of Individual Differences, University of Warsaw",
                 "Animal Health and Welfare Centre, University Centre Sparsholt",
                 "Comparative Cognition Lab, University of Manitoba"),
         .before = 1) #%>%
# add_row(lab = "lab name", city = "city", country = "country", lat = 46.73, long = -117.17)


## Plot labs -------------------------------------------------

# geo styling
md_labs <- list(
  scope = 'world',
  showland = TRUE,
  landcolor = toRGB("grey83"),
  subunitcolor = toRGB("white"),
  countrycolor = toRGB("white"),
  coastlinecolor = toRGB("white"),
  showlakes = FALSE,
  # lakecolor = toRGB("white"),
  showsubunits = FALSE,
  showcountries = TRUE,
  resolution = 50,
  lonaxis = list(
    showgrid = FALSE,
    gridwidth = 0.5,
    range = c(-130, 30),
    dtick = 5
  ),
  lataxis = list(
    showgrid = FALSE,
    gridwidth = 0.5,
    range = c(-45, 60),
    dtick = 5
  )
)

md_labs_fig <- plot_geo(md_cities, lat = ~lat, lon = ~long, size = 100) %>%
  add_markers(text = ~md_cities$lab, hoverinfo = "text",
              marker=list(sizeref=0.5, sizemode="area")) %>%
  layout(geo = md_labs, margin = list(t = 0, r = 0, b = 0, l = 0))

md_labs_fig
save_image(md_labs_fig, "md_labs.png")
htmlwidgets::saveWidget(partial_bundle(md_labs_fig), "md_labs.html", selfcontained = FALSE, libdir = "lib")

file.copy(from = "md_labs.html", to = "../manydogsproject.github.io/_site/images/html/md_labs.html", overwrite = TRUE)
file.copy(from = "lib", to = "../manydogsproject.github.io/docs/images/html", overwrite = TRUE, recursive = TRUE)
file.copy(from = "md_labs.html", to = "/home/jstevens/github/manydogsproject.github.io/images/html/md_labs.html", overwrite = TRUE)
file.copy(from = "lib", to = "/home/jstevens/github/manydogsproject.github.io/images/html", overwrite = TRUE, recursive = TRUE)
# file.copy(from = "lib", to = "/home/jstevens/github/manydogsproject.github.io/_site/images/html", overwrite = TRUE, recursive = TRUE)



# MD 1 -----------------------------------------

## Create data frame of lab cities -----
md1_cities <- world.cities %>%
  filter((name == "Auburn" & country.etc == "USA" & lat == 32.59) |
           (name == "Boston" & country.etc == "USA") |
           (name == "Budapest" & country.etc == "Hungary") |
           (name == "Buenos Aires" & country.etc == "Argentina") |
           (name == "Durham" & country.etc == "USA") |
           (name == "Kingston" & country.etc == "Canada") |
           # (name == "Lexington" & country.etc == "USA") |
           (name == "Lincoln" & country.etc == "USA" & lat == 40.82) |
           (name == "Messina" & country.etc == "Italy") |
           (name == "New Haven" & country.etc == "USA") |
           (name == "New York" & country.etc == "USA") |
           (name == "Portsmouth" & country.etc == "UK") |
           (name == "Providence" & country.etc == "USA") |
           (name == "Rijeka" & country.etc == "Croatia") |
           (name == "Rochester Hills" & country.etc == "USA") |
           (name == "Saint John's" & country.etc == "Canada") |
           (name == "Santa Rosa" & country.etc == "USA") |
           (name == "Tucson" & country.etc == "USA") |
           (name == "Vienna" & country.etc == "Austria") |
           (name == "Warsaw" & country.etc == "Poland") |
           (name == "Winchester" & country.etc == "UK") |
           (name == "Winnipeg" & country.etc == "Canada")
  ) %>%
  select(city = name, country = country.etc, lat, long) %>%
  mutate(lab = c("Canine Performance Sciences, Auburn University",
                 "Canine Cognition Center, Boston College",
                 "The Family Dog Project, Eötvös Loránd University",
                 "Canid Behavior Research Group, National Scientific and Technical Research Council",
                 "Duke Canine Cognition Center, Duke University",
                 "Social Cognition Lab, Queen’s University",
                 # "Transylvania University",
                 "Canine Cognition and Human Interaction Lab, University of Nebraska-Lincoln ",
                 "Pet Behaviour Consulting, Università degli Studi di Messina",
                 "Canine Cognition Center, Yale University",
                 "Thinking Dog Center, Hunter College",
                 "Dog Cognition Centre, University of Portsmouth",
                 "Brown Dog Lab, Brown University",
                 "Comparative Cognitive Science Lab, University of Rijeka",
                 "Leader Dogs for the Blind",
                 "Canine Research Unit, Memorial University",
                 "Canine Companions",
                 "Arizona Canine Cognition Center, University of Arizona",
                 "The Clever Dog Lab, University of Veterinary Medicine Vienna",
                 "Department of Psychology of Individual Differences, University of Warsaw",
                 "Animal Health and Welfare Centre, University Centre Sparsholt",
                 "Comparative Cognition Lab, University of Manitoba"),
         .before = 1) #%>%
  # add_row(lab = "lab name", city = "city", country = "country", lat = 46.73, long = -117.17)


## Plot labs -------------------------------------------------

# geo styling
md1_labs <- list(
  scope = 'world',
  showland = TRUE,
  landcolor = toRGB("grey83"),
  subunitcolor = toRGB("white"),
  countrycolor = toRGB("white"),
  coastlinecolor = toRGB("white"),
  showlakes = FALSE,
  # lakecolor = toRGB("white"),
  showsubunits = FALSE,
  showcountries = TRUE,
  resolution = 50,
  lonaxis = list(
    showgrid = FALSE,
    gridwidth = 0.5,
    range = c(-130, 30),
    dtick = 5
  ),
  lataxis = list(
    showgrid = FALSE,
    gridwidth = 0.5,
    range = c(-45, 60),
    dtick = 5
  )
)

md1_labs_fig <- plot_geo(md1_cities, lat = ~lat, lon = ~long, size = 100) %>%
  add_markers(text = ~md1_cities$lab, hoverinfo = "text",
              marker=list(sizeref=0.5, sizemode="area")) %>%
  layout(geo = md1_labs, margin = list(t = 0, r = 0, b = 0, l = 0))

md1_labs_fig
# save_image(md1_labs_fig, "md1_labs.png")
# htmlwidgets::saveWidget(partial_bundle(md1_labs_fig), "md1_labs.html", selfcontained = FALSE, libdir = "lib")

# file.copy(from = "md1_labs.html", to = "../manydogsproject.github.io/_site/images/html/md1_labs.html", overwrite = TRUE)
# file.copy(from = "lib", to = "../manydogsproject.github.io/docs/images/html", overwrite = TRUE, recursive = TRUE)
# file.copy(from = "lib", to = "/home/jstevens/github/manydogsproject.github.io/_site/images/html", overwrite = TRUE, recursive = TRUE)



# MD Intro ----------------------------------------------------------------

mdintro_only <- world.cities %>%
  filter((name == "Cambridge" & country.etc == "USA") |
           (name == "Washington" & country.etc == "USA")) |>
  select(city = name, country = country.etc, lat, long) %>%
  mutate(lab = c("Harvard University",
                 "The George Washington University"),
         .before = 1)
mdintro_cities <- md1_cities |>
  bind_rows(mdintro_only)

mdintro_labs_fig <- plot_geo(mdintro_cities, lat = ~lat, lon = ~long, size = 100, width = 600) %>%
  add_markers(text = ~mdintro_cities$lab, marker=list(sizeref = 0.75, sizemode = "area")) %>%
  layout(geo = md1_labs, margin = list(t = 0, r = 0, b = 0, l = 0))
mdintro_labs_fig

# save_image(mdintro_labs_fig, "mdintro_labs.png", width = 1180, height = 800, scale = 1.2)

