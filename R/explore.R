library(elevatr)
library(raster)
library(sf)
library(rayshader)
library(crsuggest)

coords <- data.frame(
  x = c(33.615833, 37.002206),
  y = c(-103.002565, -94.430662)
)

elev <- coords |>
  st_as_sf(coords = c("x", "y"), crs = 2267) |>
  get_elev_raster(z = 12)

elev_mat <- raster_to_matrix(elev)

elev_mat |>
  sphere_shade() |>
  plot_map()
