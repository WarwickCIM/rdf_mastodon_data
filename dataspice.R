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

df_locations <- photon::geocode(df$ip_country, limit = 1, key = "place")

# South/North boundaries
boundaries_ns <- range(df_locations$lat)

# West/East boundaries
boundaries_we <- range(df_locations$lon)

edit_biblio()


# Attributes --------------------------------------------------------------

prep_attributes()

edit_attributes()


# Create spice ------------------------------------------------------------

write_spice()

# Create site -------------------------------------------------------------


build_site() # Optional

build_site(template_path = "templates/custom_dataspice_template.Rhtml")
