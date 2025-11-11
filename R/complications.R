#' DIVINE's table on complications data
#'
#' Information on complications data of patients included in the DIVINE cohort. Data was collected during hospitalization.
#'
#' @docType data
#' @keywords datasets
#' @usage data(complications)
#'
#'
#' @format A data frame with 5813 rows and 9 columns
#'  \describe{
#'   \item{record_id:}{Identifier of each record. This information does not match the real data.}
#'   \item{covid_wave:}{A factor with levels `Wave 1`, `Wave 2`, `Wave 3`, and `Wave 5`. COVID-19 wave.}
#'   \item{center:}{A factor with levels `Hospital A`, `Hospital B`, `Hospital C`, `Hospital D`, and  `Hospital E`. Center of admission}
#'   \item{comp:}{A factor with levels `No` and `Yes`. Did the patient experiment a complication while hospitalised?}
#'   \item{kidney_failure:}{A factor with levels `No` and `Yes`. Did the patient experiment kidney failure during hospital admission?}
#'   \item{mental_status_change:}{A factor with levels `No` and `Yes`. Did the patient experiment a change in its mental status during hospital admission?}
#'   \item{nosocomial_infection:}{A factor with levels `No` and `Yes`. Did the patient experiment a nosocomial infection during hospital admission?}
#'   \item{comp_cardiac:}{A factor with levels `No` and `Yes`. Did the patient experiment a cardiac complication during hospital admission? Cardiac complications included heart failure and acute coronary event.}
#'   \item{comp_respiratory:}{A factor with levels `No` and `Yes`. Did the patient experiment a respiratory complication during hospital admission? Respiratory complications included acute respiratory failure, venous thromboembolism, and pneumonia.}
#' }
#'
#' @references
#' Pallarès, N., Tebé, C., Abelenda-Alonso, G., Rombauts, A., Oriol, I., Simonetti, A. F., Rodríguez-Molinero, A., Izquierdo, E., Díaz-Brito, V., Molist, G., Gómez Melis, G., Carratalà, J., Videla, S., & MetroSud and Divine study groups (2023). Characteristics and Outcomes by Ceiling of Care of Subjects Hospitalized with COVID-19 During Four Waves of the Pandemic in a Metropolitan Area: A Multicenter Cohort Study. Infectious diseases and therapy, 12(1), 273–289. https://doi.org/10.1007/s40121-022-00705-w
#'
#'
"complications"
