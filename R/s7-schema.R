# s7-schema.R
# S7 classes representing the IntChron schema (v2)
# https://intchron.org/schema.html

#' @noRd
#' @keywords internal
Compilation = new_class("Compilation", properties = list(
  by = class_character,
  orcid = class_character,
  url = class_character,
  updated = class_character, # TODO: datetime
  retrieved = class_character # not in schema, TODO: datetime
))

#' @noRd
#' @keywords internal
Object <- new_class(
  "Object",
  properties = list(
    compilation = Compilation,
    data_url = class_character,
    schema = class_character
  ),
  constructor = function (compilation = Compilation(), data_url = character(0),
                          schema = character(0)) {
    if (rlang::is_list(compilation)) {
      compilation <- do.call(Compilation, compilation)
    }
    new_object(S7_object(), compilation = compilation, data_url = data_url,
               schema = schema)
  }
)


# PROJECT OBJECTS ---------------------------------------------------------
# Records or series embedded in a project

ProjectObject <- new_class("ProjectObject", parent = Object, properties = list(
  file = class_character,
  file_data = class_list, # TODO: of data frames, if we assume always rectangular?
  selected = class_logical,
  changed = class_logical
))

#' @noRd
#' @keywords internal
ProjectRecord <- new_class("ProjectRecord", parent = ProjectObject, properties = list(
  site = class_character,
  country = class_character,
  longitude = class_numeric,
  latitude = class_numeric,
  elevation = class_numeric,
  site_type = class_character,
  record = class_character,
  color = class_character
))

#' @noRd
#' @keywords internal
ProjectSeries <- new_class("ProjectSeries", parent = ProjectObject, properties = list(
  project_series_type = class_character,
  series = class_character
))


# BIBLIOGRAPHY ------------------------------------------------------------

#' @noRd
#' @keywords internal
Bibliography <- new_class(
  "Bibliography",
  properties = list(
    schema = class_character,
    ref = class_character,       # Citation key
    reference = class_character, # Full reference as text
    citation = class_character,  # Citation (author-year) as text
    data = class_list            # BibTeX attributes
  ),
  constructor = function (
    schema = character(0), ref = character(0), reference = character(0),
    citation = character(0), ...
  ) {
    data <- rlang::dots_list(
      ...,
      .named = TRUE,
      .ignore_empty = "none",
      .preserve_empty = TRUE,
      .homonyms = "error",
      .check_assign = FALSE
    )
    new_object(S7_object(), schema = schema, ref = ref, reference = reference,
               citation = citation, data = data)
  }
)


# PROJECTS ----------------------------------------------------------------

#' @noRd
#' @keywords internal
Project <- new_class(
  "Project",
  parent = Object,
  properties = list(
    json_application = class_character,
    records = ProjectRecord,
    project_series_list = ProjectSeries,
    parameters = class_list,
    bibliography = Bibliography
  ),
  constructor = function (
    compilation = Compilation(), data_url = character(0), schema = character(0),
    json_application = character(0), records = ProjectRecord(),
    project_series_list = ProjectSeries(), parameters = list(),
    bibliography = Bibliography()
  ) {
    if (rlang::is_list(records)) records <- do.call(ProjectRecord, records)
    if (rlang::is_list(project_series_list)) {
      project_series_list <- do.call(ProjectSeries, project_series_list)
    }
    if (rlang::is_list(bibliography)) {
      bibliography <- do.call(Bibliography, bibliography)
    }
    new_object(Object(compilation = compilation, data_url = data_url, schema = schema),
               json_application = json_application, records = records,
               project_series_list = project_series_list, parameters = parameters,
               bibliography = bibliography)
  }
)


# SERIES ------------------------------------------------------------------
# Standalone series (not embedded in a project)

Series <- new_class("Series", properties = list(
  json_application = class_character,
  project_series_type = class_character,
  type =class_character,
  parameter_list = class_character,
  refs = class_character,
  data = class_list # TODO: of data frames, if we assume this is always rectangular?
))


# RECORDS -----------------------------------------------------------------
# Standalone records (not embedded in a project)

#' @noRd
#' @keywords internal
Record <- new_class("Record", parent = Object, properties = list(
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

