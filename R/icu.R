#' DIVINE's table on icu data
#'
#' Information on ICU data of patients included in the DIVINE cohort. Data was collected during hospitalization.
#'
#' @docType data
#' @keywords datasets
#' @usage data(icu)
#'
#'
#' @format A data frame with 5813 rows and 12 columns
#'  \describe{
#'   \item{record_id:}{Identifier of each record. This information does not match the real data.}
#'   \item{covid_wave:}{A factor with levels `Wave 1`, `Wave 2`, `Wave 3`, and `Wave 5`. COVID-19 wave.}
#'   \item{center:}{A factor with levels `Hospital A`, `Hospital B`, `Hospital C`, `Hospital D`, and  `Hospital E`. Center of admission}
#'   \item{icu:}{A factor with levels `No` and `Yes`. Was the patient admitted to the ICU?}
#'   \item{icu_enter_days:}{Days from hospital admission to ICU admission.}
#'   \item{icu_exit_days:}{Days from hospital admission to ICU discharge.}
#'   \item{vent_mec:}{A factor with levels `No` and `Yes`. Did the patient received invasive mechanical ventilation?}
#'   \item{vent_mec_start_days:}{Days from hospital admission to start of invasive mechanical ventilation.}
#'   \item{vent_mec_end_days:}{Days from hospital admission to end of invasive mechanical ventilation.}
#'   \item{vent_mec_no_inv:}{A factor with levels `No` and `Yes`. Did the patient received non-invasive mechanical ventilation?}
#'   \item{vent_mec_no_inv_start_days:}{Days from hospital admission to start of non-invasive mechanical ventilation.}
#'   \item{vent_mec_no_inv_end_days:}{Days from hospital admission to end of non-invasive mechanical ventilation.}
#' }
#'
#' @references
#' Pallarès, N., Tebé, C., Abelenda-Alonso, G., Rombauts, A., Oriol, I., Simonetti, A. F., Rodríguez-Molinero, A., Izquierdo, E., Díaz-Brito, V., Molist, G., Gómez Melis, G., Carratalà, J., Videla, S., & MetroSud and Divine study groups (2023). Characteristics and Outcomes by Ceiling of Care of Subjects Hospitalized with COVID-19 During Four Waves of the Pandemic in a Metropolitan Area: A Multicenter Cohort Study. Infectious diseases and therapy, 12(1), 273–289. https://doi.org/10.1007/s40121-022-00705-w
#'
#'
"icu"
