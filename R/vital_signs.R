#' DIVINE's table on vital signs
#'
#' Information on vital signs of patients included in the DIVINE cohort. Data was collected at hospital admission.
#'
#' @docType data
#' @keywords datasets
#' @usage data(vital_signs)
#'
#'
#' @format A data frame with 5813 rows and 13 columns
#'  \describe{
#'   \item{record_id:}{Identifier of each record. This information does not match the real data.}
#'   \item{covid_wave:}{A factor with levels `Wave 1`, `Wave 2`, `Wave 3`, and `Wave 5`. COVID-19 wave.}
#'   \item{center:}{A factor with levels `Hospital A`, `Hospital B`, `Hospital C`, `Hospital D`, and `Hospital E`. Center of admission}
#'   \item{temperature:}{Human body temperature (ºC)}
#'   \item{fio2_contributed:}{Fraction of inspired oxygen (%)}
#'   \item{syst_blood_press:}{Systolic blood pressure (mmHg)}
#'   \item{diast_blood_press:}{Diastolic blood pressure (mmHg)}
#'   \item{saturation:}{Oxygen saturation (%)}
#'   \item{cardiac_freq:}{Heart rate (bpm)}
#'   \item{supporto2:}{A factor with levels `No` and `Yes`. Oxygen Support}
#'   \item{normal_radio:}{A factor with levels `No` and `Yes`. Normal X-ray}
#'   \item{pleural_effusion:}{A factor with levels `No` and `Yes`. Pleural effusion}
#'   \item{saturation_fio2:}{Oxygen Saturation to FiO2 Ratio}
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
"vital_signs"
