# s7-schema.R
# S7 classes representing the IntChron schema (v2)
# https://intchron.org/schema.html

#' @noRd
#' @keywords internal
Series <- new_class("Series", properties = list(
  schema = class_character, # alias for json_application
  series = class_character,
  type = class_character,
  parameter_list = class_character,
  refs = class_character,
  data = class_list # TODO: of data frames, if we assume this is always rectangular?
))

#' @noRd
#' @keywords internal
Record <- new_class("Record", properties = list(
  schema = class_character, # alias for json_application
  site = class_character,
  region = class_character,
  country = class_character,
  longitude = class_character,
  latitude = class_character,
  elevation = class_character,
  site_type = class_character,
  record = class_character,
  color = class_character,
  z_type = class_character,
  z_basis = class_character,
  z_units = class_character,
  t_source = class_character,
  suppress_t = class_character,
  suppress_z = class_character,
  record_comment = class_character,
  series_list = Series,
  refs = class_character
))

#' @noRd
#' @keywords internal
Bibliography <- new_class("Bibliography", properties = list(
  ref = class_character,       # Citation key
  reference = class_character, # Full reference as text
  citation = class_character,  # Citation (author-year) as text
  year  = class_character,
  title = class_character,
  author = class_character,
  editor = class_character,
  booktitle = class_character,
  journal = class_character,
  volume = class_character,
  edition = class_character,
  number = class_character,
  series = class_character,
  chapter = class_character,
  pages = class_character,
  publisher = class_character,
  organization = class_character,
  school = class_character,
  institution = class_character,
  address = class_character,
  url = class_character,
  doi = class_character,
  isbn = class_character
))

#' @noRd
#' @keywords internal
Project <- new_class("Project", properties = list(
  schema = class_character, # alias for json_application
  records = Record,
  project_series_list = Series,
  parameters = class_list,
  bibliography = Bibliography
))
