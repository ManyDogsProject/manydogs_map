library(tidyverse)
library(maps)
library(plotly)


# Create data frame of lab cities -----------------------------------------

data("world.cities")
our_cities <- world.cities %>%
  filter((name == "Bloomington" & country.etc == "USA" & lat == 40.48) |
           (name == "Boston" & country.etc == "USA") |
           (name == "Corvallis" & country.etc == "USA") |
           (name == "Durham" & country.etc == "USA") |
           (name == "Lincoln" & country.etc == "USA" & lat == 40.82) |
           (name == "Messina" & country.etc == "Italy") |
           (name == "New Haven" & country.etc == "USA") |
           (name == "New York" & country.etc == "USA") |
           (name == "Padova" & country.etc == "Italy") |
           (name == "Portsmouth" & country.etc == "UK") |
           (name == "Providence" & country.etc == "USA") |
           (name == "Santa Rosa" & country.etc == "USA") |
           (name == "Tucson" & country.etc == "USA") |
           (name == "Vienna" & country.etc == "Austria") |
           # (name == "Washington" & country.etc == "USA") |
           (name == "Winchester" & country.etc == "UK") |
           (name == "Winnipeg" & country.etc == "Canada")
         # (name == "Pullman" & country.etc == "USA") |
  ) %>%
  select(city = name, country = country.etc, lat, long) %>%
  mutate(lab = c("IWU Dog Scientists, Illinois Wesleyan University", "Canine Cognition Center, Boston College", "Human-Animal Interaction Lab, Oregon State University", "Duke Canine Cognition Center, Duke University", "Canine Cognition and Human Interaction Lab, University of Nebraska-Lincoln ", "Pet Behaviour Consulting, Università degli Studi di Messina", "Canine Cognition Center, Yale University", "Thinking Dog Center, Hunter College", "DogUP, Università degli Studi di Padova", "Dog Cognition Centre, University of Portsmouth", "Brown Dog Lab, Brown University", "Canine Companions", "Arizona Canine Cognition Center, University of Arizona", "The Clever Dog Lab, University of Veterinary Medicine Vienna", "Animal Health and Welfare Centre, University Centre Sparsholt", "Comparative Cognition Lab, University of Manitoba"), .before = 1) %>%
  add_row(lab = "Laboratory for Comparative Ethnobiology, Washington State University", city = "Pullman", country = "USA", lat = 46.73, long = -117.17) %>%
  add_row(lab = "Canine Language Perception Lab, University of Maryland, College Park", city = "College Park", country = "USA", lat = 39.00, long = -76.93)




# Plot North America labs -------------------------------------------------

# geo styling
northamerica_labs <- list(
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
  projection = list(
    type = 'conic conformal',
    rotation = list(lon = -100)
  ),
  lonaxis = list(
    showgrid = FALSE,
    gridwidth = 0.5,
    range = c(-120, -65),
    dtick = 5
  ),
  lataxis = list(
    showgrid = FALSE,
    gridwidth = 0.5,
    range = c(25, 55),
    dtick = 5
  )
)

northamerica_fig <- plot_geo(our_cities, lat = ~lat, lon = ~long, size = 100) %>%
  add_markers(text = ~our_cities$lab, hoverinfo = "text",
              marker=list(sizeref=0.5, sizemode="area")) %>%
  layout(geo = northamerica_labs)

northamerica_fig
export(northamerica_fig, "na_labs.png")
# htmlwidgets::saveWidget(northamerica_fig, "na_labs.html")
htmlwidgets::saveWidget(partial_bundle(northamerica_fig), "na_labs.html", selfcontained = FALSE, libdir = "lib")



# Plot North America labs -------------------------------------------------

# geo styling
europe_labs <- list(
  scope = 'europe',
  showland = TRUE,
  landcolor = toRGB("grey83"),
  subunitcolor = toRGB("white"),
  countrycolor = toRGB("white"),
  showlakes = FALSE,
  # lakecolor = toRGB("white"),
  showsubunits = FALSE,
  showcountries = TRUE,
  resolution = 50,
  # projection = list(
  #   type = 'conic conformal',
  #   # rotation = list(lon = -100)
  # )
  lonaxis = list(
    showgrid = FALSE,
    # gridwidth = 0.5,
    range = c(-10, 20),
    dtick = 5
  ),
  lataxis = list(
    showgrid = FALSE,
    # gridwidth = 0.5,
    range = c(30, 60),
    dtick = 5
  )
)

europe_fig <- plot_geo(our_cities, lat = ~lat, lon = ~long, size = 100) %>%
  add_markers(text = ~our_cities$lab, hoverinfo = "text",
              marker=list(sizeref=0.5, sizemode="area")) %>%
  layout(geo = europe_labs)

europe_fig
export(europe_fig, "europe_labs.png")

# htmlwidgets::saveWidget(europe_fig, "europe_labs.html")
htmlwidgets::saveWidget(partial_bundle(europe_fig), "europe_labs.html", selfcontained = FALSE, libdir = "lib")


file.copy(from = "na_labs_small.html", to = "../manydogsproject.github.io/assets/html/na_labs.html", overwrite = TRUE)
file.copy(from = "europe_labs_small.html", to = "../manydogsproject.github.io/assets/html/europe_labs.html", overwrite = TRUE)
file.copy(from = "lib", to = "../manydogsproject.github.io/assets/html", overwrite = TRUE, recursive = TRUE)
