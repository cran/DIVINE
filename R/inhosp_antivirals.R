#' DIVINE's table on antivirals received during hospitalization
#'
#' Information on antivirals for patients included in the DIVINE cohort. Data was collected during hospitalization.
#'
#' @docType data
#' @keywords datasets
#' @usage data(inhosp_antivirals)
#'
#'
#' @format A data frame with 5813 rows and 10 columns
#'  \describe{
#'   \item{record_id:}{Identifier of each record. This information does not match the real data.}
#'   \item{covid_wave:}{A factor with levels `Wave 1`, `Wave 2`, `Wave 3`, and `Wave 5`. COVID-19 wave.}
#'   \item{center:}{A factor with levels `Hospital A`, `Hospital B`, `Hospital C`, `Hospital D`, and `Hospital E`. Center of admission}
#'   \item{any_antiviral:}{A factor with levels `No` and `Yes`. Did the patient receive treatment with antivirals during hospital admission?}
#'   \item{hydroxychloroquine:}{A factor with levels `No` and `Yes`. Treatment with hydroxychloroquine}
#'   \item{interferon_b:}{A factor with levels `No` and `Yes`. Treatment with interferon beta}
#'   \item{kaletra_ritonavir_lopinavir:}{A factor with levels `No` and `Yes`. Treatment with kaletra/ritonavir-lopinavir}
#'   \item{remdesivir:}{A factor with levels `No` and `Yes`. Treatment with remdesivir}
#'   \item{tocilizumab:}{A factor with levels `No` and `Yes`. Treatment with tocilizumab}
#'   \item{other_antiviral:}{A factor with levels `No` and `Yes`. Treatment with another antiviral}
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
"inhosp_antivirals"
