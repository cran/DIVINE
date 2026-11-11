#' DIVINE's table on treatments previous to hospital admission
#'
#' Information on previous treatments for patients included in the DIVINE cohort. Data was collected at hospital admission.
#'
#' @docType data
#' @keywords datasets
#' @usage data(concomitant_medication)
#'
#'
#' @format A data frame with 5813 rows and 11 columns
#'  \describe{
#'   \item{record_id:}{Identifier of each record. This information does not match the real data.}
#'   \item{covid_wave:}{A factor with levels `Wave 1`, `Wave 2`, `Wave 3`, and `Wave 5`. COVID-19 wave.}
#'   \item{center:}{A factor with levels `Hospital A`, `Hospital B`, `Hospital C`, `Hospital D`, and `Hospital E`. Center of admission}
#'   \item{statins_pre:}{A factor with levels `No` and `Yes`. Previous treatment with statins}
#'   \item{cortis_pre:}{A factor with levels `No` and `Yes`. Previous treatment with corticosteroids}
#'   \item{acei_pre:}{A factor with levels `No` and `Yes`. Previous treatment with angiotensin-converting enzyme (ACE) inhibitors}
#'   \item{ara2_pre:}{A factor with levels `No` and `Yes`. Previous treatment with angiotensin II receptor antagonists (ARA-II)}
#'   \item{cortis_systemic_pre:}{A factor with levels `No` and `Yes`. Routine treatment with systemic corticosteroids}
#'   \item{cortis_inhaled_pre:}{A factor with levels `No` and `Yes`. Routine treatment with inhaled corticosteroids}
#'   \item{anticoagulants_pre:}{A factor with levels `No` and `Yes`. Previous treatment with anticoagulants}
#'   \item{immunosuppre_pre:}{A factor with levels `No` and `Yes`. Previous treatment with immunosuppressants}
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
"concomitant_medication"
