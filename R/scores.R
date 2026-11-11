#' DIVINE's table on severity scores at hospital admission
#'
#' Information on severity scores at hospital admission for patients included in the DIVINE cohort. Data was collected at hospital admission.
#'
#' @docType data
#' @keywords datasets
#' @usage data(scores)
#'
#'
#' @format A data frame with 5813 rows and 10 columns
#'  \describe{
#'   \item{record_id:}{Identifier of each record. This information does not match the real data.}
#'   \item{covid_wave:}{A factor with levels `Wave 1`, `Wave 2`, `Wave 3`, and `Wave 5`. COVID-19 wave.}
#'   \item{center:}{A factor with levels `Hospital A`, `Hospital B`, `Hospital C`, `Hospital D`, and `Hospital E`. Center of admission}
#'   \item{psi:}{Pneumonia severity index (PSI) at hospital admission}
#'   \item{group_psi:}{A factor with levels `1`, `2`, `3`, and `4`. PSI group}
#'   \item{curb65:}{CURB65 score at hospital admission}
#'   \item{group_curb65:}{A factor with levels `1`, `2`, and `3`. CURB65 group}
#'   \item{mulbsta:}{MULBSTA score at hospital admission}
#'   \item{group_mulbsta:}{A factor with levels `Low-risk` and `High-risk`. MULBSTA group}
#'   \item{rox_index:}{ROX index at hospital admission}
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
"scores"
