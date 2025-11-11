#' DIVINE's table on laboratory data
#'
#' Information on laboratory data of patients included in the DIVINE cohort. Data was collected at hospital admission.
#'
#' @docType data
#' @keywords datasets
#' @usage data(analytics)
#'
#'
#' @format A data frame with 5813 rows and 9 columns
#'  \describe{
#'   \item{record_id:}{Identifier of each record. This information does not match the real data.}
#'   \item{covid_wave:}{A factor with levels `Wave 1`, `Wave 2`, `Wave 3`, and `Wave 5`. COVID-19 wave.}
#'   \item{center:}{A factor with levels `Hospital A`, `Hospital B`, `Hospital C`, `Hospital D`, and             `Hospital E`. Center of admission}
#'   \item{analytics_available:}{Is there an analytic available for this patient?}
#'   \item{total_leukocytes:}{Total leukocytes (mil/mm³)}
#'   \item{hemoglobin:}{Hemoglobin (g/dl)}
#'   \item{total_lymphocytes:}{Total lymphocytes (mil/mm³)}
#'   \item{d_dimer:}{D-dimer (µg/L)}
#'   \item{c_reactive_protein:}{C-reactive protein (mg/L)}
#' }
#'
#' @references
#' Pallarès, N., Tebé, C., Abelenda-Alonso, G., Rombauts, A., Oriol, I., Simonetti, A. F., Rodríguez-Molinero, A., Izquierdo, E., Díaz-Brito, V., Molist, G., Gómez Melis, G., Carratalà, J., Videla, S., & MetroSud and Divine study groups (2023). Characteristics and Outcomes by Ceiling of Care of Subjects Hospitalized with COVID-19 During Four Waves of the Pandemic in a Metropolitan Area: A Multicenter Cohort Study. Infectious diseases and therapy, 12(1), 273–289. https://doi.org/10.1007/s40121-022-00705-w
#'
#'
"analytics"
