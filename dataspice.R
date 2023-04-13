library(dataspice)

df <- read.csv("data/responses_anonymised.csv")


create_spice()
# Then fill in template CSV files, more on this below


# Creators ----------------------------------------------------------------

edit_creators()


# Access ------------------------------------------------------------------

# prep_access()

edit_access()


# Biblio ------------------------------------------------------------------

range(df$recorded_date) 

# Get boundaries
# locations <- as.factor(paste0(df$ip_city, ", ", df$ip_country))
locations <- levels(as.factor(df$ip_country))

df_locations <- photon::geocode(locations, limit = 1, key = "place")

# South/North boundaries
boundaries_ns <- range(df_locations$lat)

# West/East boundaries
boundaries_we <- range(df_locations$lon)



df_biblio <- read.csv("data/metadata/biblio.csv")

df_biblio$description <- paste(
  "Survey aimed at understanding peoples' motivations to join Mastodon as well as their current experience and future usage.",
  "The dataset contains",
  nrow(df), "responses and", ncol(df), "variables."
)

df_biblio$startDate <- "2023-02-18"
df_biblio$endDate <- as.Date(max(df$end_date))
df_biblio$funder <- "University of Warwick (Research Development Fund 2022/23)"
df_biblio$northBoundCoord <- round(boundaries_ns[2], 2)
df_biblio$southBoundCoord <- round(boundaries_ns[1], 2)
df_biblio$eastBoundCoord <- round(boundaries_we[2], 2)
df_biblio$westBoundCoord <- round(boundaries_we[1], 2)

write.csv(df_biblio, file = "data/metadata/biblio.csv", row.names = FALSE)

edit_biblio()


# Attributes --------------------------------------------------------------

prep_attributes()

edit_attributes()


# Create spice ------------------------------------------------------------

write_spice()

# Create site -------------------------------------------------------------


build_site() # Optional

build_site(template_path = "templates/custom_dataspice_template.html")
