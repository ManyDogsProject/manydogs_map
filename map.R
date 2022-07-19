library(tidyverse)
library(maps)
library(plotly)


# Create data frame of lab cities -----------------------------------------

data("world.cities")
our_cities <- world.cities %>%
  filter((name == "Bloomington" & country.etc == "USA" & lat == 40.48) |
           (name == "Boston" & country.etc == "USA") |
           (name == "Buenos Aires" & country.etc == "Argentina") |
           (name == "Durham" & country.etc == "USA") |
           (name == "Kingston" & country.etc == "Canada") |
           (name == "Lincoln" & country.etc == "USA" & lat == 40.82) |
           (name == "Messina" & country.etc == "Italy") |
           (name == "New Haven" & country.etc == "USA") |
           (name == "New York" & country.etc == "USA") |
           (name == "Portsmouth" & country.etc == "UK") |
           (name == "Providence" & country.etc == "USA") |
           (name == "Rijeka" & country.etc == "Croatia") |
           (name == "Santa Rosa" & country.etc == "USA") |
           (name == "Tucson" & country.etc == "USA") |
           (name == "Vienna" & country.etc == "Austria") |
           (name == "Warsaw" & country.etc == "Poland") |
           (name == "Winchester" & country.etc == "UK") |
           (name == "Winnipeg" & country.etc == "Canada")
  ) %>%
  select(city = name, country = country.etc, lat, long) %>%
  mutate(lab = c("IWU Dog Scientists, Illinois Wesleyan University",
                 "Canine Cognition Center, Boston College",
                 "Canid Behavior Research Group, National Scientific and Technical Research Council",
                 "Duke Canine Cognition Center, Duke University",
                 "Social Cognition Lab, Queen’s University",
                 "Canine Cognition and Human Interaction Lab, University of Nebraska-Lincoln ",
                 "Pet Behaviour Consulting, Università degli Studi di Messina",
                 "Canine Cognition Center, Yale University",
                 "Thinking Dog Center, Hunter College",
                 "Dog Cognition Centre, University of Portsmouth",
                 "Brown Dog Lab, Brown University",
                 "Comparative Cognitive Science Lab, University of Rijeka",
                 "Canine Companions",
                 "Arizona Canine Cognition Center, University of Arizona",
                 "The Clever Dog Lab, University of Veterinary Medicine Vienna",
                 "Department of Psychology of Individual Differences, University of Warsaw",
                 "Animal Health and Welfare Centre, University Centre Sparsholt",
                 "Comparative Cognition Lab, University of Manitoba"),
         .before = 1) #%>%
  # add_row(lab = "lab name", city = "city", country = "country", lat = 46.73, long = -117.17)


# Plot all labs -------------------------------------------------

# geo styling
all_labs <- list(
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
    range = c(-130, 40),
    dtick = 5
  ),
  lataxis = list(
    showgrid = FALSE,
    gridwidth = 0.5,
    range = c(-55, 60),
    dtick = 5
  )
)

labs_fig <- plot_geo(our_cities, lat = ~lat, lon = ~long, size = 100) %>%
  add_markers(text = ~our_cities$lab, hoverinfo = "text",
              marker=list(sizeref=0.5, sizemode="area")) %>%
  layout(geo = all_labs)

labs_fig
save_image(labs_fig, "all_labs.png")
htmlwidgets::saveWidget(partial_bundle(labs_fig), "all_labs.html", selfcontained = FALSE, libdir = "lib")

file.copy(from = "all_labs.html", to = "../manydogsproject.github.io/assets/html/all_labs.html", overwrite = TRUE)
file.copy(from = "lib", to = "../manydogsproject.github.io/assets/html", overwrite = TRUE, recursive = TRUE)

