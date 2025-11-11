#' DIVINE's vaccine table
#'
#' Information on COVID-19 vaccines of patients included in the DIVINE cohort. Data was collected at hospital admission and it is available for waves 3 and 5 (patients were not yet vaccinated in waves 1 and 2).
#'
#' @docType data
#' @keywords datasets
#' @usage data(vaccine)
#'
#'
#' @format A data frame with 5813 rows and 6 columns
#'  \describe{
#'   \item{record_id:}{Identifier of each record. This information does not match the real data.}
#'   \item{covid_wave:}{A factor with levels `Wave 1`, `Wave 2`, `Wave 3`, and `Wave 5`. COVID-19 wave.}
#'   \item{center:}{A factor with levels `Hospital A`, `Hospital B`, `Hospital C`, `Hospital D`, and `Hospital E`. Center of admission}
#'   \item{vaccine:}{A factor with levels `No`, `Yes` and `Not applicable` (for patients included in waves before vaccination started). Is the patient vaccinated for COVID-19?}
#'   \item{complete_vaccine:}{A factor with levels `No`, `Partial`, `Complete` and `Not applicable` (for patients included in waves before vaccination started). Is the patient partially vaccinated (one dose of two-dose vaccines), completely vaccinated (one dose for one-dose vaccines or two doses for two-dose vaccines) or not vaccinated at all?}
#'   \item{immune_vaccine:}{A factor with levels `No immunity`, `Partial immunity`, `Total immunity` and `Not applicable` (for patients included in waves before vaccination started). Defines the level of immunity of the patient: not vaccinated (`No immunity`), vaccinated with only one dose for two-dose vaccines (`Partial immunity`), vaccinated with two doses but less than 7 days have passed since the second dose (`Partial immunity`) or vaccinated with all the doses and more than 7 days have passed since the second dose (`Total immunity`)}
#' }
#'
#' @references
#' Pallarès, N., Tebé, C., Abelenda-Alonso, G., Rombauts, A., Oriol, I., Simonetti, A. F., Rodríguez-Molinero, A., Izquierdo, E., Díaz-Brito, V., Molist, G., Gómez Melis, G., Carratalà, J., Videla, S., & MetroSud and Divine study groups (2023). Characteristics and Outcomes by Ceiling of Care of Subjects Hospitalized with COVID-19 During Four Waves of the Pandemic in a Metropolitan Area: A Multicenter Cohort Study. Infectious diseases and therapy, 12(1), 273–289. https://doi.org/10.1007/s40121-022-00705-w
#'
#'
"vaccine"
