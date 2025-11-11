#' DIVINE's table on closure data
#'
#' Information on closure data of patients included in the DIVINE cohort. Data was collected at the end of hospitalization.
#'
#' @docType data
#' @keywords datasets
#' @usage data(end_followup)
#'
#'
#' @format A data frame with 5813 rows and 8 columns
#'  \describe{
#'   \item{record_id:}{Identifier of each record. This information does not match the real data.}
#'   \item{covid_wave:}{A factor with levels `Wave 1`, `Wave 2`, `Wave 3`, and `Wave 5`. COVID-19 wave.}
#'   \item{center:}{A factor with levels `Hospital A`, `Hospital B`, `Hospital C`, `Hospital D`, and  `Hospital E`. Center of admission}
#'   \item{clinical_stability_days:}{Days from hospital admission to clinical stability}
#'   \item{exitus_days:}{Days from hospital admission to exitus}
#'   \item{discharge_days:}{Days from hospital admission to discharge}
#'   \item{discharge:}{A factor with levels `No` and `Yes`. Was the patient discharge from the hospital?}
#'   \item{exitus:}{A factor with levels `No` and `Yes`. Did the patient die during hospital admission?}
#' }
#'
#' @references
#' Pallarès, N., Tebé, C., Abelenda-Alonso, G., Rombauts, A., Oriol, I., Simonetti, A. F., Rodríguez-Molinero, A., Izquierdo, E., Díaz-Brito, V., Molist, G., Gómez Melis, G., Carratalà, J., Videla, S., & MetroSud and Divine study groups (2023). Characteristics and Outcomes by Ceiling of Care of Subjects Hospitalized with COVID-19 During Four Waves of the Pandemic in a Metropolitan Area: A Multicenter Cohort Study. Infectious diseases and therapy, 12(1), 273–289. https://doi.org/10.1007/s40121-022-00705-w
#'
#'
"end_followup"
