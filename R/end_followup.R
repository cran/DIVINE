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
#'   \item{exitus:}{A factor with levels `No` and `Yes`. Did the patient die during hospital admission?}
#'   \item{exitus_days:}{Days from hospital admission to exitus}
#'   \item{discharge:}{A factor with levels `No` and `Yes`. Was the patient discharge from the hospital?}
#'   \item{discharge_days:}{Days from hospital admission to discharge}
#' }
#'
#' @references
#' Pallarès, N., Carmezim, J., Rodríguez-Molinero, A., Coloma, A., Izquierdo, E.,
#' Díaz-Brito, V., Videla, S., Carratalà, J., Gómez-Melis, G., & Tebé, C. (2026).
#' A multicenter COVID-19 database from four waves in the south metropolitan area
#' of Barcelona, Catalonia. Scientific Data, 13(1), 1228.
#' \doi{10.1038/s41597-026-07479-7}
#'
#'
"end_followup"
