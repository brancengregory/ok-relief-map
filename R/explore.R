library(elevatr)
library(raster)
library(sf)
library(rayshader)
library(crsuggest)
library(rgdal)
library(tigris)
library(dplyr)
library(magick)

# coords <- data.frame(
#   x = c(33.615833, 37.002206),
#   y = c(-103.002565, -94.430662)
# )
#
# elev <- coords |>
#   st_as_sf(coords = c("x", "y"), crs = 2267) |>
#   get_elev_raster(z = 12)
#
# elev_mat <- raster_to_matrix(elev)
#
# elev_mat |>
#   sphere_shade() |>
#   plot_map()

# Oklahoma shapefile ----
ok_shape <- states(cb = F) |>
  filter(NAME == "Oklahoma")

elev_ok <- ok_shape |>
  get_elev_raster(z = 8)

elev_ok_shaped <- crop(
  elev_ok,
  extent(ok_shape)
)

elev_ok_shaped <- mask(
  elev_ok_shaped,
  ok_shape
)

elev_ok_mat <- raster_to_matrix(elev_ok_shaped)

# elev_ok_mat |>
#   sphere_shade() |>
#   plot_map()

elev_ok_mat |>
  sphere_shade(texture = "bw", zscale = 8) |>
  add_water(
    detect_water(elev_ok_mat)
  ) |>
  #add_shadow(ray_shade(elev_ok_mat)) |>
  plot_map(title_text = "Oklahoma")
  # plot_3d(heightmap = elev_ok_mat,
  #         solid = TRUE, shadow = FALSE)



