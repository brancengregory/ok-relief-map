library(rayshader)
library(tigris)
library(dplyr)
library(elevatr)

# Oklahoma shapefile ----
ok_shape <- states(cb = F) |>
  filter(NAME == "Oklahoma")

elev_ok <- ok_shape |>
  get_elev_raster(
    z = 8,
    clip = "locations"
  )

ok_mat <- raster_to_matrix(elev_ok)

ok_map <- ok_mat |>
  sphere_shade() |>
  add_water(
    detect_water(ok_mat)
  ) |>
  add_shadow(ray_shade(ok_mat,lambert=FALSE)) |>
  add_shadow(lamb_shade(ok_mat)) |>
  add_shadow(ambient_shade(ok_mat))

ok_map |>
  plot_map()
