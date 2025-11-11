#' DIVINE's symptoms table
#'
#' Information on COVID-19 associated symptoms of patients included in the DIVINE cohort. Data was collected at hospital admission.
#'
#' @docType data
#' @keywords datasets
#' @usage data(symptoms)
#'
#'
#' @format A data frame with 5813 rows and 24 columns
#'  \describe{
#'   \item{record_id:}{Identifier of each record. This information does not match the real data.}
#'   \item{covid_wave:}{A factor with levels `Wave 1`, `Wave 2`, `Wave 3`, and `Wave 5`. COVID-19 wave.}
#'   \item{center:}{A factor with levels `Hospital A`, `Hospital B`, `Hospital C`, `Hospital D`, and             `Hospital E`. Center of admission}
#'   \item{symptoms_days:}{Days from symptoms onset to hospitalization}
#'   \item{rhinorrhea:}{A factor with levels `No` and `Yes`. Rhinorrhea}
#'   \item{anosmia:}{A factor with levels `No` and `Yes`. Anosmia}
#'   \item{ageusia:}{A factor with levels `No` and `Yes`. Ageusia}
#'   \item{arthromyalgia:}{A factor with levels `No` and `Yes`. Arthromyalgia}
#'   \item{odynophagia:}{A factor with levels `No` and `Yes`. Odynophagia}
#'   \item{fever:}{A factor with levels `No` and `Yes`. Fever}
#'   \item{cough:}{A factor with levels `No` and `Yes`. Cough}
#'   \item{dyspnea:}{A factor with levels `No` and `Yes`. Dyspnoea}
#'   \item{expectoration:}{A factor with levels `No` and `Yes`. Expectoration}
#'   \item{diarrhea:}{A factor with levels `No` and `Yes`. Diarrhea}
#'   \item{vomit:}{A factor with levels `No` and `Yes`. Vomiting}
#'   \item{nausea:}{A factor with levels `No` and `Yes`. Nausea}
#'   \item{asthenia:}{A factor with levels `No` and `Yes`. Asthenia}
#'   \item{anorexia:}{A factor with levels `No` and `Yes`. Anorexia}
#'   \item{cephal:}{A factor with levels `No` and `Yes`. Headache}
#'   \item{chest_pain:}{A factor with levels `No` and `Yes`. Chest pain}
#'   \item{abdominal_pain:}{A factor with levels `No` and `Yes`. Abdominal pain}
#'   \item{confusional_syndrome:}{A factor with levels `No` and `Yes`. Confusional syndrome}
#'   \item{shock_admission:}{A factor with levels `No` and `Yes`. Shock on admission}
#'   \item{bacterial_infection:}{A factor with levels `No` and `Yes`. Bacterial infection}
#' }
#'
#' @references
#' Pallarès, N., Tebé, C., Abelenda-Alonso, G., Rombauts, A., Oriol, I., Simonetti, A. F., Rodríguez-Molinero, A., Izquierdo, E., Díaz-Brito, V., Molist, G., Gómez Melis, G., Carratalà, J., Videla, S., & MetroSud and Divine study groups (2023). Characteristics and Outcomes by Ceiling of Care of Subjects Hospitalized with COVID-19 During Four Waves of the Pandemic in a Metropolitan Area: A Multicenter Cohort Study. Infectious diseases and therapy, 12(1), 273–289. https://doi.org/10.1007/s40121-022-00705-w
#'
#'
"symptoms"
